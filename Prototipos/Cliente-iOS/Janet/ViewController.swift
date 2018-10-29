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
    
    //@IBOutlet weak var janetView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    //@IBOutlet weak var janetTextLabel: UILabel!
    @IBOutlet weak var userTextLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var textos: [String] = ["Hola! Soy Janet. ¿En qué te puedo ayudar?"];
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

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        //janetFirstCell.layer.cornerRadius = 10
        inicializarVoz()
        // Do any additional setup after loading the view, typically from a nib.
        let utterance = AVSpeechUtterance(string: textos[0])
        utterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
        utterance.voice = voice
        utterance.rate = 0.4
        
        startButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        synthesizer.speak(utterance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func inicializarVoz() {
        for availableVoice in AVSpeechSynthesisVoice.speechVoices(){
            if ((availableVoice.language == AVSpeechSynthesisVoice.currentLanguageCode()) &&
                (availableVoice.quality == AVSpeechSynthesisVoiceQuality.enhanced)){ //Seleccion de voz de alta calidad.
                self.voice = availableVoice
                print("\(availableVoice.name) Seleccionada como voz en uso. Calidad: \(availableVoice.quality.rawValue)")
                }
                }
                if let selectedVoice = self.voice {
                    print("El siguiente identificador ha sido cargado: ",selectedVoice.identifier)
                } else {
                self.voice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textos.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 10
        cell.setText(texto: textos[indexPath.row])
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
                let indexPath = IndexPath(row: self.textos.count, section: 0)
                self.textos.append(self.botText)
                self.collectionView?.insertItems(at: [indexPath])
            }, completion: nil)
            
            let item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
            let lastItemIndex = NSIndexPath(item: item, section: 0)
            self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
        }
        let utterance = AVSpeechUtterance(string: self.botText)
        utterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
        utterance.rate = 0.4
        
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
        if (speechRecognizer.isAvailable == false) {
            print("El reconocimiento de voz no está disponible, active los permisos en ajustes.");
            
            ponerTextoEnBot(texto: "El reconocimiento de voz no está disponible, active los permisos en ajustes.");
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.procesarFrase()
            }
            return
        }
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if self.isRecording == true {
                stopRecognition()
            } else {
                self.synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
                playSound(soundName: "Micro Start", ext: "wav")
                self.isRecording = true
                self.userTextLabel.text = ""
                self.request = SFSpeechAudioBufferRecognitionRequest()
                
                var item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
                var lastItemIndex = NSIndexPath(item: item, section: 0)
                self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
                
                self.collectionView?.performBatchUpdates({
                    let indexPath = IndexPath(row: self.textos.count, section: 0)
                    self.textos.append("")
                    self.collectionView?.insertItems(at: [indexPath])
                }, completion: nil)
                
                recordAndRecognizeSpeech()
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
                        self.userTextLabel.text = result.bestTranscription.formattedString
                        self.textos[self.textos.count - 1] = self.userTextLabel.text!
                        self.collectionView.performBatchUpdates({
                            let indexPath = IndexPath(row: self.textos.count - 1, section: 0)
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
            if (self.userTextLabel.text != "") {
                playSound(soundName: "Recognized voice", ext: "wav")
                let dao = DAO();
                
                dao.tratarDatos(peticion: self.userTextLabel.text!) {
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
                
                /*DispatchQueue.main.async {
                    self.collectionView?.performBatchUpdates({
                        let indexPath = IndexPath(row: self.textos.count, section: 0)
                        self.collectionView?.deleteItems(at: [indexPath])
                        self.textos.remove(at: self.textos.count - 1)
                    }, completion: nil)
                }*/
            }
        }
        
        //MARK: - Check Authorization Status
        func requestSpeechAuthorization() {
            SFSpeechRecognizer.requestAuthorization { authStatus in
                OperationQueue.main.addOperation {
                    switch authStatus {
                    case .authorized:
                        self.startButton.isEnabled = true
                    case .denied:
                        self.startButton.isEnabled = false
                        self.userTextLabel.text = "El usuario ha denegado el reconocimiento de voz."
                    case .restricted:
                        self.startButton.isEnabled = false
                        self.userTextLabel.text = "Reconocimiento de voz no disponible en este dispositivo."
                    case .notDetermined:
                        self.startButton.isEnabled = false
                        self.userTextLabel.text = "Aún no ha autorizado el reconocimiento de voz."
                    }
                }
            }
        }
        
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
                
                /* Para iOS 11 o superior*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                /* Para iOS 10 hay que descomentar esta linea:
                 player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
                
                guard let player = player else { return }
                
                player.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
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
