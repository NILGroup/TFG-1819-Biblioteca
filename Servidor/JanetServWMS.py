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

import urllib
import requests
import json
import lxml.etree as ET
import io
from authliboclc import wskey

class JanetServWMS:

    def __init__(self):
        with open(r'wskey.conf', encoding="utf-8") as f:
            self.__wskeydata = json.load(f)

        with open(r'librarycodes.json', encoding="utf-8") as f:
            self.__equivalencias = json.load(f)

        self.__URLopensearch = "http://www.worldcat.org/webservices/catalog/search/opensearch?"
        self.__URLlibraries = "http://www.worldcat.org/webservices/catalog/content/libraries/"
        self.__URLavailability = "https://www.worldcat.org/circ/availability/sru/service?"

    def buscarLibro(self, title, author, index, type):

        consulta = {"wskey": self.__wskeydata["key"], "count": index + 1, "start": index - 1}
        if type == "kw":
            consulta['q'] = 'srw.kw all "' + title + '"'
        elif type == "title":
            consulta['q'] = 'srw.ti all "' + title + '"'
        elif type == "author":
            consulta['q'] = 'srw.au all "' + author + '"'
        elif type == "kw_author":
            consulta['q'] = 'srw.kw all "' + title + '"' + ' and srw.au all "' + author + '"'
        elif type == "title_author":
            consulta['q'] = 'srw.ti all "' + title + '"' + ' and srw.au all "' + author + '"'
        consulta['q'] = consulta['q'] + 'and srw.li all "' + self.__wskeydata["oclc_symbol"]
        consulta['q'] = consulta['q'] + '" and srw.la all "spa"'
        URL = self.__URLopensearch + urllib.parse.urlencode(consulta)

        reintenta = True
        intentos = 2
        while reintenta:
            try:
                uh = urllib.request.urlopen(URL)
                content = uh.read()
                reintenta = False

            except urllib.error.HTTPError as e:
                if intentos > 0 and e.code == 400:
                    intentos = intentos - 1
                    pass
                else:
                    msg = "Lo lamento, el catálogo de la biblioteca no está disponible en estos momentos. " \
                          "Inténtelo de nuevo más tarde"
                    raise urllib.error.HTTPError(URL, e.code, msg, e.hdrs, e.fp)

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
                if aux.replace('urn:ISBN:', '').isdigit():
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

