# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from ActionsController import Action


class ActionLocation(Action):

    def __init__(self, mongo, wms):
        Action.__init__(self, mongo, wms)

    def accion(self, intent, entities, response, uid):
        respuesta = response

        hayEntitie = False
        for ent in entities:
            if 'localizacion' in ent:
                hayEntitie = True
        if hayEntitie:
            tmp = self.mongo.obtener_biblioteca(self._tratarlocalizacion(entities['localizacion']))
            print(tmp)
            if tmp is not None:
                respuesta['library'] = tmp['name']
                respuesta['location'] = tmp['direccion']
                respuesta['lat'] = tmp['lat']
                respuesta['long'] = tmp['long']
                respuesta['content-type'] = 'location'
            else:
                respuesta['response'] = 'Parece que no existe ninguna biblioteca llamada así.'

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
