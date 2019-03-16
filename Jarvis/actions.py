# -*- coding: utf-8 -*-
"""
Módulo PLN Codename Jarvis - Proyecto Janet
Versión 0.5.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from rasa_core_sdk import Action
from rasa_core_sdk.events import SlotSet

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
            print('He entrado aquí')
            dispatcher.utter_template("utter_saludo_nombre", tracker)
            return []
        elif next(tracker.get_latest_entity_values('PER'), None) is not None and \
                tracker.latest_message['intent'].get('name') != 'saludos':
            tracker.slots['persona'] = next(tracker.get_latest_entity_values('PER'), None)
            dispatcher.utter_template("utter_saludo_nombre", tracker)
            return [SlotSet("persona", next(tracker.get_latest_entity_values('PER'), None))]
        else:
            dispatcher.utter_template("utter_saludo", tracker)
            return []

class ActionBuscaMas(Action):
    def name(self):
        return 'action_busca_mas'

    def run(self, dispatcher, tracker, domain):
        libros = tracker.get_slot('libros')
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
            tracker.slots['libros'] = next(tracker.get_latest_entity_values('MISC'), None)
            dispatcher.utter_template("utter_muestra_mas", tracker)
            return [SlotSet("libros", next(tracker.get_latest_entity_values('MISC'), None))]
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
