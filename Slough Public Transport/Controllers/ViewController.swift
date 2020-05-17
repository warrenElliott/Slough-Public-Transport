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
    
    var latitude = String()
    var longitude = String()
    
    var customLatitude = String()
    var customLongitude = String()
    
    var locationBusStopManager = LocationBusStopManager()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        checkLocationServices()
        checkLocationAuth()
        mapView.delegate = self
        locationBusStopManager.delegate = self
    
    }
    
    
    func didUpdateMap(stops: [BusStops]) {
        print (stops)
    }
    
    func didFailWithError(error: Error) {
        print (error)
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
            //locationManager.requestLocation()
            latitude = String(format:"%.3f", (locationManager.location?.coordinate.latitude)! as Double)
            longitude = String(format:"%.3f",(locationManager.location?.coordinate.longitude)! as Double)
            
            locationBusStopManager.fetchBusStops(with: latitude, and: longitude)
            
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
    
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        //guard let location = locations.last else{return}
        //let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        //mapView.setRegion(region, animated: true)
       
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
        
        //print ("about to change")
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
            locationBusStopManager.fetchBusStops(with: customLatitude, and: customLongitude)
        }
        
    }
    
    
    
    
    
}

