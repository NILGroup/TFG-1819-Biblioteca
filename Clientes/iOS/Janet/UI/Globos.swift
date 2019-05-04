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
    enum TiposMensaje { case text, singlebook, listbooks, location, phone }
    
    private let emisor: TiposEmisor
    private var respuesta: String
    private var url: String
    private var imagenURL: String?
    private var ISBN: [String]
    private let type: TiposMensaje
    private var title: String?
    private var author: String?
    private var available: Bool
    private var library: String?
    private var librarysAvailabe: [String : Int]?
    private var lat: Double?
    private var long: Double?
    private var direction: String?
    private var phone: Int?
    private var codOCLC: Int?
    private var list: [Globos]?
    
    init() {
        self.emisor = TiposEmisor.Bot
        self.respuesta = ""
        self.url = ""
        self.imagenURL = ""
        self.ISBN = []
        self.type = .text
        self.title = nil
        self.author = nil
        self.available = true
        self.library = nil
        self.librarysAvailabe = [:]
        self.lat = nil
        self.long = nil
        self.direction = ""
        self.phone = nil
        self.codOCLC = nil
        self.list = nil
    }
    
    init(texto: String, emisor: TiposEmisor) {
        self.emisor = emisor
        self.respuesta = texto
        self.url = ""
        self.imagenURL = ""
        self.ISBN = []
        self.type = .text
        self.title = nil
        self.author = nil
        self.available = true
        self.library = nil
        self.librarysAvailabe = [:]
        self.lat = nil
        self.long = nil
        self.direction = ""
        self.phone = nil
        self.codOCLC = nil
        self.list = nil
    }
    
    init(texto: String, emisor: TiposEmisor, tipo: TiposMensaje) {
        self.emisor = emisor
        self.respuesta = texto
        self.url = ""
        self.imagenURL = nil
        self.ISBN = []
        self.type = tipo
        self.title = nil
        self.author = nil
        self.available = true
        self.library = nil
        self.librarysAvailabe = [:]
        self.lat = nil
        self.long = nil
        self.direction = ""
        self.phone = nil
        self.codOCLC = nil
        self.list = nil
    }
    
    init(texto: String, isbn: [String], emisor: TiposEmisor, tipo: TiposMensaje) {
        self.emisor = emisor
        self.respuesta = texto
        self.url = ""
        self.imagenURL = nil
        self.ISBN = isbn
        self.type = tipo
        self.title = nil
        self.author = nil
        self.available = true
        self.library = nil
        self.librarysAvailabe = [:]
        self.lat = nil
        self.long = nil
        self.direction = ""
        self.phone = nil
        self.codOCLC = nil
        self.list = nil
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
        return self.imagenURL!
    }
    
    func getISBN() -> [String] {
        return self.ISBN
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
    
    func getLibrary() -> String {
        if (self.library == nil) {
            return ""
        }
        return self.library!
    }
    
    func getLibraryAvailable() -> [String:Int] {
        if ((self.librarysAvailabe?.isEmpty ?? nil)!) {
            return [:]
        }
        return self.librarysAvailabe!
    }
    
    func getLat() -> Double {
        if (self.lat == nil) {
            return 0.0
        }
        return self.lat!
    }
    
    func getLong() -> Double {
        if (self.long == nil) {
            return 0.0
        }
        return self.long!
    }
    
    func getDirection() -> String {
        return self.direction!
    }
    
    func getPhone() -> Int {
        if (self.phone == nil) {
            return 0
        }
        return self.phone!
    }
    
    func getCodOCLC() -> Int {
        if (self.codOCLC == nil) {
            return -1
        }
        return self.codOCLC!
    }
    
    func getlist() -> [Globos] {
        if (self.list == nil) {
            return []
        }
        return self.list!
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
    
    func setLibrary(text: String) {
        self.library = text
    }
    
    func addLibraryAvailable(index: String, count: Int) {
        self.librarysAvailabe?[index] = count
    }
    
    func setLat(data: Double) {
        self.lat = data
    }
    
    func setLong(data: Double) {
        self.long = data
    }
    
    func setDirection(data: String) {
        self.direction = data
    }
    
    func setPhone(data: Int) {
        self.phone = data
    }
    
    func setURL(url: String) {
        self.url = url
    }
    
    func setImagen(foto: String) {
        self.imagenURL = foto
    }
    
    func setISBN(isbn: [String]) {
        self.ISBN = isbn
    }
    
    func setCodOCLC(code: Int) {
        self.codOCLC = code
    }
    
    func setList(list: [Globos]) {
        self.list = list
    }
    
}
