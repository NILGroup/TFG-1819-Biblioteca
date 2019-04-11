# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from ActionsController import Action


class ActionFirstBook(Action):

    def __init__(self, mongo, wms):
        Action.__init__(self, mongo, wms)

    def accion(self, intent, entities, response, uid):
        respuesta = response

        historial = self.mongo.obtener_consulta(uid)

        respuesta.update(self.wms.cargarInformacionLibro(historial['oclc1']))
        #self.mongo.guardar_consulta(uid, respuesta, "mas_info_primero")
        respuesta['content-type'] = 'single-book'

        return respuesta
