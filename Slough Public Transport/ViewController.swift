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

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        checkLocationAuth()
    }
    
    func checkLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            checkLocationManager()
            checkLocationAuth()
        }
        else{
            //show alert
        }
    }
    
    func checkLocationAuth(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
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
       
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    
    
}

