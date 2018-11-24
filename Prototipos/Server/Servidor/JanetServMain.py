# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.3.0 - Supplemental Update

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from bottle import request, route, run, response, static_file
import JanetServProcessor

class janetService():
    
    @route('/mobilenative',method='POST')
    def do_Mobile():
        response.content_type = 'application/json'
        response.status = 200
        print("Usuario conectado por POST")
        
        post_data = {}
        post_data["content"] = request.POST.get('content')
        procesador = JanetServProcessor.JanetServProcessor()
        respuesta = procesador.procesarDatos_POST(post_data)
        return respuesta
        
    @route('/',method='GET')
    def do_test():
        HTML = '''<img src="static/icon.png" alt="Logo" width="500" height="500"> <br> <h1> No deberias estar aqui! </h1> <p> Esta direccion es de prueba, conectate con un cliente.</p>'''
        return HTML

    @route('/static/<filepath:path>')
    def server_static(filepath):
        return static_file(filepath, root='./')
        
#DESHABILITADO PARA FUNCIONAR CON WSGI
#if __name__ == "__main__":
    #from sys import argv
    
    #if len(argv) == 2:
        #run(host='localhost', port=80, debug=True)
    #else:
        #run(host='0.0.0.0', port=80)
