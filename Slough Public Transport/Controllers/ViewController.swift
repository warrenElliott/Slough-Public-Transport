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

class ViewController: UIViewController, BusStopsAtLocationDelegate, UITableViewDelegate {
    
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
    var busDeparturesManager = BusDeparturesManager()
    
    var busStopsAtLocation = [BusStops]()
    var busStopAnnotations: [MKPointAnnotation] = []
    
    var annotationData: [BusStopAnnotationData] = []
    
    var busDepartures: [BusStopDepartures] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TimeTableCell", bundle: nil), forCellReuseIdentifier: "TimeTableCell")

        placeholderForTableView()
        
        mapView.delegate = self
        locationBusStopManager.delegate = self
        busDeparturesManager.secondDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    func placeholderForTableView(){

        let noDataLabel: UILabel = UILabel()
        noDataLabel.text = "Tap  on  a  bus  stop  to  get  live  departures"
        noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        noDataLabel.font = UIFont(name: "Farah", size: 17.0)
        noDataLabel.textAlignment = NSTextAlignment.center
        tableView.backgroundView = noDataLabel
        self.tableView.reloadData()

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
        
        if view.annotation is MKUserLocation{
            return
        }
        
        else{
            
            let busStopAnnotation = view.annotation as! BusStopAnnotationData
            let calloutView = Bundle.main.loadNibNamed("CalloutView", owner: nibName, options: nil)
            
            let views = calloutView?[0] as! CalloutView
            views.layer.cornerRadius = 15
            views.busStopName.text = busStopAnnotation.busStopName
            views.busRoutes.text = "To be confirmed"
            views.torwardsInfo.text = busStopAnnotation.towards
            
            views.center = CGPoint(x: view.bounds.size.width / 2, y: -views.bounds.size.height*0.52)
            view.addSubview(views)
    
            mapView.setCenter((view.annotation?.coordinate)!, animated: true)
            
            busDeparturesManager.fetchDepartures(busStopAnnotation.atcoCode!)
            
            print (busStopAnnotation.atcoCode!)
            
        }
        
        
        customLocator.isHidden = true

        
    }
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
           if view.isKind(of: ShowAnnotationView.self)
           {
               for subview in view.subviews
               {
                   subview.removeFromSuperview()
               }
           }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = ShowAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }
        else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "busStopIcon")
        return annotationView
        
    }
    
    
    func createBusStops (busStops: [BusStops]){
        
        busStopAnnotations = []
        
        for stop in busStops{
            
            let annotation = BusStopAnnotationData(coordinate: CLLocationCoordinate2D.init(latitude: stop.latitude, longitude: stop.longitude), busStopName: RemoveCharacters().busStopName(stop.name), busRoutes: "TBA", atcoCode: stop.atcocode, towards: Localities().towardsGenerator(stop.name, stop.description))
            
            let serialQueue = DispatchQueue(label: "mainQueue")
            
            serialQueue.sync {
                annotationData.append(annotation)
            }
            
            
            

        }
        
        DispatchQueue.main.async {
            
            self.mapView.addAnnotations(self.annotationData)
            
        }
        
    }
    
}

extension ViewController: BusDeparturesManagerDelegate{
    
    func didUpdateTable(departures: [BusStopDepartures]) {
        
        busDepartures = []
        
        for departure in departures{
            
            if let countdownDB = Double(departure.countdown), countdownDB < 60.0 && countdownDB > 2.0{
                
                busDepartures.append(departure)
                
                }
            }
        
        DispatchQueue.main.async {
            
            self.tableView.rowHeight = 55.0
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundView = nil
            self.tableView.tableFooterView = UIView()
            self.tableView.reloadData()
            
        }
        
        busDepartures = busDepartures.sorted{Double($0.countdown) ?? 0 < Double($1.countdown) ?? 0}
        
    }

    func didFail(error: Error) {
        
        print (error)
        
    }

}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busDepartures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableCell", for: indexPath) as! TimeTableCell
        cell.busRouteLabel.text = busDepartures[indexPath.row].line
        cell.directionLabel.text = busDepartures[indexPath.row].direction
        cell.operatorLabel.text = busDepartures[indexPath.row].operator_name
        cell.countdownLabel.text = timeRemaining(time: busDepartures[indexPath.row].countdown)
        
        return cell
        
    }
    
    func timeRemaining (time: String) -> String{
        
        var result = String()
        
        guard let timeInDb = Double(time) else { return "0" }
        let timeInInt = Int(timeInDb)
        
        if timeInInt <= 0{
            result = "Due"
        }
        else{
            result = String(timeInInt) + " min"
        }
        
        
        
        return result
    }
    
    
    
    
    
}


    
    
    
    
    


