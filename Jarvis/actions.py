# -*- coding: utf-8 -*-
"""
Módulo PLN Codename Jarvis - Proyecto Janet
Versión 0.5.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""

from rasa_core_sdk import Action
from rasa_nlu.model import Trainer, Interpreter
from rasa_core_sdk.events import SlotSet

class ActionBuscaLibros(Action):
    def name(self):
        return 'action_busca_libros'

    def run(self, dispatcher, tracker, domain):
        libros = tracker.get_slot('libros')
        if libros is not None:
            dispatcher.utter_message("Aquí tienes el libro que me pediste")
            return [libros]

        else:
            dispatcher.utter_message("Tienes que indicarme un libro.")
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
            dispatcher.utter_template("utter_muestra_mas")
            return [libros]
        elif articulos is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [articulos]
        elif autores is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [autores]
        elif juego is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [juego]
        elif musica is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [musica]
        elif pelicula is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [pelicula]
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
            dispatcher.utter_template("utter_muestra_mas")
            return [libros]
        elif articulos is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [articulos]
        elif autores is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [autores]
        elif juego is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [juego]
        elif musica is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [musica]
        elif pelicula is not None:
            dispatcher.utter_template("utter_muestra_mas")
            return [pelicula]
        else:
            dispatcher.utter_message("Antes tienes que indicarme algo.")
            return []