# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from ActionsController import Action


class ActionMoreBooks(Action):

    def __init__(self, mongo, wms):
        Action.__init__(self, mongo, wms)

    def accion(self, intent, entities, response, uid):
        respuesta = response

        historial = self.mongo.obtener_consulta(uid)
        intentant = historial['intent']
        hayautor = False
        haylibro = False
        for ent in entities:
            if 'libro' in ent:
                haylibro = True
            elif 'autores' in ent:
                hayautor = True

        if haylibro and hayautor:
            respuesta['books'] = self.wms.buscarLibro(entities['libro'], entities['autores'],
                                                        entities['searchindex'], self._acortarkwconsulta(intentant))
        elif haylibro:
            respuesta['books'] = self.wms.buscarLibro(entities['libro'], None,
                                                        entities['searchindex'], self._acortarkwconsulta(intentant))
        elif hayautor:
            respuesta['books'] = self.wms.buscarLibro(None, entities['autores'],
                                                        entities['searchindex'], self._acortarkwconsulta(intentant))
        if not respuesta['books']:
            del respuesta['books']
            respuesta['content-type'] = 'text'
            respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
        else:
            if intentant == 'consulta_libros_kw' or intentant == 'consulta_libros_titulo' or \
                    intentant == 'consulta_libros_autor' or intentant == 'consulta_libros_titulo_autor' \
                    or intentant == 'consulta_libros_kw_autor':
                respuesta['content-type'] = 'list-books'
            else:
                respuesta.update(self.wms.cargarInformacionLibro(respuesta['books'][0]['oclc']))
                del respuesta['books']
                respuesta['content-type'] = 'single-book'
            self.mongo.guardar_consulta(uid, respuesta, intent)

        return respuesta

    def _acortarkwconsulta(self, intent):
        if intent == 'consulta_libros_kw' or intent == 'consulta_libro_kw':
            return 'kw'
        elif intent == 'consulta_libros_titulo' or intent == 'consulta_libro_titulo':
            return 'title'
        elif intent == 'consulta_libros_autor' or intent == 'consulta_libro_autor':
            return 'author'
        elif intent == 'consulta_libros_titulo_autor' or intent == 'consulta_libro_titulo_autor':
            return 'title_author'
        elif intent == 'consulta_libros_kw_autor' or intent == 'consulta_libro_kw_autor':
            return 'kw_autor'
        else:
            return None
