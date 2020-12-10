//
//  LocationView.swift
//  Shat-App
//
//  Created by Neil Sano on 2020-12-09.
//

import SwiftUI
import MapKit

struct DirectionsView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var messageCoordinates = CLLocationCoordinate2D()
    
    var location: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    var body: some View {
        VStack{
            MapView(location: self.location, coordinates: self.messageCoordinates)
        }
        .onAppear(){
            if(self.lat != 0 && self.lng != 0){
                self.messageCoordinates = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
            }else{
                self.locationManager.getCoordinates(address: self.location, completionHandler: {(coordinates, error) in
                    if (error == nil){
                        //Coordinates successfully obtained
                        self.messageCoordinates = coordinates
                        print(#function, "Coordinates Obtained: ", self.messageCoordinates)
                    }else{
                        //prompt the user of unavailable address or route
                        print(#function, "error: ", error?.localizedDescription as Any)
                    }
                })
            }
        }
    }
}

struct DirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsView()
    }
}

struct MapView : UIViewRepresentable{
    
    @ObservedObject var locationManager = LocationManager()
    private var location: String = ""
    private var messageCoordinates: CLLocationCoordinate2D
    private let regionRadius: CLLocationDistance = 300
    
    init(location: String, coordinates: CLLocationCoordinate2D){
        self.location = location
        self.messageCoordinates = coordinates
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let map = MKMapView()
        
        map.mapType = MKMapType.standard
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.isUserInteractionEnabled = true
        
        //let sourceCoordinates = CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387054)
        let sourceCoordinates = CLLocationCoordinate2D(latitude: self.locationManager.lat, longitude: self.locationManager.lng)
        let region = MKCoordinateRegion(center: sourceCoordinates, latitudinalMeters: regionRadius * 4.0, longitudinalMeters: regionRadius * 4.0)
        
        locationManager.addPinToMapView(mapView: map, coordinates: sourceCoordinates, title: "You're Here")
        
        map.setRegion(region, animated: true)
        map.delegate = context.coordinator
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        //let sourceCoordinates = CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387054)
        let sourceCoordinates = CLLocationCoordinate2D(latitude: self.locationManager.lat, longitude: self.locationManager.lng)
        let region = MKCoordinateRegion(center: sourceCoordinates, latitudinalMeters: regionRadius * 4.0, longitudinalMeters: regionRadius * 4.0)
        
        //        locationManager.addPinToMapView(mapView: uiView, coordinates: sourceCoordinates, title: "CN Tower")
        locationManager.addPinToMapView(mapView: uiView, coordinates: sourceCoordinates, title: self.locationManager.address)
        
        let destinationCoordinates = self.messageCoordinates
        self.locationManager.addPinToMapView(mapView: uiView, coordinates: destinationCoordinates, title: "Your Chat partner is here")
        
        uiView.setRegion(region, animated: true)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinates))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinates))
        
        let direction = MKDirections(request: request)
        direction.calculate{(direct,error) in
            
            if error != nil{
                print(#function,"Error finding directions ", error?.localizedDescription)
            }
            
            let polyline = direct?.routes.first?.polyline
            
            if(polyline != nil){
                uiView.addOverlay(polyline!)
                uiView.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
            }
            
        }
    }
    class Coordinator: NSObject, MKMapViewDelegate{
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
    }
}
