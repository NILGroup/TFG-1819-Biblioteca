# -*- coding: utf-8 -*-
"""
Módulo PLN Codename Jarvis - Proyecto Janet
Versión 0.9.0

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
from rasa_core.events import SlotSet
from rasa_core.domain import Domain
from rasa_core.training import interactive
from rasa_core.agent import Agent
from rasa_core.utils import EndpointConfig
from rasa_core.tracker_store import MongoTrackerStore


class JarvisProcessor():

    def __init__(self, log):
        self.logger = log
        directorioModelos = 'model/default/Jarvis'
        if (os.path.isdir(directorioModelos)):
            self.interpreter = RasaNLUInterpreter(model_directory=directorioModelos)
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
            self._slots = {}

    def train_nlu(self):
        
        builder = ComponentBuilder(use_cache=False)
        
        self.__trainer_data = load_data("data/nlu.md")
        self.__trainer = Trainer(config.load("config/config.yml"), builder)
        self.__trainer.train(self.__trainer_data)
        self.__model_directory = self.__trainer.persist('model/',
                                                        fixed_model_name = 'Jarvis')
        
        return self.__model_directory

    def train_dialogue(self, domain_file='domain.yml',
                       stories_file='data/stories.md',
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

    def reiniciarSlots(self, senderid):
        tracker = self.agent.tracker_store.get_or_create_tracker(sender_id=senderid)

        tracker.update(SlotSet('autores', None))
        tracker.update(SlotSet('libro', None))
        tracker.update(SlotSet('localizacion', None))
        tracker.update(SlotSet('numberofmorebooksearch', None))
        tracker.update(SlotSet('requested_slot', None))
        tracker.update(SlotSet('searchindex', None))

        self.agent.tracker_store.save(tracker)
        self.logger.info('Usuario ' + senderid + ' reiniciado')

    def procesarPeticion(self, peticion, senderid='default'):

        respuesta = {}

        respuesta["nlu"] = self.interpreter.parse(peticion)
        mensaje = self.agent.handle_text(text_message=peticion, sender_id=senderid)
        tracker = self.agent.tracker_store.get_or_create_tracker(sender_id=senderid)

        self._slots = self.__rellenaSlots(tracker)

        for response in mensaje:
            respuesta["text"] = response["text"]

        self.logger.info('Usuario ' + senderid + ':\n' + str(respuesta))

        if respuesta["nlu"]["intent"]["confidence"] < 0.15:
            respuesta["nlu"]["intent"]["name"] = "no_entiendo"

        return respuesta

    def formatearResultado(self, peticion):
        resultado = {}

        resultado['intent'] = peticion['nlu']['intent']['name']
        resultado['entities'] = {}
        tmp = {}

        if resultado['intent'] == 'consulta_telefono' or resultado['intent'] == \
                'consulta_localizacion_empty' or resultado['intent'] == 'consulta_telefono_empty' \
                or resultado['intent'] == 'consulta_localizacion' or resultado['intent'] == \
                'consulta_horario_close' or resultado['intent'] == 'consulta_horario_general' \
                or resultado['intent'] == 'consulta_horario_open':
            if self._slots['localizacion'] is not None:
                tmp['localizacion'] = self._slots['localizacion']

        elif resultado['intent'] == 'consulta_libros_kw' or resultado['intent'] == \
                'consulta_libro_kw' or resultado['intent'] == 'consulta_libros_titulo' \
                or resultado['intent'] == 'consulta_libro_autor' or resultado['intent'] == \
                'consulta_libros_titulo_autor' or resultado['intent'] == 'consulta_libros_kw_autor' \
                or resultado['intent'] == 'consulta_libro_kw_autor' or resultado['intent'] == \
                'consulta_libros_autor' or resultado['intent'] == 'consulta_libro_titulo_autor' \
                or resultado['intent'] == 'consulta_libro_titulo':
            if self._slots['libro'] is not None:
                tmp['libro'] = self._slots['libro']
            if self._slots['autores'] is not None:
                tmp['autores'] = self._slots['autores']
            tmp['searchindex'] = self._slots['searchindex']

        elif resultado['intent'] == 'busca_mas' or resultado['intent'] == \
                'mas_info_primero' or resultado['intent'] == 'mas_info_segundo' or \
                resultado['intent'] == 'mas_info_tercero':
            if self._slots['libro'] is not None:
                tmp['libro'] = self._slots['libro']
            if self._slots['autores'] is not None:
                tmp['autores'] = self._slots['autores']

            tmp['searchindex'] = self._slots['searchindex']

        resultado['message'] = peticion['text']
        resultado['entities'] = tmp
            
        return resultado

    def __rellenaSlots(self, tracker):
        list = {}
        list['libro'] = tracker.get_slot("libro")
        list['articulos'] = tracker.get_slot("articulos")
        list['autores'] = tracker.get_slot("autores")
        list['localizacion'] = tracker.get_slot("localizacion")
        list['musica'] = tracker.get_slot("musica")
        list['pelicula'] = tracker.get_slot("pelicula")
        list['persona'] = tracker.get_slot("persona")
        list['searchindex'] = tracker.get_slot("searchindex")

        return list


if __name__ == '__main__':
    jarvis = JarvisProcessor()
    while True:
        a = input()
        if a == 'stop':
            break
        responses = jarvis.agent.handle_message(a)
        for response in responses:
            jarvis.logger.info('MODO DEBUG')
            jarvis.logger.info(response)
            jarvis.logger.info(response["text"])
