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

class ActionBuscaLibros(Action):
    def name(self):
        return 'action_busca_libros'

    def run(self, dispatcher, tracker, domain):
        libros = tracker.get_slot('libros')
        if libros is not None:
            dispatcher.utter_message("Aquí tienes el libro que me pediste")
            return []

        else:
            dispatcher.utter_message("Tienes que indicarme un libro.")
            return []

class ActionSaludos(Action):
    def name(self):
        return 'action_saludos'

    def run(self, dispatcher, tracker, domain):
        persona = tracker.get_slot('persona')
        if persona is not None:
            dispatcher.utter_template("utter_saludo_nombre", tracker)
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
        print("He entrado")
        return {"persona": [self.from_entity(entity="PER", intent="me_llamo"),
                            self.from_entity(entity="PERSON", intent="me_llamo"),
                            self.from_entity(entity="per", intent="me_llamo"),
                            self.from_entity(entity="person", intent="me_llamo"),
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
            dispatcher.utter_message("Dime cómo te llamas")

        for slot, value in slot_values.items():
            print(slot)
            print(value)

        return [SlotSet(slot, value) for slot, value in slot_values.items()]

    def submit(self,
               dispatcher: CollectingDispatcher,
               tracker: Tracker,
               domain: Dict[Text, Any]) -> List[Dict]:
        persona = tracker.get_slot('persona')
        if persona is not None:
            dispatcher.utter_message("Ok, a partir de ahora te llamaré " + persona)
            return []
        else:
            dispatcher.utter_template("utter_saludo", tracker)
            return []

class BuscarForm(FormAction):
    def name(self):
        return "form_libros"

    @staticmethod
    def required_slots(tracker: Tracker) -> List[Text]:
        return []

    def slot_mapping(self):
        return {"libro": [self.from_entity(entity="libro", intent=["consulta_libros_kw",
                                                                   "consulta_libros_autor",
                                                                   "consulta_libro_titulo_autor",
                                                                   "consulta_libro_kw",
                                                                   "consulta_libros_titulo",
                                                                   "consulta_libro_titulo",
                                                                   "consulta_libro_autor",
                                                                   "consulta_libros_titulo_autor",
                                                                   "consulta_libros_kw_autor",
                                                                   "consulta_libro_kw_autor"]),
                          self.from_entity(entity="MISC", intent=["consulta_libros_kw",
                                                                   "consulta_libros_autor",
                                                                   "consulta_libro_titulo_autor",
                                                                   "consulta_libro_kw",
                                                                   "consulta_libros_titulo",
                                                                   "consulta_libro_titulo",
                                                                   "consulta_libro_autor",
                                                                   "consulta_libros_titulo_autor",
                                                                   "consulta_libros_kw_autor",
                                                                   "consulta_libro_kw_autor"])],
                "autores":  [self.from_entity(entity="PER", intent=["consulta_libros_kw",
                                                                   "consulta_libros_autor",
                                                                   "consulta_libro_titulo_autor",
                                                                   "consulta_libro_kw",
                                                                   "consulta_libros_titulo",
                                                                   "consulta_libro_titulo",
                                                                   "consulta_libro_autor",
                                                                   "consulta_libros_titulo_autor",
                                                                   "consulta_libros_kw_autor",
                                                                   "consulta_libro_kw_autor"]),
                          self.from_entity(entity="autores", intent=["consulta_libros_kw",
                                                                   "consulta_libros_autor",
                                                                   "consulta_libro_titulo_autor",
                                                                   "consulta_libro_kw",
                                                                   "consulta_libros_titulo",
                                                                   "consulta_libro_titulo",
                                                                   "consulta_libro_autor",
                                                                   "consulta_libros_titulo_autor",
                                                                   "consulta_libros_kw_autor",
                                                                   "consulta_libro_kw_autor"])]
                }

    def validate(self,
                 dispatcher: CollectingDispatcher,
                 tracker: Tracker,
                 domain: Dict[Text, Any]) -> List[Dict]:
        slot_values = self.extract_other_slots(dispatcher, tracker, domain)
        slot_to_fill = tracker.get_slot(REQUESTED_SLOT)

        if slot_to_fill:
            slot_values.update(self.extract_requested_slot(dispatcher, tracker, domain))

        else:
            dispatcher.utter_message("Validation failed")

        for slot, value in slot_values.items():
            print(slot)
            print(value)

        return [SlotSet(slot, value) for slot, value in slot_values.items()]

    def submit(self,
               dispatcher: CollectingDispatcher,
               tracker: Tracker,
               domain: Dict[Text, Any]) -> List[Dict]:
        libro = tracker.get_slot('libro')
        if libro is not None:
            dispatcher.utter_template("utter_libros_kw_autor", tracker)
            return []
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
            return []
        elif articulos is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
            return []
        elif autores is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
            return []
        elif juego is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
            return []
        elif musica is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
            return []
        elif pelicula is not None:
            dispatcher.utter_template("utter_muestra_mas", tracker)
            return []
        elif next(tracker.get_latest_entity_values('PER'), None) is not None:
            tracker.slots['autores'] = next(tracker.get_latest_entity_values('PER'), None)
            dispatcher.utter_template("utter_muestra_mas", tracker)
            return [SlotSet("autores", next(tracker.get_latest_entity_values('PER'), None))]
        elif next(tracker.get_latest_entity_values('MISC'), None) is not None:
            tracker.slots['libro'] = next(tracker.get_latest_entity_values('MISC'), None)
            dispatcher.utter_template("utter_muestra_mas", tracker)
            return [SlotSet("libro", next(tracker.get_latest_entity_values('MISC'), None))]
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
            return []
        elif articulos is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
            return []
        elif autores is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
            return []
        elif juego is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
            return []
        elif musica is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
            return []
        elif pelicula is not None:
            dispatcher.utter_template("utter_primero_list", tracker)
            return []
        elif next(tracker.get_latest_entity_values('MISC'), None) is not None:
            tracker.slots['libros'] = next(tracker.get_latest_entity_values('MISC'), None)
            dispatcher.utter_template("utter_primero_list", tracker)
            return [SlotSet("libros", next(tracker.get_latest_entity_values('MISC'), None))]
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
            return []
        elif articulos is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
            return []
        elif autores is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
            return []
        elif juego is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
            return []
        elif musica is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
            return []
        elif pelicula is not None:
            dispatcher.utter_template("utter_segundo_list", tracker)
            return []
        elif next(tracker.get_latest_entity_values('MISC'), None) is not None:
            tracker.slots['libros'] = next(tracker.get_latest_entity_values('MISC'), None)
            dispatcher.utter_template("utter_segundo_list", tracker)
            return [SlotSet("libros", next(tracker.get_latest_entity_values('MISC'), None))]
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
            return []
        elif articulos is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
            return []
        elif autores is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
            return []
        elif juego is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
            return []
        elif musica is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
            return []
        elif pelicula is not None:
            dispatcher.utter_template("utter_tercero_list", tracker)
            return []
        elif next(tracker.get_latest_entity_values('MISC'), None) is not None:
            tracker.slots['libros'] = next(tracker.get_latest_entity_values('MISC'), None)
            dispatcher.utter_template("utter_tercero_list", tracker)
            return [SlotSet("libros", next(tracker.get_latest_entity_values('MISC'), None))]
        else:
            dispatcher.utter_message("Antes tienes que indicarme algo.")
            return []

class ActionHayLocalizacion(Action):
    def name(self):
        return 'action_localizacion_sin_entidad'

    def run(self, dispatcher, tracker, domain):
        localizacion = tracker.get_slot('localizacion')
        if localizacion is not None:
            dispatcher.utter_template("utter_consulta_localizacion", tracker)
            return []

        else:
            dispatcher.utter_message("Primero tienes que indicarme que biblioteca quieres buscar.")
            return []