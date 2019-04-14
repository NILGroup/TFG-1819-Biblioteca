//
//  TableViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 02/10/2018.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var burbuja: UIImageView!
    
    private var altoContraste: Bool! = false
    
    internal func setDatos(info: Globos) {
        
    }
    
    internal func getText() -> String{
        return self.message.text!
    }
    
    func setAltoContraste(contraste: Bool) {
        self.altoContraste = contraste
    }
    
    internal func cambiarBurbuja(info: Globos.TiposEmisor) {
        
        guard let imagen = UIImage(named: "Bubble") else { return }
        
        burbuja.image = imagen
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                            resizingMode: .stretch)
            .withRenderingMode(.alwaysTemplate)
        
        if (!altoContraste) {
            burbuja.tintColor = UIColor.black
            burbuja.alpha = 0.6
        } else {
            burbuja.layer.borderWidth = 2
            burbuja.layer.borderColor = UIColor.white.cgColor
            burbuja.tintColor = UIColor.black
            burbuja.alpha = 1.0
        }
    }
    
}
