//
//  TableViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 02/10/2018.
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

//Clase padre que gestiona el contenido de las filas de la tabla de mensajes.
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var burbuja: UIImageView!
    
    private var altoContraste: Bool! = false
    
    internal func setDatos(info: Globos) {
        //Función abstracta no implementada.
    }
    
    //Obtiene el texto del label de mensaje.
    internal func getText() -> String{
        return self.message.text!
    }
    
    //Indica al sistema que el modo de alto constraste está activado
    func setAltoContraste(contraste: Bool) {
        self.altoContraste = contraste
    }
    
    //Adapta el formato de la burbuja
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
            //Adapta el tamaño y color de la burbuja
            burbuja.layer.borderWidth = 2
            burbuja.layer.borderColor = UIColor.white.cgColor
            burbuja.tintColor = UIColor.black
            burbuja.alpha = 1.0
        }
    }
    
}
