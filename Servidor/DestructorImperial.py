# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Destructor Imperial
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
