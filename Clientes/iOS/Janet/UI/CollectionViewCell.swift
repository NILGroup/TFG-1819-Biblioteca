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
    
    private var altoContraste: Bool! = false
    
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
    
    func setAltoContraste(contraste: Bool) {
        self.altoContraste = contraste
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
        
        
            
        self.alturaBurbuja.constant = self.text.bounds.size.height + 15
        self.anchuraBurbuja.constant = self.text.bounds.size.width + 30
        if (!altoContraste) {
            burbuja.tintColor = UIColor.black
            burbuja.alpha = 0.6
        } else {
            //burbuja.image = imagen.imageWithBorder(width: 2, color: UIColor.white)
            burbuja.layer.borderWidth = 2
            burbuja.layer.borderColor = UIColor.white.cgColor
            burbuja.tintColor = UIColor.black
            burbuja.alpha = 1.0
        }
    }
    
}

private extension UIImage {
    func imageWithBorder(width: CGFloat, color: UIColor) -> UIImage? {
        let square = CGSize(width: min(size.width, size.height) + width * 2, height: min(size.width, size.height) + width * 2)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .center
        imageView.image = self
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
