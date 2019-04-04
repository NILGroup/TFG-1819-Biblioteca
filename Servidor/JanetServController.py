# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""
import JanetServJarvis
import JanetServWMS
import JanetServMongo
import json

class JanetServController:

    def __init__(self):
        print("Iniciando módulo Jarvis")
        self.__pln = JanetServJarvis.JanetServJarvis()
        print("Jarvis iniciado")
        print("Iniciando módulo WMS")
        self.__wms = JanetServWMS.JanetServWMS()
        print("WMS iniciado")
        print("Iniciando módulo MongoDB")
        self._mongo = JanetServMongo.JanetServMongo()
        print("MongoDB iniciado")

    def procesarDatos_POST(self, client_request):
        
        respuesta = {}

        if client_request["user_id"] == '':
            raise ValueError('No se ha indicado el id del usuario')

        if client_request["type"] == "query":
            uid = client_request["user_id"]
            pln = self.__pln.consultar(client_request, uid)
            respuesta['content-type'] = 'text'

            respuesta = self._tratar_pln(pln['intent'], pln['entities'], pln['message'], uid)
            
        elif client_request["type"] == "oclc":
            respuesta.update(self.__wms.cargarInformacionLibro(client_request['content']))
            respuesta['content-type'] = 'single-book'

        elif client_request["type"] == "test":
            uid = client_request["user_id"]
            respuesta['content-type'] = 'text'
            respuesta = self._tratar_pln("consulta_libros_kw", {'libros': "Harry Potter", 'searchindex':2}, "Aqui está", uid)

        respuesta["errorno"] = 0

        return json.dumps(respuesta, ensure_ascii=False).encode('utf8')

    def _tratar_pln(self, intent, entities, message, uid):
        respuesta = {}
        respuesta['message'] = message

        if intent == 'consulta_libros_kw' or intent == 'consulta_libro_kw':
            hayEntitie = False
            for ent in entities:
                if 'libros' in ent:
                    hayEntitie = True
            if hayEntitie:
                respuesta['books'] = self.__wms.buscarLibro(entities['libros'], None, entities['searchindex'], "kw")
                if not respuesta['books']:
                    del respuesta['books']
                    respuesta['content-type'] = 'text'
                    respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
                else:
                    if intent == 'consulta_libros_kw':
                        respuesta['content-type'] = 'list-books'
                        self._mongo.guardar_consulta(uid, respuesta['books'], intent)
                    else:
                        respuesta.update(self.__wms.cargarInformacionLibro(respuesta['oclc']))
                        respuesta['content-type'] = 'single-book'
                        self._mongo.guardar_consulta(uid, respuesta, intent)

        elif intent == 'consulta_libros_titulo' or intent == 'consulta_libro_titulo':
            hayEntitie = False
            for ent in entities:
                if 'libros' in ent:
                    hayEntitie = True
            if hayEntitie:
                respuesta['books'] = self.__wms.buscarLibro(entities['libros'], None, entities['searchindex'], 'title')
                if not respuesta['books']:
                    del respuesta['books']
                    respuesta['content-type'] = 'text'
                    respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
                else:
                    if intent == 'consulta_libros_titulo':
                        respuesta['content-type'] = 'list-books'
                        self._mongo.guardar_consulta(uid, respuesta['books'], intent)
                    else:
                        respuesta.update(self.__wms.cargarInformacionLibro(respuesta['oclc']))
                        respuesta['content-type'] = 'single-book'

        elif intent == 'consulta_libros_autor' or intent == 'consulta_libro_autor':
            hayEntitie = False
            for ent in entities:
                if 'autores' in ent:
                    hayEntitie = True
            if hayEntitie:
                respuesta['books'] = self.__wms.buscarLibro(None, entities['autores'], entities['searchindex'], 'author')
                if not respuesta['books']:
                    del respuesta['books']
                    respuesta['content-type'] = 'text'
                    respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
                else:
                    if intent == 'consulta_libros_autor':
                        respuesta['content-type'] = 'list-books'
                        self._mongo.guardar_consulta(uid, respuesta['books'], intent)
                    else:
                        respuesta.update(self.__wms.cargarInformacionLibro(respuesta['oclc']))
                        respuesta['content-type'] = 'single-book'

        elif intent == 'consulta_libros_titulo_autor' or intent == 'consulta_libro_titulo_autor':
            hayautor = False
            haylibro = False
            for ent in entities:
                if 'libros' in ent:
                    haylibro = True
                elif 'autores' in ent:
                    hayautor = True
            if haylibro and hayautor:
                respuesta['books'] = self.__wms.buscarLibro(entities['libros'], entities['autores'],
                                                            entities['searchindex'], 'title_author')
                if not respuesta['books']:
                    del respuesta['books']
                    respuesta['content-type'] = 'text'
                    respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
                else:
                    if intent == 'consulta_libros_titulo_autor':
                        respuesta['content-type'] = 'list-books'
                        self._mongo.guardar_consulta(uid, respuesta['books'], intent)
                    else:
                        respuesta.update(self.__wms.cargarInformacionLibro(respuesta['oclc']))
                        respuesta['content-type'] = 'single-book'

        elif intent == 'consulta_libros_kw_autor' or intent == 'consulta_libro_kw_autor':
            hayautor = False
            haylibro = False
            for ent in entities:
                if 'libros' in ent:
                    haylibro = True
                elif 'autores' in ent:
                    hayautor = True
            if haylibro and hayautor:
                respuesta['books'] = self.__wms.buscarLibro(entities['libros'], entities['autores'],
                                                            entities['searchindex'], 'kw_author')
                if not respuesta['books']:
                    del respuesta['books']
                    respuesta['content-type'] = 'text'
                    respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
                else:
                    if intent == 'consulta_libros_kw_autor':
                        respuesta['content-type'] = 'list-books'
                        self._mongo.guardar_consulta(uid, respuesta['books'], intent)
                    else:
                        respuesta.update(self.__wms.cargarInformacionLibro(respuesta['oclc']))
                        respuesta['content-type'] = 'single-book'

        elif intent == 'consulta_telefono' or intent == 'consulta_telefono_empty':
            hayEntitie = False
            for ent in entities:
                if 'localizacion' in ent:
                    hayEntitie = True
            if hayEntitie:
                tmp = self._mongo.obtener_biblioteca(self._tratarlocalizacion(entities['localizacion']))
                if tmp is not None:
                    respuesta['phone'] = tmp['telefono']
                    respuesta['content-type'] = 'phone'
                else:
                    respuesta['message'] = 'Parece que no existe ninguna biblioteca llamada así.'

        elif intent == 'consulta_localizacion' or intent == 'consulta_localizacion_empty':
            hayEntitie = False
            for ent in entities:
                if 'localizacion' in ent:
                    hayEntitie = True
            if hayEntitie:
                tmp = self._mongo.obtener_biblioteca(self._tratarlocalizacion(entities['localizacion']))
                if tmp is not None:
                    respuesta['location'] = tmp['direccion']
                    respuesta['lat'] = tmp['lat']
                    respuesta['long'] = tmp['long']
                    respuesta['content-type'] = 'location'
                else:
                    respuesta['message'] = 'Parece que no existe ninguna biblioteca llamada así.'

        elif intent == 'busca_mas':
            hayautor = False
            haylibro = False
            for ent in entities:
                if 'libros' in ent:
                    haylibro = True
                elif 'autores' in ent:
                    hayautor = True
            respuesta = {}
            if haylibro and hayautor:
                respuesta['books'] = self.__wms.buscarLibro(entities['libros'], entities['autores'],
                                                            entities['searchindex'], 'kw_author')
            elif haylibro:
                respuesta['books'] = self.__wms.buscarLibro(entities['libros'], None,
                                                            entities['searchindex'], 'kw_author')
                if not respuesta['books']:
                    del respuesta['books']
                    respuesta['content-type'] = 'text'
                    respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
                else:
                    if intent == 'consulta_libros_kw_autor':
                        respuesta['content-type'] = 'list-books'
                    else:
                        respuesta.update(self.__wms.cargarInformacionLibro(respuesta['oclc']))
                        respuesta['content-type'] = 'single-book'

        return respuesta

    def _tratarlocalizacion(self, localizacion):
        respuesta = localizacion.replace('biblioteca de ', '')
        respuesta = respuesta.replace('facultad de ', '')
        respuesta = respuesta.replace('Biblioteca de ', '')
        respuesta = respuesta.replace('Facultad de ', '')
        respuesta = respuesta.replace('Biblioteca De ', '')
        respuesta = respuesta.replace('Facultad De ', '')
        respuesta = respuesta.replace('BIBLIOTECA DE ', '')
        respuesta = respuesta.replace('FACULTAD DE ', '')

        return respuesta
