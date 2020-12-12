//
//  LocationController.swift
//  Shat-App
//
//  Created by Neil Sano on 2020-12-12.
//

import Foundation
import MapKit
import UIKit
import FirebaseFirestore

class LocationController: UIViewController, CLLocationManagerDelegate{
    
    var window: UIWindow?
    var mapView: MKMapView = MKMapView()
    var locationManager : LocationManager
    let regionRadius: CLLocationDistance = 300
    
    init(manager: LocationManager){
        self.locationManager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        let senderCoordinates = CLLocationCoordinate2D(latitude: self.locationManager.lat, longitude: self.locationManager.lng)
        print("\(senderCoordinates)")
        let region = MKCoordinateRegion(center: senderCoordinates, latitudinalMeters: regionRadius * 4.0, longitudinalMeters: regionRadius * 4.0)
        mapView.setRegion(region, animated: true)
        self.mapView = MKMapView(frame: UIScreen.main.bounds)
        self.locationManager.addPinToMapView(mapView: mapView, coordinates: senderCoordinates, title: "You sent a message to this user from here")
        self.view.addSubview(self.mapView)
    }
    
    
    
}
