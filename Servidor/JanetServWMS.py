# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.1

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

import urllib
import requests
import json
import lxml.etree as ET
import io
from authliboclc import wskey

class JanetServWMS:

    def __init__(self):
        with open(r'wskey.conf') as f:
            self.__wskeydata = json.load(f)

        with open(r'librarycodes.json') as f:
            self.__equivalencias = json.load(f, encoding="ANSI")

        self.__URLopensearch = "http://www.worldcat.org/webservices/catalog/search/opensearch?"
        self.__URLlibraries = "http://www.worldcat.org/webservices/catalog/content/libraries/"
        self.__URLavailability = "https://www.worldcat.org/circ/availability/sru/service?"
        self.__URLCovers = "https://covers.openlibrary.org/b/isbn/"

    def buscarLibro(self, title, author, index, type):
        consulta = {"wskey": self.__wskeydata["key"], "count": index + 1, "start": index - 1}
        if type == "kw":
            consulta['q'] = 'srw.kw all "' + title + '"'
        elif type == "title":
            consulta['q'] = 'srw.ti all "' + title + '"'
        elif type == "author":
            consulta['q'] = 'srw.au all "' + author + '"'
        elif type == "kw_author":
            consulta['q'] = 'srw.kw all "' + title + '"' + ' srw.au all "' + author + '"'
        elif type == "title_author":
            consulta['q'] = 'srw.ti all "' + title + '"' + ' srw.au all "' + author + '"'
        consulta['q'] = consulta['q'] + 'and srw.li all "' + self.__wskeydata["oclc_symbol"]
        consulta['q'] = consulta['q'] + '" and srw.la all "spa"'
        URL = self.__URLopensearch + urllib.parse.urlencode(consulta)
        uh = urllib.request.urlopen(URL)
        content = uh.read()

        xmlnamespaces = {'Atom': 'http://www.w3.org/2005/Atom',
                         'oclcterms': 'http://purl.org/oclc/terms/',
                         'dc': 'http://purl.org/dc/elements/1.1/'}
        tree = ET.parse(io.BytesIO(content))

        root = tree.getroot()

        respuesta = []
        for item in root.findall('Atom:entry', xmlnamespaces):
            isbn = []
            for tmp in item.findall("dc:identifier", xmlnamespaces):
                aux = tmp.text
                isbn.append(aux.replace('urn:ISBN:', ''))
            temp = {"title": item.find("Atom:title", xmlnamespaces).text,
                    "author": item.find("Atom:author/Atom:name", xmlnamespaces).text,
                    "oclc": item.find("oclcterms:recordIdentifier", xmlnamespaces).text,
                    "isbn": isbn}
            respuesta.append(temp)

        return respuesta
        
    def cargarInformacionLibro(self, codigoOCLC):

        URL = self.__URLlibraries + codigoOCLC + '?'
        
        consulta = {"wskey": self.__wskeydata["key"], "format": "json",
                    "oclcsymbol": self.__wskeydata["oclc_symbol"], "location": "Spain"}
        URL = URL + urllib.parse.urlencode(consulta)
        
        r = requests.get(url=URL)
        content = r.json()
        
        respuesta = {}

        respuesta['response'] = "Aquí tienes el libro que me pediste"
        respuesta['title'] = content['title']
        respuesta['author'] = content['author']
        respuesta['available'] = self.comprobarDisponibilidad(codigoOCLC)
        respuesta['oclc'] = content['OCLCnumber']
        respuesta['url'] = content['library'][0]['opacUrl']

        if 'ISBN' in content:
            respuesta['isbn'] = content['ISBN']
        
        return respuesta
    
    def comprobarDisponibilidad(self, codigosOCLC):

        URL = self.__URLavailability + "query=no%3Aocm" + codigosOCLC + "&x-registryId=" +\
              self.__wskeydata['registry_id']
        
        APIkey = self.__wskeydata['key']
        secret = self.__wskeydata['secret']
        
        my_wskey = wskey.Wskey(key=APIkey, secret=secret, options=None)
        
        authorization_header = my_wskey.get_hmac_signature(
                method='GET',
                request_url=URL,
                options=None)
        
        r = urllib.request.Request(url=URL, headers={
                'Authorization': authorization_header})
        response = urllib.request.urlopen(r)
        
        content = response.read()
        
        xmlns = {'sRR': 'http://www.loc.gov/zing/srw/'}
        
        tree = ET.parse(io.BytesIO(content))
        root = tree.getroot()

        resultado = []
        biblioteca = {}
        
        for holdings in root.findall('.//sRR:records/sRR:record/sRR:recordData/opacRecord/holdings', xmlns):
            for items in holdings.iterdescendants('holding'):
                for item in items.findall('.//circulation'):
                    if int(item.find('availableNow').get('value')) > 0:
                        if self.__equivalencias[items.find('localLocation').text] not in biblioteca:
                            biblioteca[self.__equivalencias[items.find('localLocation').text]] = \
                                int(item.find('availableNow').get('value'))
                        else:
                            biblioteca[self.__equivalencias[items.find('localLocation').text]] += \
                                int(item.find('availableNow').get('value'))

        resultado.append(biblioteca)
        return resultado

