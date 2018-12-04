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
import lxml.etree as ET
import io

class JanetServWMS():
    
    def buscar(self, datos_consulta):
        
        with open('wskey.conf') as f:
            wskeydata = json.load(f)
            
        URL = "http://www.worldcat.org/webservices/catalog/search/opensearch?"
        
        consulta = {"wskey": wskeydata["key"]}
        if 'title' in datos_consulta:
            consulta['q'] = 'srw.ti all "' + datos_consulta['title'] + '"'
        elif 'author' in datos_consulta:
            consulta['q'] = 'srw.au all "' + datos_consulta['author'] + '"'
        else:
            consulta['q'] = 'srw.kw all "' + datos_consulta['generic'] + '"'
        consulta['q'] = consulta['q'] + 'and srw.li all "' + wskeydata["oclc_symbol"] + '" and srw.la all "spa"'
        URL = URL + urllib.parse.urlencode(consulta)
        uh = urllib.request.urlopen(URL)
        content = uh.read()
        
        xmlnamespaces = {'Atom': 'http://www.w3.org/2005/Atom',
                         'oclcterms': 'http://purl.org/oclc/terms/'}
        tree = ET.parse(io.BytesIO(content))
        
        root = tree.getroot()
        
        codsOCLC = []
        for item in root.findall('Atom:entry', xmlnamespaces):
            codsOCLC.append(item.find("oclcterms:recordIdentifier", xmlnamespaces).text)
        
        #print (codsOCLC)
        
        return codsOCLC
        
    def cargarInformacion(self, codigosOCLC):
        
        with open('wskey.conf') as f:
            wskeydata = json.load(f)
            
        URL = "http://www.worldcat.org/webservices/catalog/content/libraries/"
        URL = URL + codigosOCLC[0] + '?'
        
        consulta = {"wskey": wskeydata["key"], "format": "json", 
                    "oclcsymbol": wskeydata["oclc_symbol"], "location": "Spain"}
        URL = URL + urllib.parse.urlencode(consulta)
        
        r = requests.get(url = URL)
        content = r.json()
        #print (content)
        
        contenidoGoogle = {}
        
        if content['ISBN']:
            urlGoogleBooks = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + content['ISBN'][0]
            rGoogle = requests.get(url = urlGoogleBooks)
            contenidoGoogle = rGoogle.json()
        
            #print (contenidoGoogle)
        
        respuesta = {}
        
        respuesta['title'] = content['title']
        respuesta['author'] = content['author']
        respuesta['available'] = True
        respuesta['library'] = content['library'][0]['institutionName']
        if (contenidoGoogle['totalItems'] == 0):
            respuesta['cover-art'] = 'null'
        else: #contenidoGoogle['items']:
            respuesta['cover-art'] = contenidoGoogle['items'][0]['volumeInfo']['imageLinks']['thumbnail']
        #else:
            #respuesta['cover-art'] = 'null'
        
        return respuesta
    
    def comprobarDisponibilidad(self, codigosOCLC):
        with open('wskey.conf') as f:
            wskeydata = json.load(f)
            
        URL = "http://www.worldcat.org/webservices/catalog/search/opensearch?"
        
        