# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from ActionsController import Action


class ActionAuthor(Action):

    def __init__(self, mongo, wms):
        Action.__init__(self, mongo, wms)

    def accion(self, intent, entities, response, uid):
        respuesta = response

        hayEntitie = False
        for ent in entities:
            if 'autores' in ent:
                hayEntitie = True
        if hayEntitie:
            respuesta['books'] = self.wms.buscarLibro(None, entities['autores'], entities['searchindex'], 'author')
            if not respuesta['books']:
                del respuesta['books']
                respuesta['content-type'] = 'text'
                respuesta['response'] = 'Vaya, parece que no hay libros relacionados con esta consulta'
            else:
                if intent == 'consulta_libros_autor':
                    respuesta['content-type'] = 'list-books'
                    self.mongo.guardar_consulta(uid, respuesta['books'], intent)
                else:
                    respuesta.update(self.wms.cargarInformacionLibro(respuesta['oclc']))
                    respuesta['content-type'] = 'single-book'

        return respuesta
