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
    @IBOutlet weak var vistaLibros: UIView!
    
    @IBOutlet weak var bottomMes: NSLayoutConstraint!
    
    @IBOutlet weak var coverart: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var library: UILabel!
    
    private var altoContraste: Bool! = false
    
    internal func setDatos(info: Globos) {
        
        if (info.getEmisor() == .User) {
            self.message.text = "Tu: " + info.getRespuesta();
            self.message.textAlignment = .right;
            self.message.transform = CGAffineTransform(scaleX: -1,y: 1)
            self.message.sizeToFit()
            coverart.image = nil
            bottomMes.priority = UILayoutPriority(rawValue: 999)
            bottomMes.isActive = true
            self.cambiarBurbuja(info: .User)
        }
        else {
            self.message.text = "Janet: " + info.getRespuesta()
            self.message.textAlignment = .left
            self.message.sizeToFit()
            self.message.transform = CGAffineTransform.identity
            if (info.getTipo() == Globos.TiposMensaje.singlebook) {
                bottomMes.priority = UILayoutPriority(rawValue: 499)
                self.generarInterfaz(datos: info)
            } else {
                coverart.image = nil
                bottomMes.priority = UILayoutPriority(rawValue: 999)
                bottomMes.isActive = true
                self.cambiarBurbuja(info: .Bot)
            }
        }
    }
    
    internal func getText() -> String{
        return self.message.text!
    }
    
    internal func getAltura() -> CGFloat {
        if (self.vistaLibros.isHidden) {
            return self.message.frame.size.height + 15
        }
        
        return self.message.frame.size.height + self.vistaLibros.frame.size.height
    }
    
    func setAltoContraste(contraste: Bool) {
        self.altoContraste = contraste
    }
    
    internal func updateAltura(ancho: CGFloat) {
        self.message.bounds.size.width = ancho
    }
    
    internal func vistaLibrosHidden() -> Bool{
        print (self.message.text!)
        return self.vistaLibros.isHidden
    }
    
    private func generarInterfaz(datos: Globos) {
        
        var image: UIImage?
        
        let url = NSURL(string: datos.getImagen())! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            image = UIImage(data: imageData as Data)
        }
        
        coverart.image = image
        title.text = datos.getTitle(); title.font = UIFont.boldSystemFont(ofSize: 17.0); title.textColor = UIColor.white
        author.text = datos.getAuthor(); author.textColor = UIColor.white
        available.text = "Disponible: " + String(datos.getAvailable()); available.textColor = UIColor.white
        library.text = "Biblioteca: " + datos.getLibrarys(); library.textColor = UIColor.white
        library.adjustsFontSizeToFitWidth = true
        vistaLibros.isHidden = false
    }
    
    private func cambiarBurbuja(info: Globos.TiposEmisor) {
        
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
