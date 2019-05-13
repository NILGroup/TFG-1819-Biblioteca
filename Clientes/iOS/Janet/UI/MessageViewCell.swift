//
//  MessageViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 11/12/2018.
//  MIT License
//
//  Copyright (c) 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

//Clase para un globo de conversación con un único mensaje.
class MessageViewCell: TableViewCell {

    //Inicializa los atributos de la clase con los datos obtenidos del usuario y/o servidor.
    override func setDatos(info: Globos) {
        if (info.getEmisor() == .User) {
            self.message.text = "Tú: " + info.getRespuesta();
            self.message.textAlignment = .right;
            self.message.transform = CGAffineTransform(scaleX: -1,y: 1)
            self.message.sizeToFit()
            self.cambiarBurbuja(info: .User)
        }
        else {
            self.message.text = "Janet: " + info.getRespuesta()
            self.message.textAlignment = .left
            self.message.sizeToFit()
            self.message.transform = CGAffineTransform.identity
            self.cambiarBurbuja(info: .Bot)
        }
    }
}
