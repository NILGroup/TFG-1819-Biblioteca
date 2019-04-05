# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from ActionsController import Action


class ActionKwAuthor(Action):

    def __init__(self, mongo, wms):
        Action.__init__(self, mongo, wms)

    def accion(self, intent, entities, response, uid):
        respuesta = response

        hayautor = False
        haylibro = False
        for ent in entities:
            if 'libros' in ent:
                haylibro = True
            elif 'autores' in ent:
                hayautor = True
        if haylibro and hayautor:
            respuesta['books'] = self.wms.buscarLibro(entities['libros'], entities['autores'],
                                                        entities['searchindex'], 'kw_author')
            if not respuesta['books']:
                del respuesta['books']
                respuesta['content-type'] = 'text'
                respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
            else:
                if intent == 'consulta_libros_kw_autor':
                    respuesta['content-type'] = 'list-books'
                else:
                    respuesta.update(self.wms.cargarInformacionLibro(respuesta['books'][0]['oclc']))
                    del respuesta['books']
                    respuesta['content-type'] = 'single-book'
                self.mongo.guardar_consulta(uid, respuesta, intent)

        return respuesta
