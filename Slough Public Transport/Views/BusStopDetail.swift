//
//  BusStopDetail.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 21/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import UIKit
import MapKit
import UIKit

class BusStopDetail: MKAnnotationView {

    @IBOutlet weak var busStopName: UILabel!
    @IBOutlet weak var busStopRoutes: UILabel!
    
    var busStopAtcoCode = String()
    
}
