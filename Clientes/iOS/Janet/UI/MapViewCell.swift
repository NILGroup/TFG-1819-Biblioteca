//
//  MapViewCell.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Janet
//
//  Created by Mauri on 05/04/2019.
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
import MapKit

//Clase para un globo de conversación con una localización.
class MapViewCell: TableViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var Direction: UILabel!
    
    //Inicializa los atributos de la clase.
    override func setDatos(info: Globos) {
        
        //Inicializa el delegado de la vista del mapa.
        MapView.delegate = self
        
        self.message.text = "Janet: " + info.getRespuesta()
        self.libraryName.text = info.getLibrary()
        self.Direction.text = info.getDirection()
        self.message.textAlignment = .left
        self.cambiarBurbuja(info: .Bot)
        
        let pLat = info.getLat()
        let pLong = info.getLong()
        let localizacion = CLLocationCoordinate2D(latitude: pLat, longitude: pLong)
        
        //Carga las coordenadas de la localización.
        let reg = MKCoordinateRegion(center: localizacion, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        //Adapta el tamaño a la pantalla del dispositivo.
        self.MapView.sizeToFit()
        self.MapView.setRegion(reg, animated: true)
        
        //Añade un punto rojo en el mapa para indicar la localización.
        let annotation = MKPointAnnotation()
        annotation.coordinate = localizacion
        annotation.title = info.getLibrary()
        self.MapView.addAnnotation(annotation)
    }
    
    //Abre la aplicación de mapas del sistema.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: view.annotation!.coordinate))
        destination.name = view.annotation?.title!
        
        MKMapItem.openMaps(with: [destination], launchOptions: [:])
    }
}
