//
//  conexion.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 29/09/2018.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import Foundation

internal class conexion {
    
    private let url = "https://holstein.fdi.ucm.es/tfg-biblio/mobilenative" //Insertar dirección del servidor
    
    //Ejecuta la petición al servidor, retornando la respuesta de este
    internal func ejecutar(peticion:Dictionary<String, Any>, finished: @escaping ((_ respuesta: NSDictionary)->Void)) {
        
        let urlComplete: URL = URL(string: self.url)!
        var request: URLRequest = URLRequest(url: urlComplete)
        request.httpMethod = "POST"
        request.httpBody = transformarDatos(datos: peticion).data(using: String.Encoding.utf8);
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
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
    
    internal func transformarDatos(datos:Dictionary<String, Any>) -> String {
        var respuesta: String;
        respuesta = "session_id=" + String(datos["session_id"] as! Int)
        respuesta = "client_ver=" + String(datos["client_ver"] as! String)
        respuesta += "&content=" + (datos["content"] as! String)
        respuesta += "&os=" + (datos["platform_os"] as! String)
        respuesta += "&os_ver=" + String(datos["platform_ver"] as! String)
        return respuesta;
    }
    
}
