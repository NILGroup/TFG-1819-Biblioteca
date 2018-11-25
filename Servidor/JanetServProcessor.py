# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.1.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""
import JanetServWatson
import JanetServWMS
import json

class JanetServProcessor():
    
    def procesarDatos_POST(self, client_request):
        
        respuesta = {}
            
        if (client_request["content"] == "Prueba"):
            respuesta['errorno'] = 0
            respuesta['content-type'] = 'single-book'
            respuesta['response'] = "Vale, aquí tienes un libro de prueba"
            respuesta['title'] = "1984"
            respuesta['author'] = "George Orwell"
            respuesta['available'] = True
            respuesta['cover-art'] = "https://coverart.oclc.org/ImageWebSvc/oclc/+-+334925864_70.jpg"
            respuesta['library'] = 'María zambrano' 
              
        else:
            watson = JanetServWatson.JanetServWatson()
            respuesta = watson.consultar(client_request)
            if (respuesta['has-extra-data'] == False):
                del respuesta['has-extra-data']
            else:
                wms = JanetServWMS.JanetServWMS()
                oclcCodes = wms.buscar(respuesta['extra-data'][0])
                respuesta.update(wms.cargarInformacion(oclcCodes))
                respuesta['content-type'] = 'single-book'
                del respuesta['has-extra-data']
                del respuesta['extra-data']
                print(respuesta)
            #Para debuggear
            #print(json.dumps(response, indent=2))
                
        json_response = json.dumps(respuesta, ensure_ascii=False).encode('utf8')
        return json_response