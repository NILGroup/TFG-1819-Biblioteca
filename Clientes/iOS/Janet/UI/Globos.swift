//
//  Globos.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 05/11/18.
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

import Foundation

//Clase para almacenar datos de cada mensaje.
class Globos {
    
    //Indica si el autor del mensaje ha sido el usuario o el sistema.
    enum TiposEmisor{ case Bot, User }
    
    //Indica qué tipo de mensaje es.
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
