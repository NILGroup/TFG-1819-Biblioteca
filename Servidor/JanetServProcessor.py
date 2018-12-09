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
    
        if (client_request["type"] == "query"):
            watson = JanetServWatson.JanetServWatson()
            respuesta = watson.consultar(client_request)
            if (respuesta['has-extra-data'] == False):
                del respuesta['has-extra-data']
            else:
                wms = JanetServWMS.JanetServWMS()
                libros = wms.buscarLibros(respuesta['extra-data'][0])
                respuesta['books'] = libros
                respuesta['content-type'] = 'list-books'
                del respuesta['has-extra-data']
                del respuesta['extra-data']
                #print(respuesta)
            #Para debuggear
            #print(json.dumps(response, indent=2))
        elif (client_request["type"] == "oclc"):
            wms = JanetServWMS.JanetServWMS()
            respuesta.update(wms.cargarInformacionLibro(client_request['content']))
            respuesta['content-type'] = 'single-book'
                
        json_response = json.dumps(respuesta, ensure_ascii=False).encode('utf8')
        return json_response