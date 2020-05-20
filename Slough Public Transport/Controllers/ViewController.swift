//
//  ViewController.swift
//  Slough Transport
//
//  Created by Warren Elliott on 14/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, BusStopsAtLocationDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customLocator: UIImageView!
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 500
    
    var latitude: String?
    var longitude: String?
    
    var customLatitude = String()
    var customLongitude = String()
    
    var locationBusStopManager = LocationBusStopManager()
    
    var busStopsAtLocation = [BusStops]()
    var busStopAnnotations: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        locationBusStopManager.delegate = self
        
        checkLocationServices()
        checkLocationAuth()
        
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
        if latitude == nil{
            
            print ("could not get location. Drag map to load Bus Stops")
            return
            
        }
            
        else{
            
            latitude = String(format:"%.3f", (self.locationManager.location?.coordinate.latitude)! as Double)
            longitude = String(format:"%.3f",(self.locationManager.location?.coordinate.longitude)! as Double)
            
            locationBusStopManager.fetchBusStops(with: latitude!, and: longitude!)
            
        }
        
    }
    
    
    func checkLocationManager(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func centerViewOnUserLocation(){
        
        if let location = locationManager.location?.coordinate{
            
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            
        }
        
    }
    
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled(){
            checkLocationManager()
            checkLocationAuth()
            locationManager.startUpdatingLocation()
            
        }
        else{
            //show alert
        }
    }
    
    func checkLocationAuth(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            
        case .denied:
        break //not allowed, show alert instructing how to turn on app permission
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // show alert showing what to do
            break
        case .authorizedAlways:
            break
        default:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        }
    }
    
    func didUpdateMap(stops: [BusStops]) {
        busStopsAtLocation = stops
        
        createBusStops(busStops: busStopsAtLocation)
        
    }
    
    func didFailWithError(error: Error) {
        print (error)
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkLocationAuth()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Failed to find user's location: \(error.localizedDescription)")
        
    }
    
    
    
}

extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {

        customLocator.isHidden = false
        customLocator.startAnimating()
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        print ("region changed")
        
        customLatitude = String(format:"%.3f", mapView.centerCoordinate.latitude)
        customLongitude = String(format:"%.3f", mapView.centerCoordinate.longitude)
        
        if customLatitude == latitude && customLongitude == longitude{
            
            customLocator.isHidden = true
            
        }
            
        else{
            
            self.mapView.removeAnnotations(self.busStopAnnotations)
            locationBusStopManager.fetchBusStops(with: customLatitude, and: customLongitude)
            
        }
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print ("did select")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "busStopIcon")
            
            
            // for a disclosure button, you'd might do something like:
            //
            //let detailButton = UIButton(type: .detailDisclosure)
            //annotationView?.rightCalloutAccessoryView = detailButton
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    
    func createBusStops (busStops: [BusStops]){
        
        busStopAnnotations = []
        
        for stop in busStops{
            
            let annotations = MKPointAnnotation()
            
            annotations.title = stop.name
            annotations.subtitle = "7, 12, 13"
            annotations.coordinate.longitude = stop.longitude
            annotations.coordinate.latitude = stop.latitude
            
            busStopAnnotations.append(annotations)
            print (annotations)
            
            
        }
        
        DispatchQueue.main.async {
            
            self.mapView.addAnnotations(self.busStopAnnotations)
            
        }
        
        
        print ("request done")
        
        
    }
    
    
    
}

