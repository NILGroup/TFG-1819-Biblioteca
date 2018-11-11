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
    @IBOutlet weak var burbuja: UIImageView!
    
    @IBOutlet weak var alturaBurbuja: NSLayoutConstraint!
    @IBOutlet weak var anchuraBurbuja: NSLayoutConstraint!
    
    //private var labelOriginal: UILabel? = nil
    
    internal func setMessage(info: Globos) {
        /*if (labelOriginal == nil) {
            labelOriginal = text.crearCopia()
        }*/
        
        if (info.getEmisor() == .User) {
            
            //self.text.sizeToFit()
            //self.text.numberOfLines = 0
            //self.text.lineBreakMode = .byWordWrapping
            //self.text.numberOfLines = 0
            //self.text = labelOriginal!.crearCopia()
            self.text.text = "Tu: " + info.getRespuesta();
            self.text.textAlignment = .right;
            self.text.sizeToFit()
            self.text.transform = CGAffineTransform(scaleX: -1,y: 1)
            //self.text.text = "Tu: " + info.getRespuesta();
            //self.text.sizeToFit()
            //self.text.textAlignment = .right;
            //self.text.sizeToFit()
            self.cambiarBurbuja(info: .User);
        }
        else {
            
            //self.text.sizeToFit()
            //self.text.numberOfLines = 0
            //self.text.lineBreakMode = .byWordWrapping
            //self.text = labelOriginal!.crearCopia()
            self.text.text = "Janet: " + info.getRespuesta();
            self.text.textAlignment = .left;
            self.text.sizeToFit()
            self.text.transform = CGAffineTransform.identity;
            self.cambiarBurbuja(info: .Bot);
        }
    }
    
    internal func getText() -> String{
        return self.text.text!
    }
    
    internal func getAltura() -> CGFloat {
        return self.text.bounds.size.height
    }
    
    internal func updateAltura(ancho: CGFloat) {
        //self.text.numberOfLines = 0
        //self.text.lineBreakMode = .byWordWrapping
        self.text.bounds.size.width = ancho
        //self.text.sizeToFit()
    }
    
    private func cambiarBurbuja(info: Globos.TiposEmisor) {
        
        guard let imagen = UIImage(named: "Bubble") else { return }
        
        burbuja.image = imagen
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                            resizingMode: .stretch)
            .withRenderingMode(.alwaysTemplate)
        
        if (info == .User) {
            //guard let imagen = UIImage(named: "Bubble_User")?.imageFlippedForRightToLeftLayoutDirection() else { return }
            /*guard let imagen = UIImage(named: "Bubble_Janet") else { return }
            
            burbuja.image = imagen
                .resizableImage(withCapInsets:
                    UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                                resizingMode: .stretch)
                .withRenderingMode(.alwaysTemplate)*/
            
            self.alturaBurbuja.constant = self.text.bounds.size.height + 15//+ 15
            self.anchuraBurbuja.constant = self.text.bounds.size.width + 30
            
        } else {
            /*guard let imagen = UIImage(named: "Bubble_Janet") else { return }
            
            burbuja.image = imagen
                .resizableImage(withCapInsets:
                    UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                                resizingMode: .stretch)
                .withRenderingMode(.alwaysTemplate)*/
            
            self.alturaBurbuja.constant = self.text.bounds.size.height + 15
            self.anchuraBurbuja.constant = self.text.bounds.size.width + 30
        }
        burbuja.tintColor = UIColor.black
        burbuja.alpha = 0.6
    }
    
}

private extension UILabel {
    func crearCopia() -> UILabel {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as! UILabel
    }
}
