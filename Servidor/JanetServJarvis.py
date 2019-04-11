# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from urllib import request, parse
import json

class JanetServJarvis():

    def consultar(self, pregunta, id):
        contenido = pregunta
        contenido = contenido[0].lower() + contenido[1:]
        data = {'user_id': id, 'content': contenido}

        req = request.Request("http://localhost:5000", data=parse.urlencode(data).encode())

        resp = request.urlopen(req)

        return json.load(resp)

    def restart(self, id):
        data = {'user_id': id, 'content': '/restart'}

        req = request.Request("http://localhost:5000", data=parse.urlencode(data).encode())
        request.urlopen(req)