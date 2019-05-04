# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 1.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from pymongo import MongoClient
from datetime import datetime


class JanetServMongo:

    def __init__(self):
        self._client = MongoClient('mongodb://localhost:27017')
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
