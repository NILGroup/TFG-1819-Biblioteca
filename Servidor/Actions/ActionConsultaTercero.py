# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from ActionsController import Action


class ActionThirdBook(Action):

    def __init__(self, mongo, wms):
        Action.__init__(self, mongo, wms)

    def accion(self, intent, entities, response, uid):
        respuesta = response

        historial = self.mongo.obtener_consulta(uid)

        if 'oclc3' in historial:
            respuesta.update(self.wms.cargarInformacionLibro(historial['oclc3']))
            respuesta['content-type'] = 'single-book'

        return respuesta
