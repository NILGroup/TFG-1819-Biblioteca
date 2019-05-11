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
            if len(respuesta['books']) == 1:
                    respuesta.update(self.wms.cargarInformacionLibro(respuesta['books'][0]['oclc']))
                    del respuesta['books']
                    respuesta['content-type'] = 'single-book'
                    self.mongo.guardar_consulta(uid, respuesta, intentant.replace('libros', 'libro'))
                    return respuesta
            elif intentant == 'consulta_libros_kw' or intentant == 'consulta_libros_titulo' or \
                    intentant == 'consulta_libros_autor' or intentant == 'consulta_libros_titulo_autor' \
                    or intentant == 'consulta_libros_kw_autor':
                respuesta['content-type'] = 'list-books'
            else:
                respuesta.update(self.wms.cargarInformacionLibro(respuesta['books'][0]['oclc']))
                del respuesta['books']
                respuesta['content-type'] = 'single-book'
            self.mongo.guardar_consulta(uid, respuesta, intentant)

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
