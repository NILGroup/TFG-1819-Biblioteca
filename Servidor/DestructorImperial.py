# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Destructor Imperial
Versión 0.9.1

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from pymongo import MongoClient
from datetime import datetime, timedelta
from urllib import request, parse

client = MongoClient('mongodb://localhost:27017')
db = client.rasa
collection = db.conversations

cursor = collection.find()

for doc in cursor:
    destruir = True
    if doc["slots"]["autores"] is None and doc["slots"]["libro"] is None and doc["slots"]["localizacion"] is None \
            and doc["slots"]["numberofmorebooksearch"] is None and \
            doc["slots"]["requested_slot"] is None and doc["slots"]["searchindex"] is None:
        destruir = False
    rasaDate = datetime.fromtimestamp(doc["latest_event_time"])
    actualDate = datetime.now() - timedelta(minutes=15)
    if rasaDate < actualDate and destruir:
        data = {'user_id': doc["sender_id"], 'type': 'restart'}
        req = request.Request("http://localhost:80/api", data=parse.urlencode(data).encode())

        request.urlopen(req)
