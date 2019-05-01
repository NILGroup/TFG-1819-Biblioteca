//
//  conexion.swift
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

internal class conexion {
    
    private let url = "https://holstein.fdi.ucm.es/tfg-biblio/api"
    
    //Ejecuta la petición al servidor, retornando la respuesta de este
    internal func ejecutar(peticion:Dictionary<String, Any>, finished: @escaping ((_ respuesta: NSDictionary)->Void)) {
        
        let urlComplete: URL = URL(string: self.url)!
        var request: URLRequest = URLRequest(url: urlComplete)
        request.httpMethod = "POST"
        request.httpBody = transformarDatos(datos: peticion).data(using: String.Encoding.utf8);
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if data != nil {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        finished(json)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    return
                }
            }
                
            else {
                let dict = ["errorno": 404, "errorMessage": "Existe un problema de conexión con el servidor, lo siento"] as [String : Any]
                let aux = dict as NSDictionary
                finished(aux)
            }
        })
        task.resume()
        
    }
    
    //Prepara los datos a un formato entendible por el servidor
    internal func transformarDatos(datos:Dictionary<String, Any>) -> String {
        var respuesta: String;
        respuesta = "user_id=" + String(datos["user_id"] as! Int)
        respuesta += "&client_ver=" + String(datos["client_ver"] as! String)
        respuesta += "&type=" + String(datos["type"] as! String)
        respuesta += "&content=" + (datos["content"] as! String)
        respuesta += "&os=" + (datos["platform_os"] as! String)
        respuesta += "&os_ver=" + String(datos["platform_ver"] as! String)
        return respuesta;
    }
    
}
