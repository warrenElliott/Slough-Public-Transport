//
//  BusDeparturesData.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 27/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

struct BusDeparturesData: Decodable{
    
    let departures: [String:[Lines]]
    
}

struct Lines: Decodable{
    
    let line: String
    let direction: String
    let operator_name: String
    let date: String
    let best_departure_estimate: String
    
    
}



