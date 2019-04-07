//
//  TableViewExtension.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 11/11/18.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mensajes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //self.automaticallyAdjustsScrollViewInsets = false
        
         if (mensajes[indexPath.row].getTipo() == .text) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageViewCell
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
            
        } else if (mensajes[indexPath.row].getTipo() == .singlebook){
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "singleBookViewCell", for: indexPath) as! SingleBookViewCell
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
            
         } else if (mensajes[indexPath.row].getTipo() == .location){
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "mapViewCell", for: indexPath) as! MapViewCell
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
            
         } else {
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
