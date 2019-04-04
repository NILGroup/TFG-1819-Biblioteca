# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from pymongo import MongoClient


class JanetServMongo:

    def __init__(self):
        self._client = MongoClient('mongodb://localhost:27017')
        self._db = self._client.janet
        # Issue the serverStatus command and print the results
        # serverStatusResult = self._db.command("serverStatus")
        # pprint(serverStatusResult)

    def obtener_biblioteca(self, nombre):
        collection = self._db.localizaciones

        cursor = collection.find({"$text": {'$search': nombre}}, {'_id': False, 'kw': False, 'score':
            {'$meta': "textScore"}}).sort([('score', {'$meta': "textScore"})]).limit(1)

        for doc in cursor:
            return doc

    def guardar_consulta(self, user_id, consulta, intent):
        collection = self._db.historial
        cods = {}
        i = 1

        for item in consulta:
            cods['oclc'+repr(i)] = item['oclc']
            i = i + 1

        if 'oclc2' in cods and 'oclc3' in cods:
            collection.update({"_id": user_id}, {'oclc1': cods['oclc1'], 'oclc2': cods['oclc2'],
                                             'oclc3': cods['oclc3'], 'intent': intent},
                              upsert=True)
        else:
            collection.update({"_id": user_id}, {'oclc1': cods['oclc1'], 'intent': intent},
                              upsert=True)

    def obtener_consulta(self, user_id):
        collection = self._db.historial

        return collection.find_one({"_id": user_id})
