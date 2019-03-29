# -*- coding: utf-8 -*-
"""
Módulo PLN Codename Jarvis - Proyecto Janet
Versión 0.5.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

import os
from rasa_nlu.training_data import load_data
from rasa_nlu.components import ComponentBuilder
from rasa_nlu.model import Trainer
from rasa_core.interpreter import RasaNLUInterpreter
from rasa_nlu import config
from rasa_core import train
from rasa_core.domain import Domain
from rasa_core.training import interactive
from rasa_core.agent import Agent
from rasa_core.utils import EndpointConfig
from rasa_core.tracker_store import MongoTrackerStore

class JarvisProcessor():

    def __init__(self):
        directorioModelos = 'model/default/Jarvis'
        if (os.path.isdir(directorioModelos)):
            self.interpreter = RasaNLUInterpreter(directorioModelos)
            action_endopoint = EndpointConfig(url="http://localhost:5055/webhook")
            tracker_store = MongoTrackerStore(domain= Domain.load('model/dialogue/domain.yml'),
                                              host='mongodb://localhost:27017',
                                              db='rasa',
                                              username='rasa',
                                              password='Pitonisa46')
            self.agent = Agent.load('model/dialogue',
                                    interpreter=self.interpreter,
                                    action_endpoint=action_endopoint,
                                    tracker_store=tracker_store)

    def train_nlu(self):
        
        builder = ComponentBuilder(use_cache=False)
        
        self.__trainer_data = load_data("data/jarvis_nlu_model.md")
        self.__trainer = Trainer(config.load("config/config.yml"), builder)
        self.__trainer.train(self.__trainer_data)
        self.__model_directory = self.__trainer.persist('model/',
                                                        fixed_model_name = 'Jarvis')
        
        return self.__model_directory

    def train_dialogue(self, domain_file='data/jarvis_domain.yml',
                       stories_file='data/jarvis_stories_model.md',
                       model_path='model/dialogue',
                       policy_config='config/config.yml'):
        return train.train_dialogue_model(domain_file=domain_file,
                                          stories_file=stories_file,
                                          output_path=model_path,
                                          policy_config=policy_config)


    def train_all(self):
        model_directory = self.train_nlu()
        self.agent = self.train_dialogue()

        return [model_directory, self.agent]

    def train_interactive(self):
        self.train_nlu()
        self.agent = self.train_dialogue()

        return interactive.run_interactive_learning(self.agent)

    def procesarPeticion(self, peticion):

        respuesta = {}

        respuesta["nlu"] = self.interpreter.parse(peticion)
        mensaje = self.agent.handle_message(peticion)
        print(respuesta["nlu"])

        for response in mensaje:
            respuesta["text"] = response["text"]
        print(respuesta["text"])

        return respuesta

    def formatearResultado(self, peticion):
        resultado = {}

        resultado['intent'] = peticion['nlu']['intent']['name']
        resultado['entities'] = []
        
        for entity in peticion['nlu']['entities']:
            tmp = {}
            tmp['type'] = entity['entity']
            tmp['value'] = entity['value']
            resultado['entities'].append(tmp)

        resultado["message"] = peticion["text"]
            
        return resultado


if __name__ == '__main__':
    jarvis = JarvisProcessor()
    while True:
        a = input()
        if a == 'stop':
            break
        responses = jarvis.agent.handle_message(a)
        for response in responses:
            print(response)
            print(response["text"])
