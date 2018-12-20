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
            if (respuesta['has-extra-data']):
                wms = JanetServWMS.JanetServWMS()
                respuesta['books'] = wms.buscarLibros(respuesta['extra-data'][0])
                
                if not respuesta['books']:
                    del respuesta['books']
                    respuesta['content-type'] = 'text'
                    respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
                else:
                    respuesta['content-type'] = 'list-books'
                del respuesta['extra-data']
                
            del respuesta['has-extra-data']
            
        elif (client_request["type"] == "oclc"):
            wms = JanetServWMS.JanetServWMS()
            respuesta.update(wms.cargarInformacionLibro(client_request['content']))
            respuesta['content-type'] = 'single-book'
        
        respuesta["errorno"] = 0

        return json.dumps(respuesta, ensure_ascii=False).encode('utf8')