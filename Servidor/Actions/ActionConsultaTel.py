# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
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

from ActionsController import Action


class ActionPhone(Action):

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
            if tmp is not None:
                respuesta['phone'] = tmp['telefono']
                respuesta['library'] = tmp['name']
                respuesta['content-type'] = 'phone'
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
