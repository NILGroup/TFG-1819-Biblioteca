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

from pymongo import MongoClient
from datetime import datetime
import json


class JanetServMongo:

    """"Carga la URL de la localización de Mongo del fichero 'parameters.conf'"""
    def __init__(self):
        with open(r'parameters.conf', encoding="utf-8") as f:
            datos = json.load(f)
            self._client = MongoClient(datos['urlMongo'])
            self._db = self._client.janet

    def obtener_biblioteca(self, nombre):
        collection = self._db.localizaciones

        cursor = collection.find({"$text": {'$search': nombre}}, {'_id': False, 'kw': False, 'score':
            {'$meta': "textScore"}}).sort([('score', {'$meta': "textScore"})]).limit(1)

        for doc in cursor:
            return doc

    def guardar_consulta(self, user_id, consulta, intent):
        collection = self._db.historial

        if "books" in consulta:
            cods = {'$set': {}}
            i = 1

            cods['$set']['intent'] = intent
            for item in consulta['books']:
                cods['$set']['oclc'+repr(i)] = item['oclc']
                i = i + 1
            collection.update({"_id": int(user_id)}, cods, upsert=True)
        else:
            collection.update({"_id": int(user_id)}, {'$set': {'oclc1': consulta['oclc'], 'intent': intent}, '$unset': {'oclc2': '', 'oclc3': ''}}, upsert=True)

    def guardar_timestamp(self, user_id):
        collection = self._db.historial
        collection.update({"_id": int(user_id)}, {'$set': {'timestamp': datetime.now().timestamp()}}, upsert=True)


    def reiniciar_consulta(self, user_id,):
        collection = self._db.historial

        collection.update({"_id": int(user_id)}, {}, upsert=True)

    def obtener_consulta(self, user_id):
        collection = self._db.historial

        return collection.find_one({"_id": int(user_id)})

    def obtener_ultimo_id(self):
        collection = self._db.historial

        if collection.count() == 0:
            return 0

        return collection.find_one({}, sort=([('_id', -1)]))['_id']

    def add_usuario(self, user_id):
        collection = self._db.historial

        return collection.update({"_id": int(user_id)}, {}, upsert=True)
