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
#from xml.etree import ElementTree
from bs4 import BeautifulSoup

class JanetServWMS():
    
    def buscar(self, datos_consulta):
        
        with open('wskey.conf') as f:
            wskeydata = json.load(f)
            
        URL = "http://www.worldcat.org/webservices/catalog/search/opensearch?"
        
        consulta = {"wskey": wskeydata["key"]}
        if 'title' in datos_consulta:
            consulta['q'] = 'srw.ti all ' + datos_consulta['title']
        elif 'author' in datos_consulta:
            consulta['q'] = 'srw.au all ' + datos_consulta['author']
        else:
            consulta['q'] = datos_consulta['generic']
        
        URL = URL + urllib.parse.urlencode(consulta)
        r = requests.get(url = URL)
        content = r.content
        #print (content)
        soup = BeautifulSoup(content, 'lxml')
        codsOCLC = []
        for item in soup.findAll('entry'):
            codsOCLC.append(item.find("oclcterms:recordidentifier").string)
        
        return codsOCLC
        
    def cargarInformacion(self, codigosOCLC):
        
        with open('wskey.conf') as f:
            wskeydata = json.load(f)
            
        URL = "http://www.worldcat.org/webservices/catalog/content/libraries/"
        URL = URL + codigosOCLC[0] + '?'
        
        consulta = {"wskey": wskeydata["key"], "format": "json", "oclcsymbol": wskeydata["oclc_symbol"]}
        URL = URL + urllib.parse.urlencode(consulta)
        
        r = requests.get(url = URL)
        content = r.json()
        
        urlGoogleBooks = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + content['ISBN'][0]
        rGoogle = requests.get(url = urlGoogleBooks)
        contenidoGoogle = rGoogle.json()
        
        print (contenidoGoogle)
        
        respuesta = {}
        
        respuesta['title'] = content['title']
        respuesta['author'] = content['author']
        respuesta['available'] = True
        #if not contenidoGoogle['items']:
        respuesta['cover-art'] = contenidoGoogle['items'][0]['volumeInfo']['imageLinks']['thumbnail']
        #else:
            #respuesta['cover-art'] = 'null'
        respuesta['library'] = 'Not Found' 
        
        return respuesta
        
        