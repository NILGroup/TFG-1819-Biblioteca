# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.1.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

import urllib
import requests
import json
from xml.etree import ElementTree

class JanetServWMS():
    
    def buscar(self, datos_consulta):
        
        with open('wskey.conf') as f:
            wskeydata = json.load(f)
            
        URL = "http://www.worldcat.org/webservices/catalog/search/opensearch?"
        
        print(datos_consulta)
        
        consulta = {"wskey": wskeydata["key"]}
        if 'title' in datos_consulta:
            consulta['q'] = 'srw.ti all ' + datos_consulta['title']
        elif 'author' in datos_consulta:
            consulta['q'] = 'srw.au all ' + datos_consulta['author']
        else:
            consulta['q'] = datos_consulta['generic']
        
        URL = URL + urllib.parse.urlencode(consulta)
        r = requests.get(url = URL)
        tree = ElementTree.fromstring(r.content)
        print (tree)
        
        
        
        