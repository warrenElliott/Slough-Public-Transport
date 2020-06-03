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
            
        case "Maidenhead Railway":
            output = "Maidenhead"
        
        case "Heathrow Central Bu":
            output = "Heathrow Central Bus Station"
            
        case "Slough Town Centre, Slough Bus Station", "Slough Town Centre, Slough":
            output = "Slough"
            
        case "Wexham Court, Wexham Park Hospital":
            output = "Wexham Park Hospital"
            
        case "Bracknell, Bracknell Bus Station":
            output = "Bracknell"
            
        case "Slough Town Centre, Slough Railway Station":
            output = "Slough Railway Station"
            
        case "Cippenham, Cippenham Green":
            output = "Cippenham"
            
        case "High Wycombe Bus St":
            output = "High Wycombe Bus Station"
            
        case "Chalfont Common, Chesham Lane":
            output = "Hedgerley"
            
        case "Uxbridge Rail Stati":
            output = "Uxbridge"
            
        case "Iver, Croft House (unmarked)":
            output = "Iver"
            
        case "Hounslow, London", "Hounslow, Hounslow Bus Station":
            output = "Hounslow Bus Station"
            
        case "Heathrow Airport Te":
            output = "Heathrow Airport T5"
            
        case "HEATHROW, Terminal ":
            output = "Heathrow Airport T5"
            
        case "Heathrow Airport Terminal 5, Heathrow Terminal 5":
            output = "Heathrow Airport T5"
        
        case "Kennedy Park Shops":
            output = "Britwell"
            
        default:
            output = destination
            
        }
        
        return output
        
    }
    
    
}
