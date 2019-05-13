//
//  ListBooksViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 11/12/2018.
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

//Clase para un globo de conversación con 3 libros.
class ListBooksViewCell: TableViewCell {
    
    let imageCache1 = NSCache<NSString, UIImage>()
    let imageCache2 = NSCache<NSString, UIImage>()
    let imageCache3 = NSCache<NSString, UIImage>()

    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var coverart1: UIImageView!
    @IBOutlet weak var authorLabel1: UILabel!
    
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var coverart2: UIImageView!
    @IBOutlet weak var authorLabel2: UILabel!
    
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var titleLabel3: UILabel!
    @IBOutlet weak var coverart3: UIImageView!
    @IBOutlet weak var authorLabel3: UILabel!
    
    var list: [Globos]? = nil
    
    //Inicializa los atributos de la clase.
    override func setDatos(info: Globos) {
        
        self.list = info.getlist()
        
        //Establece un enlace en la vista para llamar al servidor y cargar información sobre el primer libro.
        View1.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(view1Tapped))
        View1.addGestureRecognizer(tap1)
        
        //Establece un enlace en la vista para llamar al servidor y cargar información sobre el segundo libro.
        if (self.list!.count > 1) {
            View2.isUserInteractionEnabled = true
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(view2Tapped))
            View2.addGestureRecognizer(tap2)
        } else {
            View2.isHidden = true
        }
        
        //Establece un enlace en la vista para llamar al servidor y cargar información sobre el tercer libro.
        if (self.list!.count > 2) {
            View3.isUserInteractionEnabled = true
            let tap3 = UITapGestureRecognizer(target: self, action: #selector(view3Tapped))
            View3.addGestureRecognizer(tap3)
        } else {
            View3.isHidden = true
        }
        
        self.message.text = "Janet: " + info.getRespuesta()
        self.message.textAlignment = .left
        self.message.sizeToFit()
        self.cambiarBurbuja(info: .Bot)
        
        let list = info.getlist()
        
        for i in 0..<self.list!.count {
            if (i == 0) {
                titleLabel1.text = list[i].getTitle()
                authorLabel1.text = list[i].getAuthor()
                authorLabel1.minimumScaleFactor = 0.2
                authorLabel1.adjustsFontSizeToFitWidth = true
            } else if (i == 1) {
                titleLabel2.text = list[i].getTitle()
                authorLabel2.text = list[i].getAuthor()
                authorLabel2.minimumScaleFactor = 0.2
                authorLabel2.adjustsFontSizeToFitWidth = true
            } else {
                titleLabel3.text = list[i].getTitle()
                authorLabel3.text = list[i].getAuthor()
                authorLabel3.minimumScaleFactor = 0.2
                authorLabel3.adjustsFontSizeToFitWidth = true
            }
            
            imageFromServerURL(list[i].getISBN(), num: i)
        }
        
        
    }
    
    //Establece un enlace via notificación con el ViewController para llamar al servidor y cargar información sobre el primer libro.
    @objc private func view1Tapped(sender: UITapGestureRecognizer) {
        print("bigButton1Tapped")
        let dict = ["tipo": "oclc", "peticion": self.list![0].getCodOCLC()] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "view1Tapped"), object: nil, userInfo: dict)
    }
    
    //Establece un enlace via notificación con el ViewController para llamar al servidor y cargar información sobre el segundo libro.
    @objc private func view2Tapped(sender: UITapGestureRecognizer) {
        print("bigButton2Tapped")
        let dict = ["tipo": "oclc", "peticion": self.list![1].getCodOCLC()] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "view1Tapped"), object: nil, userInfo: dict)
    }
    
    //Establece un enlace via notificación con el ViewController para llamar al servidor y cargar información sobre el tercer libro.
    @objc private func view3Tapped(sender: UITapGestureRecognizer) {
        print("bigButton3Tapped")
        let dict = ["tipo": "oclc", "peticion": self.list![2].getCodOCLC()] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "view1Tapped"), object: nil, userInfo: dict)
    }
    
    //Carga las portadas de los libros de forma asíncrona.
    func imageFromServerURL(_ isbn: [String], num: Int) {
        
        var existe = false
        var i = 0
        
        if (isbn.isEmpty) {
            DispatchQueue.main.async {
                switch(num) {
                case 0: self.coverart1.image = UIImage(named: "Empty_Book"); break;
                case 1: self.coverart2.image = UIImage(named: "Empty_Book"); break;
                case 2: self.coverart3.image = UIImage(named: "Empty_Book"); break;
                default: break;
                }
            }
            return
        }
        else {
            while (i < isbn.count && !existe) {
                let enlace = "https://covers.openlibrary.org/b/isbn/"+isbn[i]+"-M.jpg"
                switch(num) {
                    case 0:
                        if let cachedImage = imageCache1.object(forKey: NSString(string: enlace)) {
                            coverart1.image = cachedImage
                            existe = true
                            return
                        }
                        break
                    case 1:
                        if let cachedImage = imageCache2.object(forKey: NSString(string: enlace)) {
                            coverart2.image = cachedImage
                            existe = true
                            return
                        }
                        break
                    case 2:
                        if let cachedImage = imageCache3.object(forKey: NSString(string: enlace)) {
                            coverart3.image = cachedImage
                            existe = true
                            return
                        }
                        break
                    default: break
                }
                    if let url = URL(string: enlace) {
                        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                            
                        if error != nil {
                            DispatchQueue.main.async {
                                switch(num) {
                                case 0: self.coverart1.image = UIImage(named: "Empty_Book"); break;
                                case 1: self.coverart2.image = UIImage(named: "Empty_Book"); break;
                                case 2: self.coverart3.image = UIImage(named: "Empty_Book"); break;
                                default: break;
                                }
                            }
                            return
                        }
                        if (!existe) {
                            DispatchQueue.main.async {
                                if let data = data {
                                    if let downloadedImage = UIImage(data: data) {
                                        if (downloadedImage.size.width == 1 && !existe) {
                                            switch(num) {
                                            case 0: self.coverart1.image = UIImage(named: "Empty_Book"); break;
                                            case 1: self.coverart2.image = UIImage(named: "Empty_Book"); break;
                                            case 2: self.coverart3.image = UIImage(named: "Empty_Book"); break;
                                            default: break;
                                            }
                                            existe = false
                                        } else {
                                            switch(num) {
                                            case 0:
                                                existe = true
                                                self.imageCache1.setObject(downloadedImage, forKey: NSString(string: enlace))
                                                self.coverart1.image = downloadedImage
                                                break
                                            case 1:
                                                existe = true
                                                self.imageCache2.setObject(downloadedImage, forKey: NSString(string: enlace))
                                                self.coverart2.image = downloadedImage
                                                break
                                            case 2:
                                                existe = true
                                                self.imageCache3.setObject(downloadedImage, forKey: NSString(string: enlace))
                                                self.coverart3.image = downloadedImage
                                                break
                                            default: break;
                                            }
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
}
