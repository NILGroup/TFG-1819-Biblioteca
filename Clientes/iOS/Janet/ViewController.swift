//
//  ViewController.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 01/09/18.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SFSpeechRecognizerDelegate, SFSpeechRecognitionTaskDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    
    //var userText: String = ""
    var mensajes: [Globos] = []
    let audioEngine = AVAudioEngine()
    let synthesizer = AVSpeechSynthesizer()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    var request: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    var voice: AVSpeechSynthesisVoice!
    var player: AVAudioPlayer?
    var timer: Timer!
    var botText: String = ""
    let utteranceRate: Float = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        
        mensajes.append(Globos(texto: "Hola! Soy Janet. ¿En qué te puedo ayudar?", emisor: .Bot))
        let utterance = AVSpeechUtterance(string: mensajes[0].getRespuesta())
        inicializarVoz()
        // Do any additional setup after loading the view, typically from a nib.
        
        utterance.voice = voice
        utterance.rate = utteranceRate
        
        startButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        synthesizer.speak(utterance)
        comprobarPermisosReconocimientoVoz()
    }
    
    internal func comprobarPermisosReconocimientoVoz() {
        if (SFSpeechRecognizer.authorizationStatus() != .authorized) {
            
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
                            //self.userText = "Hay un problema. Has denegado el reconocimiento de voz."
                        case .restricted:
                            self.startButton.isEnabled = false
                            self.mensajes.append(Globos(texto: "Hay un problema. Reconocimiento de voz no disponible en este dispositivo.", emisor: .Bot))
                            //self.userText = "Hay un problema. Reconocimiento de voz no disponible en este dispositivo."
                        case .notDetermined:
                            self.startButton.isEnabled = false
                            self.mensajes.append(Globos(texto: "Hay un problema. Aún no ha autorizado el reconocimiento de voz.", emisor: .Bot))
                            //self.userText = "Hay un problema. Aún no ha autorizado el reconocimiento de voz."
                    }
                    if (error) {
                        self.collectionView?.performBatchUpdates({
                            let indexPath = IndexPath(item: self.mensajes.count - 1, section: 0)
                            //self.mensajes.append(Globos(texto: self.userText, emisor: .User))
                            self.collectionView?.insertItems(at: [indexPath])
                        }, completion: {(success) in
                            let lastItemIndex = IndexPath(item: self.mensajes.count - 1, section: 0)
                            self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionView.ScrollPosition.bottom, animated: true)
                        })
                        
                        //let item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
                        
                        let utterance = AVSpeechUtterance(string: self.botText)
                        utterance.voice = self.voice
                        utterance.rate = self.utteranceRate
                        
                        self.synthesizer.speak(utterance)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func inicializarVoz() {
        for availableVoice in AVSpeechSynthesisVoice.speechVoices(){
        //if ((availableVoice.language == AVSpeechSynthesisVoice.currentLanguageCode()) &&
            //print(AVSpeechSynthesisVoice.currentLanguageCode())
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mensajes.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 10
        cell.setText(info: mensajes[indexPath.row])
        
        let numberOfCellsPerRow: CGFloat = 1
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = ((view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow)-10
            flowLayout.itemSize = CGSize(width: cellWidth, height: 74)
        }
        
        return cell
    }
    
    func procesarFrase() {
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            if (convertFromAVAudioSessionCategory(audioSession.category) != "AVAudioSessionCategoryPlayAndRecord") {
                try! audioSession.setCategory(.playAndRecord, mode: .spokenAudio)
                try audioSession.setMode(AVAudioSession.Mode.spokenAudio)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                
                let currentRoute = AVAudioSession.sharedInstance().currentRoute
                for description in currentRoute.outputs {
                    if convertFromAVAudioSessionPort(description.portType) == convertFromAVAudioSessionPort(AVAudioSession.Port.headphones) {
                        try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
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
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //Eliminar esto cuando haya un servidor
        DispatchQueue.main.async {
            self.collectionView?.performBatchUpdates({
                let indexPath = IndexPath(row: self.mensajes.count, section: 0)
                self.mensajes.append(Globos(texto: self.botText, emisor: .Bot))
                self.collectionView?.insertItems(at: [indexPath])
            }, completion: { (success) in
                let lastItemIndex = IndexPath(item: self.mensajes.count - 1, section: 0)
                self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionView.ScrollPosition.bottom, animated: true)
            })
            
            //let item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
            
        }
        let utterance = AVSpeechUtterance(string: self.botText)
        utterance.voice = self.voice
        utterance.rate = utteranceRate
        
        self.synthesizer.speak(utterance)
        //}
        
    }
    
    internal func lastIndexPath() -> IndexPath? {
        for sectionIndex in (0..<collectionView.numberOfSections).reversed() {
            if collectionView.numberOfItems(inSection: sectionIndex) > 0 {
                return IndexPath.init(item: collectionView.numberOfItems(inSection: sectionIndex)-1, section: sectionIndex)
            }
        }
        
        return nil
    }
    
    func ponerTextoEnBot(texto: String) {
        self.botText = texto;
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.6, delay: 0,
                       options: [.repeat, .autoreverse, .allowUserInteraction],
                       animations: {
                        self.startButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }, completion: nil)
        
        // Initialize the speech recogniter with your preffered language
        guard let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "es_ES")) else {
            print("Speech recognizer is not available for this locale!");
            return
        }
        
        // Check the availability. It currently only works on the device
        /*if (speechRecognizer.isAvailable == false) {
            print("El reconocimiento de voz no está disponible, active los permisos en ajustes.");
            
            ponerTextoEnBot(texto: "El reconocimiento de voz no está disponible, active los permisos en ajustes.");
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.procesarFrase()
            }
            return
        }*/
        
        
        
        func playSound(soundName: String, ext: String) {
            guard let url = Bundle.main.url(forResource: soundName, withExtension: ext) else { return }
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                if (convertFromAVAudioSessionCategory(audioSession.category) != "AVAudioSessionCategoryPlayAndRecord") {
                    try! audioSession.setCategory(.playAndRecord, mode: .spokenAudio)
                    //try audioSession.setMode(AVAudioSession.Mode.spokenAudio)
                    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                    
                    let currentRoute = AVAudioSession.sharedInstance().currentRoute
                    for description in currentRoute.outputs {
                        if convertFromAVAudioSessionPort(description.portType) == convertFromAVAudioSessionPort(AVAudioSession.Port.headphones) {
                            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
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
            guard let myRecognizer = SFSpeechRecognizer() else {
                sendAlert(message: "Reconocimiento de voz no disponible en el idioma seleccionado.")
                return
            }
            if !myRecognizer.isAvailable {
                sendAlert(message: "El reconocimiento de voz no está disponible actualmente. Inténtelo más tarde.")
                // Recognizer no disponible.
                return
            }
            if isRecording == true {
                
                recognitionTask = speechRecognizer.recognitionTask(with: request!, resultHandler: { result, error in
                    
                    var isFinal = false
                    if let result = result {
                        //self.userText = result.bestTranscription.formattedString
                        self.mensajes[self.mensajes.count - 1].setRespuesta(text: result.bestTranscription.formattedString)
                        self.collectionView.performBatchUpdates({
                            let indexPath = IndexPath(row: self.mensajes.count - 1, section: 0)
                            self.collectionView.reloadItems(at: [indexPath])
                        })
                        isFinal = result.isFinal
                    }
                    if isFinal {
                        stopRecognition()
                    }
                    else if  error == nil {
                        restartSpeechTimer()
                    }
                })
            }
        }
        
        func restartSpeechTimer() {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                // Do whatever needs to be done when the timer expires
                if self.isRecording {
                    stopRecognition()
                }
            })
        }
        
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
            
            if (mensajes[mensajes.count - 1].getRespuesta() != "") {
                playSound(soundName: "Recognized voice", ext: "wav")
                let dao = DAO();
                
                dao.tratarDatos(peticion: mensajes[mensajes.count - 1].getRespuesta()) {
                    respuesta in
                    
                    //Si el servidor ha fallado
                    if (respuesta.value(forKey: "errorno") as! NSNumber == 404) {
                        self.ponerTextoEnBot(texto: respuesta.value(forKey: "errorMessage") as! String);
                    }
                        //Si la conexión se ha realizado correctamente
                    else {
                        //Si los datos no son correctos
                        if (respuesta.value(forKey: "errorno") as! NSNumber != 0) {
                            self.ponerTextoEnBot(texto: respuesta.value(forKey: "errorMessage") as! String);
                        } else if (respuesta.value(forKey: "errorno") as! NSNumber == 0){
                            self.ponerTextoEnBot(texto: respuesta.value(forKey: "response") as! String);
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.procesarFrase()
                    }
                }
                
            } else {
                playSound(soundName: "Micro Stopped", ext: "wav")
                
                DispatchQueue.main.async {
                    self.collectionView?.performBatchUpdates({
                        let indexPath = IndexPath(item: self.mensajes.count - 1, section: 0)
                        self.collectionView?.deleteItems(at: [indexPath])
                        self.mensajes.remove(at: indexPath.item)
                    }, completion: nil)
                }
            }
        }
        
        if self.isRecording == true {
            stopRecognition()
        } else {
            self.synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            playSound(soundName: "Micro Start", ext: "wav")
            self.isRecording = true
            //DispatchQueue.main.async {
                //self.userText = ""
            //}
            mensajes[mensajes.count - 1].setRespuesta(text: "")
            self.request = SFSpeechAudioBufferRecognitionRequest()
            
            //var item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
            /*var lastItemIndex = IndexPath(item: mensajes.count - 1, section: 0)
            DispatchQueue.main.async {
                self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionView.ScrollPosition.bottom, animated: true)
            }*/
            DispatchQueue.main.async {
                self.collectionView?.performBatchUpdates({
                    let indexPath = IndexPath(row: self.mensajes.count, section: 0)
                    self.mensajes.append(Globos(texto: "", emisor: .User))
                    self.collectionView?.insertItems(at: [indexPath])
                }, completion: { (success) in
                    var lastItemIndex = IndexPath(item: self.mensajes.count - 1, section: 0)
                    self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionView.ScrollPosition.bottom, animated: true)
                })
                /*var lastItemIndex = IndexPath(item: mensajes.count - 1, section: 0)
                self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionView.ScrollPosition.bottom, animated: true)*/
            }
            
            recordAndRecognizeSpeech()
        }
        
        //MARK: - Alert
        func sendAlert(message: String) {
            let alert = UIAlertController(title: "Error de Speech Recognizer", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
