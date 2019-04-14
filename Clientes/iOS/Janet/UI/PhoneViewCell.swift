//
//  PhoneViewCell.swift
//  Janet
//
//  Created by Mauri on 12/04/2019.
//  Copyright © 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit

class PhoneViewCell: TableViewCell {
    
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var Library: UILabel!
    
    
    override func setDatos(info: Globos) {
        
        self.message.text = "Janet: " + info.getRespuesta()
        self.message.textAlignment = .left
        self.message.sizeToFit()
        self.cambiarBurbuja(info: .Bot)
        
        View.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewPhoneTapped))
        View.addGestureRecognizer(tap)
        
        Phone.text = String(info.getPhone())
        Library.text = info.getLibrary()
    }
    
    @objc private func viewPhoneTapped(sender: UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + Phone.text!) else { return }
        UIApplication.shared.open(number)
    }
    
}
