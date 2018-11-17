//
//  Globos.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 05/11/18.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import Foundation


class Globos {
    
    enum TiposEmisor{ case Bot, User }
    enum TiposMensaje { case text, singlebook }
    
    private let emisor: TiposEmisor
    private var respuesta: String
    private var url: String
    private var imagenURL: String
    private let type: TiposMensaje
    private var title: String?
    private var author: String?
    private var available: Bool
    private var librarys: String?
    
    init() {
        self.emisor = TiposEmisor.Bot
        self.respuesta = ""
        self.url = ""
        self.imagenURL = ""
        self.type = .text
        self.title = nil
        self.author = nil
        self.available = true
        self.librarys = nil
    }
    
    init(texto: String, emisor: TiposEmisor) {
        self.emisor = emisor
        self.respuesta = texto
        self.url = ""
        self.imagenURL = ""
        self.type = .text
        self.title = nil
        self.author = nil
        self.available = true
        self.librarys = nil
    }
    
    init(texto: String, foto: String, emisor: TiposEmisor, tipo: TiposMensaje) {
        self.emisor = emisor
        self.respuesta = texto
        self.url = ""
        self.imagenURL = foto
        self.type = tipo
        self.title = nil
        self.author = nil
        self.available = true
        self.librarys = nil
    }
    
    func getEmisor() -> TiposEmisor {
        return self.emisor
    }
    
    func getTipo() -> TiposMensaje {
        return self.type
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
    
    func getTitle() -> String {
        if (self.title == nil) {
            return ""
        }
        return self.title!
    }
    
    func getAuthor() -> String {
        if (self.author == nil) {
            return ""
        }
        return self.author!
    }
    
    func getAvailable() -> Bool {
        return self.available
    }
    
    func getLibrarys() -> String {
        if (self.librarys == nil) {
            return ""
        }
        return self.librarys!
    }
    
    func setRespuesta(text: String) {
        self.respuesta = text
    }
    
    func setTitle(text: String) {
        self.title = text
    }
    
    func setAuthor(text: String) {
        self.author = text
    }
    
    func setAvailable(available: Bool) {
        self.available = available
    }
    
    func setLibrarys(text: String) {
        self.librarys = text
    }
    
    func setURL(url: String) {
        self.url = url
    }
    
    func setImagen(foto: String) {
        self.imagenURL = foto
    }
    
}
