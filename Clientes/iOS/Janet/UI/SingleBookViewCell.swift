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
    
    let imageCache = NSCache<NSString, UIImage>()

    @IBOutlet weak var View: UIView!
    @IBOutlet weak var coverart: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    private var urlString : String? = nil
    private var isbn: String? = nil

    override func setDatos(info: Globos) {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        View.addGestureRecognizer(tap)
        
        self.message.text = "Janet: " + info.getRespuesta()
        self.message.textAlignment = .left
        self.message.sizeToFit()
        self.cambiarBurbuja(info: .Bot)

        imageFromServerURL(info.getISBN())

        /*var image: UIImage?
        
        if (coverart.image == nil) {
            let url = NSURL(string: info.getImagen())! as URL
            if let imageData: NSData = NSData(contentsOf: url) {
                image = UIImage(data: imageData as Data)
                if (image?.size.width == 1) {
                    image = UIImage(named: "Empty_Book")
                }
            }
            coverart.image = image
        }*/
        
        titleLabel.text = info.getTitle()
        authorLabel.text = info.getAuthor()
        if (info.getAvailable()) {
            availableLabel.text = "Disponible: Si"
        } else {
            availableLabel.text = "Disponible: No"
        }
        var biblios = ""
        for item in info.getLibraryAvailable() {
            biblios += item.key + "\t" + String(item.value) + "\n"
        }
        locationLabel.text = biblios
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
    
    func imageFromServerURL(_ isbn: [String]) {
        
        var existe = false
        var i = 0
        
        if isbn.isEmpty {
            DispatchQueue.main.async {
                self.coverart.image = UIImage(named: "Empty_Book")
            }
            return
        }
        
        while (i < isbn.count && !existe) {
            let enlace = "https://covers.openlibrary.org/b/isbn/"+isbn[i]+"-M.jpg"
            
            if let cachedImage = imageCache.object(forKey: NSString(string: enlace)) {
                coverart.image = cachedImage
                return
            }
            
            if let url = URL(string: enlace) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    
                    //print("RESPONSE FROM API: \(response)")
                    if error != nil {
                        //print("ERROR LOADING IMAGES FROM URL: \(error)")
                        DispatchQueue.main.async {
                            self.coverart.image = UIImage(named: "Empty_Book")
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data {
                            if let downloadedImage = UIImage(data: data) {
                                if (downloadedImage.size.width == 1) {
                                    self.coverart.image = UIImage(named: "Empty_Book")
                                } else {
                                    existe = true
                                    self.imageCache.setObject(downloadedImage, forKey: NSString(string: enlace))
                                    self.coverart.image = downloadedImage
                                    
                                }
                            }
                        }
                    }
                }).resume()
            }
            i += 1
        }
    }
}
