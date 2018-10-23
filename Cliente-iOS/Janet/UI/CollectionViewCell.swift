//
//  CollectionViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 02/10/2018.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var text: UILabel!
    
    func setText(texto: String) {
        self.text.text = texto;
    }
    
    func getText() -> String{
        return self.text.text!;
    }
    
}
