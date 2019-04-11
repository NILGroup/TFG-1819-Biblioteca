//
//  MapViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 05/04/2019.
//  Copyright © 2019 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit
import MapKit

class MapViewCell: TableViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var Direction: UILabel!
    
    override func setDatos(info: Globos) {
        
        MapView.delegate = self
        
        self.message.text = "Janet: " + info.getRespuesta()
        self.Direction.text = info.getDirection()
        self.message.textAlignment = .left
        //self.message.sizeToFit()
        //self.Direction.sizeToFit()
        self.cambiarBurbuja(info: .Bot)
        
        let pLat = info.getLat()
        let pLong = info.getLong()
        let localizacion = CLLocationCoordinate2D(latitude: pLat, longitude: pLong)
        
        let reg = MKCoordinateRegion(center: localizacion, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.MapView.sizeToFit()
        self.MapView.setRegion(reg, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = localizacion
        annotation.title = info.getLibrary()
        self.MapView.addAnnotation(annotation)
    }
    
}
