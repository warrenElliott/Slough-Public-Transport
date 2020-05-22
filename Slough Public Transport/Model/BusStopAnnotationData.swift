//
//  CustomAnnotation.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 21/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import MapKit

class BusStopAnnotationData: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var busStopName: String!
    var busRoutes: String!
    var atcoCode: String!
    
    init(coordinate: CLLocationCoordinate2D, busStopName: String, busRoutes: String, atcoCode: String) {
        
        self.coordinate = coordinate
        self.busStopName = busStopName
        self.busRoutes = busRoutes
        self.atcoCode = atcoCode
        
    }

}
