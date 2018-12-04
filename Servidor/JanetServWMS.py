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
from authliboclc import wskey

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
        
        respuesta = {}
        
        if 'ISBN' in content:
            urlGoogleBooks = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + content['ISBN'][0]
            rGoogle = requests.get(url = urlGoogleBooks)
            #contenidoGoogle = rGoogle.json()
            if (rGoogle.json()['totalItems'] == 0):
                respuesta['cover-art'] = 'null'
            else: #contenidoGoogle['items']:
                respuesta['cover-art'] = rGoogle.json()['items'][0]['volumeInfo']['imageLinks']['thumbnail']
            #print (contenidoGoogle)
        
        respuesta['title'] = content['title']
        respuesta['author'] = content['author']
        respuesta['available'] = self.comprobarDisponibilidad(codigosOCLC)
        respuesta['library'] = content['library'][0]['institutionName']
        
        
        return respuesta
    
    def comprobarDisponibilidad(self, codigosOCLC):
        with open('wskey.conf') as f:
            wskeydata = json.load(f)
            
        URL = "https://www.worldcat.org/circ/availability/sru/service?"
        URL = URL + "query=no%3Aocm" + codigosOCLC[0] + "&x-registryId=" + wskeydata['registry_id']
        
        APIkey = wskeydata['key']
        secret = wskeydata['secret']
        
        my_wskey = wskey.Wskey(key=APIkey, secret=secret, options=None)
        
        authorization_header = my_wskey.get_hmac_signature(
                method='GET',
                request_url=URL,
                options=None)
        
        r = urllib.request.Request(url = URL, headers={
                'Authorization': authorization_header})
        response = urllib.request.urlopen(r)
        
        content = response.read()
        #print (content)
        
        xmlns = {'sRR': 'http://www.loc.gov/zing/srw/'}
                         #'oclcterms': 'http://purl.org/oclc/terms/'}
        tree = ET.parse(io.BytesIO(content))
        
        root = tree.getroot()
        
        #print(root)
        
        for holdings in root.findall('.//sRR:records/sRR:record/sRR:recordData/opacRecord/holdings', xmlns):
            for items in holdings.findall('.//holding/circulations'):
                for item in items.findall('.//circulation'):
                    #print (item.find('availableNow').get('value'))
                    #print (item.get('availableNow'))
                    if (int(item.find('availableNow').get('value')) > 0): return True
                    
            #codsOCLC.append(item.find("oclcterms:recordIdentifier", xmlnamespaces).text)
        return False