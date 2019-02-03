# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.1.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from bottle import request, route, run, response, static_file, error
import JanetServProcessor
import json

class janetService():
    
    @route('/mobilenative',method='POST')
    def do_Mobile():
        response.content_type = 'application/json'
        response.status = 200
        print("Usuario conectado por POST")
        
        post_data = {}
        post_data["type"] = request.POST.type
        post_data["content"] = request.POST.content
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
    
    @error(400)
    def custom400 (error):
        '''Cuando ocurre un error, bottle no lo convierte en JSON automáticamente,
        así que lo hacemos nosotros. Primero ponemos el `content_type`, y luego
        hacemos el `json.dumps` del diccionario. En el error 400, decimos que ha
        habido un error y en los detalles ponemos la explicación para que el usuario
        sepa qué ha hecho mal.'''
        response.content_type = 'application/json'
        return json.dumps({
            'errorno': 400,
            'errorMessage': error.body
        })
    
    @error(404)
    def custom404 (error):
        '''El error 404 no necesita demasiada información.'''
        response.content_type = 'application/json'
        return json.dumps({
            'errorno': 404,
            'errorMessage': 'No existe el recurso solicitado.'
        })

    @error(500)
    def custom500 (error):
        '''En el caso del error 500, no le damos información al usuario porque son
        detalles de nuestro servidor y puede ser un fallo de seguridad. Estos
        errores ocurren cuando nuestro código python ha fallado, por lo que habrá
        que mirar la salida de error del programa para verlos.'''
        response.content_type = 'application/json'
        return json.dumps({
            'errorno': 500,
            'errorMessage': 'Ha habido un problema imprevisto.',
        })
        
run(host='0.0.0.0', port=8080, reloader=True)