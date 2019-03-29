# -*- coding: utf-8 -*-
"""
Módulo PLN Codename Jarvis - Proyecto Janet
Versión 0.5.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""
from typing import Dict, Text, Any, List, Union

from rasa_core_sdk import Action
from rasa_core_sdk import ActionExecutionRejection
from rasa_core_sdk import Tracker
from rasa_core_sdk.events import SlotSet
from rasa_core_sdk.executor import CollectingDispatcher
from rasa_core_sdk.forms import FormAction, REQUESTED_SLOT


class ActionSaludos(Action):
    def name(self):
        return 'action_saludos'

    def run(self, dispatcher, tracker, domain):
        persona = tracker.get_slot('persona')
        if persona is not None:
            dispatcher.utter_template("utter_saludo_nombre", tracker, **tracker.slots)
            return []
        else:
            dispatcher.utter_template("utter_saludo", tracker)
            return []

class SaludosForm(FormAction):
    def name(self):
        return "form_saludos"

    @staticmethod
    def required_slots(tracker: Tracker) -> List[Text]:
        return ["persona"]

    def slot_mappings(self):
        return {"persona": [self.from_entity(entity="PER", intent="me_llamo"),
                            self.from_entity(entity="persona", intent="me_llamo")]}

    def validate(self,
                 dispatcher: CollectingDispatcher,
                 tracker: Tracker,
                 domain: Dict[Text, Any]) -> List[Dict]:

        slot_values = self.extract_other_slots(dispatcher, tracker, domain)
        slot_to_fill = tracker.get_slot(REQUESTED_SLOT)

        if slot_to_fill:
            slot_values.update(self.extract_requested_slot(dispatcher, tracker, domain))

        else:
            temp = tracker.get_latest_entity_values('PER')
            aux = None
            for i in temp:
                if i is not "Hola":
                    aux = i
            aux2 = next(tracker.get_latest_entity_values('persona'), None).capitalize()
            if aux is None and aux2 is not None:
                return [SlotSet('persona', aux2)]
            elif aux is not None and aux is not "Hola":
                return [SlotSet('persona', aux)]
            else:
                dispatcher.utter_message("Dime cómo te llamas")

        return [SlotSet(slot, value) for slot, value in slot_values.items()]

    def submit(self,
               dispatcher: CollectingDispatcher,
               tracker: Tracker,
               domain: Dict[Text, Any]) -> List[Dict]:
        persona = tracker.get_slot('persona')
        if persona is not None:
            dispatcher.utter_template("utter_saludo_nombre", tracker, **tracker.slots)
            return [SlotSet('persona', persona)]
        else:
            dispatcher.utter_template("utter_saludo", tracker)
            return []

class BuscarLibroForm(FormAction):
    def name(self):
        return "form_libros"

    @staticmethod
    def required_slots(tracker: Tracker) -> List[Text]:
        return []

    def slot_mapping(self):
        return {"libro": [self.from_entity(entity="libro"),
                          self.from_entity(entity="MISC")],
                "autores":  [self.from_entity(entity="PER"),
                          self.from_entity(entity="autores")]
                }

    def validate(self,
                 dispatcher: CollectingDispatcher,
                 tracker: Tracker,
                 domain: Dict[Text, Any]) -> List[Dict]:
        temp = {}
        libro = next(tracker.get_latest_entity_values('libro'), None).capitalize()
        autor1 = next(tracker.get_latest_entity_values('autores'), None).capitalize()
        autorPer = next(tracker.get_latest_entity_values('PER'), None)
        temp['libro'] = None
        temp['autores'] = None
        if libro is None:
            temp['libro'] = next(tracker.get_latest_entity_values('MISC'),None)
        else:
            temp['libro'] = libro

        if autor1 is None and autorPer is not None:
            temp['autores'] = autorPer
        elif autor1 is not None:
            temp['autores'] = autor1

        return [SlotSet('libro', temp['libro']), SlotSet('autores', temp['autores'])]


    def submit(self,
               dispatcher: CollectingDispatcher,
               tracker: Tracker,
               domain: Dict[Text, Any]) -> List[Dict]:
        libro = tracker.get_slot('libro')
        autores = tracker.get_slot('autores')
        intent = tracker.latest_message['intent'].get('name')

        if intent == "consulta_libros_kw":
            if libro is not None:
                dispatcher.utter_template("utter_libros_kw", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libros_autor":
            if autores is not None:
                dispatcher.utter_template("utter_libros_autor", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libro_titulo_autor":
            if libro is not None and autores is not None:
                dispatcher.utter_template("utter_libro_titulo_autor", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libro_kw":
            if libro is not None:
                dispatcher.utter_template("utter_libro_kw", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libros_titulo":
            if libro is not None:
                dispatcher.utter_template("utter_libros_titulo", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libro_titulo":
            if libro is not None:
                dispatcher.utter_template("utter_libro_titulo", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libro_autor":
            if autores is not None:
                dispatcher.utter_template("utter_libro_autor", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libros_titulo_autor":
            if libro is not None and autores is not None:
                dispatcher.utter_template("utter_libros_titulo_autor", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libros_kw_autor":
            if libro is not None and autores is not None:
                dispatcher.utter_template("utter_libros_kw_autor", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_libro_kw_autor":
            if libro is not None and autores is not None:
                dispatcher.utter_template("utter_libro_kw_autor", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        return []

class BuscarArticuloForm(FormAction):
    def name(self):
        return "form_articulos"

    @staticmethod
    def required_slots(tracker: Tracker) -> List[Text]:
        return []

    def slot_mapping(self):
        return {"articulos": [self.from_entity(entity="articulos"),
                          self.from_entity(entity="MISC")]
                }

    def validate(self,
                 dispatcher: CollectingDispatcher,
                 tracker: Tracker,
                 domain: Dict[Text, Any]) -> List[Dict]:
        articulos = next(tracker.get_latest_entity_values('articulos'), None)
        if articulos is None:
            return [SlotSet('articulos',articulos)]
        else:
            return [SlotSet('articulos',next(tracker.get_latest_entity_values('MISC'), None))]

    def submit(self,
               dispatcher: CollectingDispatcher,
               tracker: Tracker,
               domain: Dict[Text, Any]) -> List[Dict]:
        articulos = tracker.get_slot('articulos')
        intent = tracker.latest_message['intent'].get('name')

        if intent == "consulta_articulos_kw":
            if articulos is not None:
                dispatcher.utter_template("utter_articulos_kw", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        elif intent == "consulta_articulo_kw":
            if articulos is not None:
                dispatcher.utter_template("utter_articulo_kw", tracker, **tracker.slots)
            else:
                dispatcher.utter_message("Antes tienes que indicarme algo.")
        return []

class ActionBuscaMas(Action):
    def name(self):
        return 'action_busca_mas'

    def run(self, dispatcher, tracker, domain):
        libros = tracker.get_slot('libro')
        articulos = tracker.get_slot('articulos')
        autores = tracker.get_slot('autores')
        juego = tracker.get_slot('juego')
        musica = tracker.get_slot('musica')
        pelicula = tracker.get_slot('pelicula')
        if libros is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
        elif articulos is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
        elif autores is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
        elif juego is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
        elif musica is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
        elif pelicula is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
        else:
            dispatcher.utter_message("Antes tienes que indicarme algo.")
        return []

class ActionMuestraPrimero(Action):
    def name(self):
        return 'action_muestra_primero'

    def run(self, dispatcher, tracker, domain):
        libros = tracker.get_slot('libro')
        articulos = tracker.get_slot('articulos')
        autores = tracker.get_slot('autores')
        juego = tracker.get_slot('juego')
        musica = tracker.get_slot('musica')
        pelicula = tracker.get_slot('pelicula')
        if libros is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
        elif articulos is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
        elif autores is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
        elif juego is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
        elif musica is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
        elif pelicula is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
        else:
            dispatcher.utter_message("Antes tienes que indicarme algo.")
        return []

class ActionMuestraSegundo(Action):
    def name(self):
        return 'action_muestra_segundo'

    def run(self, dispatcher, tracker, domain):
        libros = tracker.get_slot('libro')
        articulos = tracker.get_slot('articulos')
        autores = tracker.get_slot('autores')
        juego = tracker.get_slot('juego')
        musica = tracker.get_slot('musica')
        pelicula = tracker.get_slot('pelicula')
        if libros is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
        elif articulos is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
        elif autores is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
        elif juego is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
        elif musica is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
        elif pelicula is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
        else:
            dispatcher.utter_message("Antes tienes que indicarme algo.")
        return []

class ActionMuestraTercero(Action):
    def name(self):
        return 'action_muestra_tercero'

    def run(self, dispatcher, tracker, domain):
        libros = tracker.get_slot('libro')
        articulos = tracker.get_slot('articulos')
        autores = tracker.get_slot('autores')
        juego = tracker.get_slot('juego')
        musica = tracker.get_slot('musica')
        pelicula = tracker.get_slot('pelicula')
        if libros is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
        elif articulos is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
        elif autores is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
        elif juego is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
        elif musica is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
        elif pelicula is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
        else:
            dispatcher.utter_message("Antes tienes que indicarme algo.")
        return []

class ActionHayLocalizacion(Action):
    def name(self):
        return 'action_localizacion_sin_entidad'

    def run(self, dispatcher, tracker, domain):
        localizacion = tracker.get_slot('localizacion')
        intent = tracker.latest_message['intent'].get('name')
        if localizacion is not None:
            if intent == 'consulta_localizacion':
                dispatcher.utter_template("utter_consulta_localizacion", tracker, **tracker.slots)
            elif intent == 'consulta_telefono':
                dispatcher.utter_template("utter_consulta_telefono", tracker, **tracker.slots)
        else:
            dispatcher.utter_message("Primero tienes que indicarme una biblioteca.")
        return []
