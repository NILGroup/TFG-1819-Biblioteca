//
//  MessageViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 11/12/2018.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit

class MessageViewCell: TableViewCell {

    override func setDatos(info: Globos) {
        
        if (info.getEmisor() == .User) {
            self.message.text = "Tu: " + info.getRespuesta();
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
