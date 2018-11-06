//
//  Globos.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 05/11/18.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import Foundation


class Globos {
    
    enum TiposEmisor{ case Bot, User}
    
    internal let emisor: TiposEmisor
    internal var respuesta: String
    internal var url: String
    internal var imagenURL: String
    
    init() {
        self.emisor = TiposEmisor.Bot
        self.respuesta = ""
        self.url = ""
        self.imagenURL = ""
    }
    
    init(texto: String, emisor: TiposEmisor) {
        self.emisor = emisor
        self.respuesta = texto
        self.url = ""
        self.imagenURL = ""
    }
    
    init(texto: String, url: String, foto: String, emisor: TiposEmisor) {
        self.emisor = emisor
        self.respuesta = texto
        self.url = url
        self.imagenURL = foto
    }
    
    func getEmisor() -> TiposEmisor {
        return self.emisor
    }
    
    func getRespuesta() -> String {
        return self.respuesta
    }
    
    func getURL() -> String {
        return self.url
    }
    
    func getImagen() -> String {
        return self.imagenURL
    }
    
    func setRespuesta(text: String) {
        self.respuesta = text
    }
    
    func setURL(url: String) {
        self.url = url
    }
    
    func setImagen(foto: String) {
        self.imagenURL = foto
    }
    
}
