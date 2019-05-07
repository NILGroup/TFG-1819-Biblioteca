//
//  TableViewExtension.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 11/11/18.
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

//Clase padre que controla la tabla en la que se depositan los globos de mensajes.
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Indica el número de secciones de la tabla (por defecto 1).
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Devuelve el número de filas rellenas en la tabla.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mensajes.count;
    }
    
    //Inserta un nuevo globo en la tabla.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Inserta un globo de solo texto en la tabla.
         if (mensajes[indexPath.row].getTipo() == .text) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageViewCell
            cell.setDatos(info: mensajes[indexPath.row])
            
            //Si el mensaje lo envía el usuario, alinea el globo a la derecha de la pantalla.
            if (mensajes[indexPath.item].getEmisor() == .User) {
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1)
            } else {
                cell.contentView.transform = CGAffineTransform.identity
            }
            
            if (self.getAltoContrasteActivo()) {
                cell.setAltoContraste(contraste: true)
            }
            
            return cell
            
        }
            
        //Inserta un globo de un libro en la tabla.
        else if (mensajes[indexPath.row].getTipo() == .singlebook){
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "singleBookViewCell", for: indexPath) as! SingleBookViewCell
            cell.setDatos(info: mensajes[indexPath.row])
            
            //Si el mensaje lo envía el usuario, alinea el globo a la derecha de la pantalla.
            if (mensajes[indexPath.item].getEmisor() == .User) {
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1)
            } else {
                cell.contentView.transform = CGAffineTransform.identity
            }
            
            if (self.getAltoContrasteActivo()) {
                cell.setAltoContraste(contraste: true)
            }
            
            return cell
        
        }
            
        //Inserta un globo de localización en la tabla.
        else if (mensajes[indexPath.row].getTipo() == .location){
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "mapViewCell", for: indexPath) as! MapViewCell
            cell.setDatos(info: mensajes[indexPath.row])
            
            //Si el mensaje lo envía el usuario, alinea el globo a la derecha de la pantalla.
            if (mensajes[indexPath.item].getEmisor() == .User) {
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1)
            } else {
                cell.contentView.transform = CGAffineTransform.identity
            }
            
            if (self.getAltoContrasteActivo()) {
                cell.setAltoContraste(contraste: true)
            }
            
            return cell
            
         }
            
         //Inserta un globo de teléfono en la tabla.
         else if (mensajes[indexPath.row].getTipo() == .phone){
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "phoneViewCell", for: indexPath) as! PhoneViewCell
            cell.setDatos(info: mensajes[indexPath.row])
            
            if (mensajes[indexPath.item].getEmisor() == .User) {
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1)
            } else {
                cell.contentView.transform = CGAffineTransform.identity
            }
            
            if (self.getAltoContrasteActivo()) {
                cell.setAltoContraste(contraste: true)
            }
            
            return cell
            
         }
            
         //Inserta un globo de varios libros en la tabla.
         else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "listBooksViewCell", for: indexPath) as! ListBooksViewCell
            cell.setDatos(info: mensajes[indexPath.row])
            
            if (mensajes[indexPath.item].getEmisor() == .User) {
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1)
            } else {
                cell.contentView.transform = CGAffineTransform.identity
            }
            
            if (self.getAltoContrasteActivo()) {
                cell.setAltoContraste(contraste: true)
            }
            
            return cell
        }
    
    }
}
