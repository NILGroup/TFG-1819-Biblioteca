# -*- coding: utf-8 -*-
"""
Servidor de TFG - Proyecto Janet
Versión 0.3.0 - Supplemental Update

Módulo de inicialización del sistema.

@author: Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
© 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
"""
import sys
sys.path.insert(0, '/home/tfg-biblio/janet')

import bottle
import JanetServMain

application = bottle.default_app()
