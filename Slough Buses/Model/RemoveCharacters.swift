//
//  RemoveCharacters.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 24/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

struct RemoveCharacters{
    
    func busStopName (_ stopName: String) -> String{
        
        var output = stopName
        
        let bounds = [" - W-bound", " - E-bound", " - N-bound", " - S-bound",  " - SE-bound", " - SW-bound", " - NW-bound", " - NE-bound" ]
        
        for bound in bounds{
            
            if output.contains(bound){
                output = output.replacingOccurrences(of: bound, with: "")
            }
            
        }
        
        return output
        
    }
}
