//
//  BusDirection.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 01/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

struct BusDirection{
    
    func setDestination (_ destination: String) -> String{
        
        var output = String()
        
        switch destination{
            
        case "Wrexham":
            output = "X"
            
        default:
            output = destination
            
        }
        
        return output
        
    }
    
    
}
