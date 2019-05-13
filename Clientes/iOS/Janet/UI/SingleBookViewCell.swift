//
//  SingleBookViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 11/12/2018.//  MIT License
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

//Clase para un globo de conversación con 1 libro.
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

    //Inicializa los atributos de la clase.
    override func setDatos(info: Globos) {
        
        //Establece un enlace en la vista para abrir el navegador del sistema y abrir la web del ejemplar.
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        View.addGestureRecognizer(tap)
        
        self.message.text = "Janet: " + info.getRespuesta()
        self.message.textAlignment = .left
        self.message.sizeToFit()
        self.cambiarBurbuja(info: .Bot)

        imageFromServerURL(info.getISBN())
        
        titleLabel.text = info.getTitle()
        authorLabel.text = info.getAuthor()
        if (info.getAvailable()) {
            availableLabel.text = "Disponible: Si"
        } else {
            availableLabel.text = "Disponible: No"
        }
        var biblios = ""
        for item in info.getLibraryAvailable() {
            biblios += item.key + "\t:\t" + String(item.value) + "\n"
        }
        locationLabel.text = biblios
        locationLabel.sizeToFit()
        self.urlString = info.getURL().replacingOccurrences(of: "http://www.worldcat.org/wcpa/", with: "https://ucm.on.worldcat.org/", options: .literal, range: nil)
        
        if let aux = self.urlString!.range(of: "?") {
            self.urlString!.removeSubrange(aux.lowerBound..<self.urlString!.endIndex)
        }
    }
    
    //Establece un enlace via notificación con el ViewController para abrir el navegador del sistema y abrir la web del ejemplar.
    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        let temp = self.urlString!
        guard let url = URL(string: temp) else { return }
        
        UIApplication.shared.open(url)
    }
    
    //Carga la portada del libro de forma asíncrona.
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
                existe = true
                return
            }
            
            if let url = URL(string: enlace) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        DispatchQueue.main.async {
                            self.coverart.image = UIImage(named: "Empty_Book")
                        }
                        return
                    }
                    if (!existe) {
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
                    }
                }).resume()
            }
            i += 1
        }
    }
}
