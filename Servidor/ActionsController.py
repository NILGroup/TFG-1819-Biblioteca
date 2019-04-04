# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.9.0

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018-2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""


class Action(object):

    def __init__(self, m, w):
        self.mongo = m
        self.wms = w

    def accion(self, intent, entities, response, uid):
        raise NotImplementedError("Interfaz, hereda de una clase.")
