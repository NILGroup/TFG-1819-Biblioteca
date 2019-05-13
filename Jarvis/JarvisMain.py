# -*- coding: utf-8 -*-
"""
Módulo PLN Jarvis - Proyecto Janet
Versión 1.0

MIT License

Copyright (c) 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""

import argparse
from bottle import request, route, run, response, static_file, error
import JarvisProcessor
import json
import logging

class jarvisService():

    def __init__(self):

        # Creacion de logger
        logger = logging.getLogger('jarvis')
        logger.setLevel(logging.INFO)
        file_handler = logging.FileHandler('jarvis.log', 'w', 'utf-8')
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(formatter)
        logger.addHandler(file_handler)

        self.procesador = JarvisProcessor.JarvisProcessor(logger)
        
        @route('/',method='POST')
        def do_petition():
            response.content_type = 'application/json'
            response.status = 200

            post_data = {}
            post_data["content"] = request.POST.content
            post_data["user_id"] = request.POST.user_id

            if post_data["content"] == '/restart':
                self.procesador.reiniciarSlots(post_data["user_id"])

            else:
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
            logger.error('Error 400: ' + error.body)
            return json.dumps({
                'errorno': 400,
                'errorMessage': error.body
            })

        @error(404)
        def custom404 (error):
            '''El error 404 no necesita demasiada información.'''
            response.content_type = 'application/json'
            logger.error('Error 404: ' + error.body)
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
            logger.error('Error 500: ' + str(error.exception))
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
        run(host='0.0.0.0', port=5000)
