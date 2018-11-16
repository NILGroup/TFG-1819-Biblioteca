# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.3.0 - Supplemental Update

Módulo de conexión con IBM Watson Assistant

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""
import json
from watson_developer_cloud import NaturalLanguageUnderstandingV1
from watson_developer_cloud.natural_language_understanding_v1 import Features, EntitiesOptions, KeywordsOptions, EmotionOptions

with open('credentials.conf') as f:
    data = json.load(f)

service = NaturalLanguageUnderstandingV1(
    version='2018-03-16',
    ## url is optional, and defaults to the URL below. Use the correct URL for your region.
    url='https://gateway.watsonplatform.net/natural-language-understanding/api',
    username=data["username"],
    password=data["pass"])

response = service.analyze(
    text="I like apples. Ireally hates oranges!.",
    features=Features(
            entities=EntitiesOptions(),
            keywords=KeywordsOptions(),
            emotion=EmotionOptions()
    )
).get_result()

print(json.dumps(response, indent=2))