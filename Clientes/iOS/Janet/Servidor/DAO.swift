//
//  DAO.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 29/09/2018.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import Foundation
import UIKit

class DAO: conexion {
    
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
