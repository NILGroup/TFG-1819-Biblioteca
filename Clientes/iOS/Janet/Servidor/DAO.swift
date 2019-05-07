//
//  DAO.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 29/09/2018.
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
import UIKit

class DAO: conexion {
    
    //Prepara los datos a un formato entendible por el servidor
    func tratarDatos(id: Int, tipo: String, peticion:String, finished: @escaping ((_ respuesta: NSDictionary)->Void)) {
        
        let datos = ["user_id": id,
            "type": tipo,
            "content": peticion,
            "client_ver": Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String,
            "client_build": Bundle.main.infoDictionary!["CFBundleVersion"] as! String,
            "platform_os": "ios" as String,
            "platform_ver": UIDevice.current.systemVersion] as [String : Any]
        
        ejecutar(peticion: datos) {
            respuesta in
            finished(respuesta)
        }
    }
    
    
    
}
