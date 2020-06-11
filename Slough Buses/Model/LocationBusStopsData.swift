//
//  LocationBusStopsData.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 17/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

struct LocationBusStopsData: Decodable{
    
    let member: [Members]
    
}

struct Members: Decodable{
    
    let name: String
    let latitude: Double
    let longitude: Double
    let description: String
    let atcocode: String
    
}
