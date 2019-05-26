//
//  ViewController.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 01/09/18.
//  MIT License
//
//  Copyright (c) 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit
import Speech
import AVFoundation

//Clase vista principal del sistema.
class ViewController: UIViewController, SFSpeechRecognizerDelegate, SFSpeechRecognitionTaskDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var capaDegradado: UIView!
    @IBOutlet weak var spinnerView: UIView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    private var user_id: Int!
    
    internal var mensajes: [Globos] = []
    private let audioEngine = AVAudioEngine()
    private let synthesizer = AVSpeechSynthesizer()
    private let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var isRecording = false
    private var voice: AVSpeechSynthesisVoice!
    private var player: AVAudioPlayer?
    private var timer: Timer!
    private var botText: String = ""
    private var utteranceRate: Float = 0.5
    private var trascribir: Bool = true
    private var contraste: Bool = false

    //Función de inicialización de la vista.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Inicializa los delegados de la tabla de globos de mensaje.
        tableView.delegate = self
        tableView.dataSource = self
        
        //Dimensiones para permitir una carga de mensajes de tamaño dinámico en función del contenido.
        tableView.estimatedRowHeight = 170.0
        tableView.rowHeight = UITableView.automaticDimension
        
        //Sincroniza la aplicación con los ajustes seleccionados por el usuario a través de los ajustes establecidos en la app "Ajustes" de iOS.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
        
        //Para cuando un usuario pulsa en un libro de la lista de libros.
        NotificationCenter.default.addObserver(self, selector: #selector(self.prepararConsulta(_:)), name: NSNotification.Name(rawValue: "view1Tapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.prepararConsulta(_:)), name: NSNotification.Name(rawValue: "view2Tapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.prepararConsulta(_:)), name: NSNotification.Name(rawValue: "view3Tapped"), object: nil)
        
        if (contraste) {
            self.altoContraste()
        }
        
        //Carga el identificador único del usuario.
        let defaults = UserDefaults.standard
        self.user_id = Int(defaults.string(forKey: "user_id") ?? "-1")
        
        //Prepara el spinner para cuando el usuario envía una consulta al servidor.
        self.prepararSpinner()
        
        //Establece el primer mensaje al ejecutar la aplicación.
        mensajes.append(Globos(texto: "Hola! Soy Janet. ¿En qué te puedo ayudar?", emisor: .Bot))
        
        //Si el usuario no ha deshabilitado el habla, inicializa el transcriptor de texto a voz del sistema.
        if (trascribir) {
            inicializarVoz()
        }
        self.leerFrase(texto: mensajes[0].getRespuesta())
        
        //Inserta el primer mensaje en el sistema.
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: self.mensajes.count-1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
        
        startButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        comprobarPermisosReconocimientoVoz()
        
    }
    
    //Envía una consulta a la clase conexión para enviársela al servidor.
    @objc private func prepararConsulta(_ notification: NSNotification) {
        if (self.startButton.isEnabled && !isRecording) {
            if let dict = notification.userInfo as! [String : Any]? {
                enviarSolicitud(tipo: dict["tipo"] as! String, peticion: String(dict["peticion"] as! Int))
            }
        }
    }
    
    //Inicializa el Spinner oculto en el botón del micrófono.
    private func prepararSpinner() {
        
        spinnerView.layer.cornerRadius = 10;
        spinnerView.layer.masksToBounds = true;
        
        activitySpinner.accessibilityLabel = "Cargando, espere."
        activitySpinner.center = CGPoint(x: 67.0, y: 55.0)
        activitySpinner.color = UIColor.white
    }
    
    //Gestiona la transacción con el servidor.
    internal func enviarSolicitud(tipo: String, peticion: String) {
        let dao = DAO();
        
        //Muestra el spinner de carga.
        UIView.transition(with: self.view, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.startButton.isHidden = true
                self.spinnerView.isHidden = false
        }, completion:{
            finished in
            self.activitySpinner.startAnimating()
        })
        
        //Deshabilita el botón del micrófono.
        self.startButton.isEnabled = false
        
        DispatchQueue.global(qos: .userInitiated).async {
            dao.tratarDatos(id: self.user_id, tipo: tipo, peticion: peticion) {
                respuesta in
                
                //Si el servidor ha fallado
                if (respuesta.value(forKey: "errorno") as! NSNumber == 404) {
                    self.ponerTextoEnBot(texto: respuesta.value(forKey: "errorMessage") as! String)
                }
                    
                //Si la conexión se ha realizado correctamente
                else {
                    //Si los datos no son correctos
                    if (respuesta.value(forKey: "errorno") as! NSNumber != 0) {
                        self.ponerTextoEnBot(texto: respuesta.value(forKey: "errorMessage") as! String)
                    } else if (respuesta.value(forKey: "errorno") as! NSNumber == 0) {
                        //Si hay un nuevo id del usuario, lo almacena en la aplicación.
                        if let user = respuesta.value(forKey: "user_id") {
                            let preferences = UserDefaults.standard
                            preferences.set(user, forKey: "user_id")
                            self.user_id = user as? Int
                        }
                        //Inserta la respuesta en la aplicación.
                        self.ponerDatosEnBot(datos: respuesta)
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    //Oculta nuevamente el spinner.
                    self.activitySpinner.stopAnimating()
                    UIView.transition(with: self.view, duration: 0.6, options: .transitionCrossDissolve, animations: {
                        self.startButton.isHidden = false
                        self.spinnerView.isHidden = true
                    })
                    //Habilita el botón del micrófono.
                    self.startButton.isEnabled = true
                    self.procesarFrase()
                }
            }
        }
    }
    
    //Comprueba si el usuario ha autorizado el uso del reconocimiento de voz en la aplicación.
    private func comprobarPermisosReconocimientoVoz() {
        if (SFSpeechRecognizer.authorizationStatus() != .authorized) {
            
            //Si la aplicación no está autorizada, se añadirá un mensaje en función del error.
            SFSpeechRecognizer.requestAuthorization { authStatus in
                OperationQueue.main.addOperation {
                    var error: Bool = true
                    switch authStatus {
                        case .authorized:
                            self.startButton.isEnabled = true
                            error = false
                        case .denied:
                            self.startButton.isEnabled = false
                            self.mensajes.append(Globos(texto: "Hay un problema. Has denegado el reconocimiento de voz.", emisor: .Bot))
                        case .restricted:
                            self.startButton.isEnabled = false
                            self.mensajes.append(Globos(texto: "Hay un problema. Reconocimiento de voz no disponible en este dispositivo.", emisor: .Bot))
                        case .notDetermined:
                            self.startButton.isEnabled = false
                            self.mensajes.append(Globos(texto: "Hay un problema. Aún no ha autorizado el reconocimiento de voz.", emisor: .Bot))
                    }
                    if (error) {
                        //Añade el mensaje a la tabla de globos y deshailita el uso del botón del micrófono.
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: [IndexPath(row: self.mensajes.count-1, section: 0)], with: .automatic)
                        self.tableView.endUpdates()
                        self.tableView.scrollToRow(at: IndexPath(row: self.mensajes.count-1, section: 0) , at: UITableView.ScrollPosition.bottom, animated: true)
                        
                        self.leerFrase(texto: self.botText)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Prepara el sitema para leer textos a través del punto de salida actual del sistema (altavoz o auriculares) en el idioma castellano.
    private func inicializarVoz() {
        for availableVoice in AVSpeechSynthesisVoice.speechVoices(){
            if ((availableVoice.language == "es-ES") &&
                (availableVoice.quality == AVSpeechSynthesisVoiceQuality.enhanced)){ //Seleccion de voz de alta calidad.
                self.voice = availableVoice
                print("\(availableVoice.name) Seleccionada como voz en uso. Calidad: \(availableVoice.quality.rawValue)")
            }
        }
        if let selectedVoice = self.voice {
            print("El siguiente identificador ha sido cargado: ",selectedVoice.identifier)
        }
        else {
            self.voice = AVSpeechSynthesisVoice(language: "es-ES")
        }
    }
    
    //Si el usuario no ha deshabilitado la lectura de texto, reproduce el texto por el altavoz.
    private func leerFrase(texto: String) {
        if (self.trascribir) {
            let utterance = AVSpeechUtterance(string: texto)
            utterance.voice = self.voice
            utterance.rate = self.utteranceRate
            
            self.synthesizer.speak(utterance)
        }
    }
    
    //Escucha al usuario a través del micrófono predeterminado del sistema.
    private func procesarFrase() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            if (convertFromAVAudioSessionCategory(audioSession.category) != "AVAudioSessionCategoryPlayAndRecord") {
                try! audioSession.setCategory(.playAndRecord, mode: .spokenAudio)
                try audioSession.setMode(AVAudioSession.Mode.spokenAudio)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                
                let currentRoute = AVAudioSession.sharedInstance().currentRoute
                for description in currentRoute.outputs {
                    if description.portType == AVAudioSession.Port.headphones {
                        print("auriculares conectados")
                    } else {
                        print("auriculares desconectados")
                        try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                    }
                }
            }
            
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.mensajes.count-1, section: 0)], with: .left)
            self.tableView.endUpdates()
            self.tableView.scrollToRow(at: IndexPath(row: self.mensajes.count-1, section: 0) , at: UITableView.ScrollPosition.bottom, animated: true)
        }
        self.leerFrase(texto: self.botText)
        
    }
    
    //Inserta un mensaje de texto como usuario Bot
    private func ponerTextoEnBot(texto: String) {
        self.botText = texto;
        self.mensajes.append(Globos(texto: self.botText, emisor: .Bot))
    }
    
    //Carga la respuesta del servidor en un globo.
    private func ponerDatosEnBot(datos: NSDictionary) {
        if (datos.value(forKey: "content-type") as! String == "list-books") {
            self.botText = datos.value(forKey: "response") as! String;
            let aux = datos.value(forKey: "books") as! [[String : Any]]
            var books : [Globos] = []
            for item in aux {
                let temp = Globos(texto: "", isbn: item["isbn"] as! [String], emisor: .Bot,
                                  tipo: Globos.TiposMensaje.listbooks)
                temp.setTitle(text: item["title"] as! String)
                if let author = item["author"] as? String {
                    temp.setAuthor(text: author)
                } else {
                    temp.setAuthor(text: "")
                }
                temp.setISBN(isbn: item["isbn"] as! [String])
                temp.setCodOCLC(code: Int(item["oclc"] as! String)!)
                books.append(temp)
            }
            let temp = Globos(texto: self.botText, emisor: .Bot, tipo: Globos.TiposMensaje.listbooks)
            temp.setList(list: books)
            self.mensajes.append(temp)
        } else if (datos.value(forKey: "content-type") as! String == "single-book"){
            self.botText = datos.value(forKey: "response") as! String;
            var temp : Globos
            if datos.value(forKey: "isbn") == nil {
                temp = Globos(texto: self.botText, emisor: .Bot,
                              tipo: Globos.TiposMensaje.singlebook)
            } else {
                let isbns = datos.value(forKey: "isbn") as! [String]
                if !isbns.isEmpty {
                    temp = Globos(texto: self.botText, isbn: isbns, emisor: .Bot,
                       tipo: Globos.TiposMensaje.singlebook)
                } else {
                    temp = Globos(texto: self.botText, emisor: .Bot,
                                  tipo: Globos.TiposMensaje.singlebook)
                }
            }
            temp.setTitle(text: datos.value(forKey: "title") as! String)
            temp.setAuthor(text: datos.value(forKey: "author") as! String)
            temp.setAvailable(available: false)
            for item in datos.value(forKey: "available") as! [[String:Int]] {
                for biblioteca in item {
                    temp.setAvailable(available: true)
                    temp.addLibraryAvailable(index: biblioteca.key, count: biblioteca.value)
                }
            }
            temp.setURL(url: datos.value(forKey: "url") as! String)
            self.mensajes.append(temp)
        } else if (datos.value(forKey: "content-type") as! String == "location"){
            self.botText = datos.value(forKey: "response") as! String;
            let temp = Globos(texto: self.botText, emisor: .Bot,
                              tipo: Globos.TiposMensaje.location)
            temp.setLibrary(text: datos.value(forKey: "library") as! String)
            temp.setLat(data: datos.value(forKey: "lat") as! Double)
            temp.setLong(data: datos.value(forKey: "long") as! Double)
            temp.setDirection(data: datos.value(forKey: "location") as! String)
            self.mensajes.append(temp)
        } else if (datos.value(forKey: "content-type") as! String == "phone"){
            self.botText = datos.value(forKey: "response") as! String;
            let temp = Globos(texto: self.botText, emisor: .Bot,
                              tipo: Globos.TiposMensaje.phone)
            temp.setLibrary(text: datos.value(forKey: "library") as! String)
            temp.setPhone(data: datos.value(forKey: "phone") as! Int)
            self.mensajes.append(temp)
        } else {
            self.botText = datos.value(forKey: "response") as! String;
            self.mensajes.append(Globos(texto: self.botText, emisor: .Bot))
        }
    }

    //Inicia la captura de voz y la convierte en texto.
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.6, delay: 0,
                       options: [.repeat, .autoreverse, .allowUserInteraction],
                       animations: {
                        self.startButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }, completion: nil)
        
        guard let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "es_ES")) else {
            print("Reconocedor de voz no disponible en su idioma");
            return
        }
        
        func playSound(soundName: String, ext: String) {
            guard let url = Bundle.main.url(forResource: soundName, withExtension: ext) else { return }
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                if (convertFromAVAudioSessionCategory(audioSession.category) != "AVAudioSessionCategoryPlayAndRecord") {
                    try! audioSession.setCategory(.playAndRecord, mode: .spokenAudio)
                    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                    
                    let currentRoute = AVAudioSession.sharedInstance().currentRoute
                    for description in currentRoute.outputs {
                        if description.portType == AVAudioSession.Port.headphones {
                            print("Auriculares conectados")
                        } else {
                            print("Auriculares desconectados")
                            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                        }
                    }
                }
                
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                guard let player = player else { return }
                
                player.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        //MARK: - Recognize Speech
        func recordAndRecognizeSpeech() {
            
            let node = audioEngine.inputNode
            let recordingFormat = node.outputFormat(forBus: 0)
            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.request?.append(buffer)
            }
            audioEngine.prepare()
            do {
                try audioEngine.start()
            } catch {
                sendAlert(message: "Hay un error en el engine de audio.")
                return print(error)
            }
            if !speechRecognizer.isAvailable {
                stopRecognition()
                self.ponerTextoEnBot(texto: "El reconocimiento de voz no está disponible actualmente. Compruebe que Siri esté activado en los ajustes de iOS y que tenga conexión a internet. En caso de persistir el problema, es posible que haya superado su cuota de uso diaria del reconocimiento de voz.")
                self.procesarFrase()
                // Recognizer no disponible.
                return
            }
            if isRecording == true {
                
                recognitionTask = speechRecognizer.recognitionTask(with: request!, resultHandler: { result, error in
                    
                    var isFinal = false
                    if let result = result {
                        self.mensajes[self.mensajes.count - 1].setRespuesta(text: result.bestTranscription.formattedString)
                        let indexPath = IndexPath(row: self.mensajes.count - 1, section: 0)
                        self.tableView.reloadRows(at: [indexPath], with: .none)
                        self.tableView.scrollToRow(at: indexPath , at: UITableView.ScrollPosition.bottom, animated: true)
                        
                        isFinal = result.isFinal
                    }
                    if isFinal {
                        stopRecognition()
                    }
                    else if error == nil {
                        restartSpeechTimer()
                    }
                })
            }
        }
        
        //Reinicia el contador de tiempo en el que el usuario no ha dicho nada para parar el reconocimiento de voz.
        func restartSpeechTimer() {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                // Do whatever needs to be done when the timer expires
                if self.isRecording {
                    stopRecognition()
                }
            })
        }
        
        //Para el reconocimiento de voz.
        func stopRecognition() {
            DispatchQueue.main.async {
                self.startButton.layer.removeAllAnimations()
                UIView.animate(withDuration: 0.6) {
                    self.startButton.transform = CGAffineTransform.identity
                }
            }
            self.audioEngine.stop()
            self.recognitionTask?.cancel()
            self.recognitionTask?.finish()
            self.request?.endAudio()
            self.recognitionTask = nil
            self.request = nil
            self.isRecording = false
            self.audioEngine.inputNode.removeTap(onBus: 0)
            
            if (mensajes[mensajes.count - 1].getEmisor() == .User && mensajes[mensajes.count - 1].getRespuesta() != "") {
                playSound(soundName: "Recognized voice", ext: "wav")
                self.enviarSolicitud(tipo: "query", peticion: mensajes[mensajes.count - 1].getRespuesta())
                
            } else {
                playSound(soundName: "Micro Stopped", ext: "wav")
                if (mensajes[mensajes.count - 1].getEmisor() == .User) {
                    self.mensajes.remove(at: self.mensajes.count - 1)
                    
                    if(self.tableView.numberOfRows(inSection: 0) != mensajes.count) {
                        self.tableView.beginUpdates()
                        self.tableView.deleteRows(at: [IndexPath(row: self.mensajes.count, section: 0)], with: .right)
                        self.tableView.endUpdates()
                        self.tableView.scrollToRow(at: IndexPath(row: self.mensajes.count-1, section: 0) , at: UITableView.ScrollPosition.bottom, animated: true)
                    }
                }
            }
        }
        
        if self.isRecording == true {
            stopRecognition()
        } else {
            if (mensajes[mensajes.count-1].getRespuesta() != "") {
                mensajes.append(Globos(texto: "", emisor: .User));
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath(row: self.mensajes.count-1, section: 0)], with: .right)
                self.tableView.endUpdates()
                self.tableView.scrollToRow(at: IndexPath(row: self.mensajes.count-1, section: 0) , at: UITableView.ScrollPosition.bottom, animated: true)
            }
            
            self.synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            playSound(soundName: "Micro Start", ext: "wav")
            self.isRecording = true
            
            self.request = SFSpeechAudioBufferRecognitionRequest()
            
            recordAndRecognizeSpeech()
        }
        
        //MARK: - Alert
        func sendAlert(message: String) {
            let alert = UIAlertController(title: "Error de Speech Recognizer", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getAltoContrasteActivo() -> Bool {
        return self.contraste
    }
    
    private func altoContraste() {
        let icon = UIImage(named: "Micro_High_Contrast") as UIImage?
        self.capaDegradado.backgroundColor = UIColor.black
        self.capaDegradado.alpha = 1
        self.startButton.setImage(icon, for: .normal)
    }
    
    @objc func defaultsChanged() {
        let ud = UserDefaults.standard
        ud.synchronize()
        
        self.trascribir = UserDefaults.standard.bool(forKey: "transcription_text")
        self.utteranceRate = UserDefaults.standard.float(forKey: "slider_speed")
        self.contraste = UserDefaults.standard.bool(forKey: "high_contrast")
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionPort(_ input: AVAudioSession.Port) -> String {
	return input.rawValue
}
