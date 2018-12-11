//
//  SingleBookViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 11/12/2018.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit
//import SafariServices

class SingleBookViewCell: TableViewCell {
    
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var coverart: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    private var urlString : String? = nil

    override func setDatos(info: Globos) {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        View.addGestureRecognizer(tap)
        
        self.message.text = "Janet: " + info.getRespuesta()
        self.message.textAlignment = .left
        self.message.sizeToFit()
        self.cambiarBurbuja(info: .Bot)

        var image: UIImage?
        
        if (coverart.image == nil) {
            let url = NSURL(string: info.getImagen())! as URL
            if let imageData: NSData = NSData(contentsOf: url) {
                image = UIImage(data: imageData as Data)
                if (image?.size.width == 1) {
                    image = nil
                }
            }
            coverart.image = image
        }
        
        titleLabel.text = info.getTitle()
        authorLabel.text = info.getAuthor()
        if (info.getAvailable()) {
            availableLabel.text = "Disponible: Si"
        } else {
            availableLabel.text = "Disponible: No"
        }
        locationLabel.text = "Biblioteca: " + info.getLibrarys()
        locationLabel.sizeToFit()
        self.urlString = info.getURL().replacingOccurrences(of: "http://www.worldcat.org/wcpa/", with: "https://ucm.on.worldcat.org/", options: .literal, range: nil)
        
        if let aux = self.urlString!.range(of: "?") {
            self.urlString!.removeSubrange(aux.lowerBound..<self.urlString!.endIndex)
        }
        //library.adjustsFontSizeToFitWidth = true
    }
    
    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        let temp = self.urlString!
        guard let url = URL(string: temp) else { return }
        //let svc = SFSafariViewController(url: url as URL)
        //present(svc, animated: true, completion: nil)
        UIApplication.shared.open(url)
    }
}
