# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.3.0 - Supplemental Update

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

import json
from watson_developer_cloud import AssistantV1

class JanetServProcessor():
    def procesarDatos_POST(self, client_request):
        
        respuesta = {}
        #if(client_request["content"] == "Hola"):
            #respuesta['errorno'] = 0
            #respuesta['response'] = 'Hola! Soy Janet'
        #elif(client_request["content"] == "Qué tal"):
            #respuesta['errorno'] = 0
            #respuesta['response'] = 'Muy bien, y tu?'
        #elif(client_request["content"] == "Cuando funcionaras"):
            #respuesta['errorno'] = 0
            #respuesta['response'] = 'Pronto'
        #elif(client_request["content"] == "Adiós"):
            #respuesta['errorno'] = 0
            #respuesta['response'] = 'Hasta pronto'
        #else:
            #respuesta['errorno'] = -1
            #respuesta['errorMessage'] = 'Jo, no te entendido. Lo siento'
        
        with open('credentials.conf') as f:
            data = json.load(f)
            
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
            service = AssistantV1(
                    version='2018-07-10',
                    ## url is optional, and defaults to the URL below. Use the correct URL for your region.
                    url='https://gateway.watsonplatform.net/assistant/api',
                    username=data["username"],
                    password=data["pass"])
    
            service.set_http_config({'timeout': 100})
            response = service.message(workspace_id=data["workspace_id"], input={'text': client_request["content"]}).get_result()
            respuesta['errorno'] = 0
            respuesta['content-type'] = 'text'
            respuesta['response'] = response["output"]["text"][0]
            
            #Para debuggear
            #print(json.dumps(response, indent=2))
                
        json_response = json.dumps(respuesta, ensure_ascii=False).encode('utf8')
        return json_response