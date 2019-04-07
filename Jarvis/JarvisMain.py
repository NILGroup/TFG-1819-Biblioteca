# -*- coding: utf-8 -*-
"""
Módulo PLN Codename Jarvis - Proyecto Janet
Versión 0.5.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

import argparse
from bottle import request, route, run, response, static_file, error
import JarvisProcessor
import json

class jarvisService():

    def __init__(self):
        self.procesador = JarvisProcessor.JarvisProcessor()
        
        @route('/',method='POST')
        def do_petition():
            response.content_type = 'application/json'
            response.status = 200

            post_data = {}
            post_data["content"] = request.POST.content
            post_data["user_id"] = request.POST.user_id

            analisis = self.procesador.procesarPeticion(post_data["content"], post_data["user_id"])
            respuesta = self.procesador.formatearResultado(analisis)
            return json.dumps(respuesta, ensure_ascii=False).encode('utf8')

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
        
def initialize():
    tmp = jarvisService().procesador
    parser = argparse.ArgumentParser(
        description='Inicia el entrenador de rasa')

    parser.add_argument(
        '--train', '-t',
        choices=["nlu", "dialogue", "all", "interactive"],
        help="Qué debe hacer el bot?")
    args = parser.parse_args()

    if args.train == "nlu":
        tmp.train_nlu()
        return False
    elif args.train == "dialogue":
        tmp.train_dialogue()
        return False
    elif args.train == "interactive":
        tmp.train_interactive()
        return False
    elif args.train == "all":
        tmp.train_all()
        return False

    return True

    
if __name__ == '__main__':
    jarvisService()
    if initialize():
        run(host='0.0.0.0', port=5000, reloader=True)
    #run(host='0.0.0.0', port=5000, reloader=True)
