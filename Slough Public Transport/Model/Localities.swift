//
//  Localities.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 17/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

struct Localities {
    
    let localities = ["Langley", "Iver", "Slough Town Centre, Slough", "Slough",
                      "Upton, Slough", "Chalvey, Slough", "Cippenham, Slough",
                      "Slough Trading Estate, Slough", "Baylis, Slough", "Burnham",
                      "Burnham, Slough", "Britwell, Slough", "Farnham Royal",
                      "Manor Park, Slough", "Upton Lea, Slough", "Wexham Court, Slough",
                      "Elliman, Slough", "George Green", "Richings Park", "Colnbrook",
                      "Stanwell", "Heathrow Airport, London", "Taplow",
                      "Heathrow Airport Terminal 5, Heathrow Airport",
                      "Hatton Cross, London", "Sipson, London", "Poyle", "Brands Hill", ]
    
    func towardsGenerator (_ stopName: String, _ stopDescription: String) -> String{
        
        var output = String()
        
        if stopName.contains(" - W-bound"){
            
            switch stopDescription{
                
            case "Langley", "Wexham Court, Slough", "George Green":
                output = "Towards Slough Town Center"
                
            case "Iver", "Richings Park", "Colnbrook", "Stanwell", "Heathrow Airport, London", "Brands Hill":
                output = "Towards Langley, Slough"
             
            case "Slough Town Centre, Slough", "Slough", "Chalvey, Slough", "Slough Trading Estate, Slough", "Baylis, Slough":
                output = "Towards Cippenham"
                
            case "Upton, Slough":
                output = "Towards Chalvey"
                
            case "Cippenham, Slough", "Britwell, Slough":
                output = "Towards Burnham, Taplow"
                
            case "Burnham", "Burnham, Slough":
                output = "Towards Chalvey"
                
            case "Farnham Royal":
                output = "Towards Britwell"
                
            case "Manor Park, Slough", "Upton Lea, Slough", "Elliman, Slough":
                output = "Towards Slough Trading Estate"
                
            case "Hatton Cross, London":
                output = "Towards Heathrow Airport"
                
            case "Sipson, London", "Poyle":
                output = "Towards Colnbrook"
            
            default:
                output = "Towards Maidenhead, Taplow"
                
            }
        }
            
        if stopName.contains(" - E-bound"){
            
            switch stopDescription{
                
            case "Langley", "Wexham Court, Slough", "George Green":
                output = "Towards Colnbrook, Heathrow Airport"
                
            case "Iver", "Richings Park", "Colnbrook", "Stanwell", "Heathrow Airport, London", "Brands Hill", "Sipson, London", "Poyle":
                output = "Towards Heathrow Airport, Hounslow"
             
            case "Slough Town Centre, Slough", "Slough", "Chalvey, Slough", "Slough Trading Estate, Slough", "Baylis, Slough":
                output = "Towards Langley, Upton"
                
            case "Upton, Slough":
                output = "Towards Langley"
                
            case "Cippenham, Slough", "Britwell, Slough", "Burnham", "Burnham, Slough", "Farnham Royal", "Manor Park, Slough", "Upton Lea, Slough", "Elliman, Slough":
                output = "Towards Slough Town Center"
                
            case "Hatton Cross, London":
                output = "Towards Hounslow, Feltham"
            
            default:
                output = "Slough, Heathrow Airport"
                
            }
        }
        
        if stopName.contains(" - S-bound"){

            switch stopDescription{

            case "Langley":
                output = "Towards Ditton Park, Brands Hill"
                
            case "Wexham Court, Slough":
                output = "Slough Town Center"

            case "Iver", "George Green", "Richings Park", "Heathrow Airport, London", "Brands Hill":
                output = "Towards Langley, Slough"
                
            case "Colnbrook":
                output = "Stanwell"
                
            case "Stanwell":
                output = "Towards Staines, Ashford"

            case "Slough Town Centre, Slough", "Slough", "Chalvey, Slough", "Slough Trading Estate, Slough", "Baylis, Slough":
                output = "Towards Windsor"

            case "Upton, Slough":
                output = "Towards Datchet, Eton"

            case "Cippenham, Slough":
                output = "Towards Eton, Slough Town Center"
                
            case "Britwell, Slough":
                output = "Towards Farnham Road, Slough Town Center"

            case "Burnham", "Burnham, Slough":
                output = "Towards Slough Trading Estate, Cippenham"

            case "Farnham Royal":
                output = "Towards Slough Town Center"

            case "Manor Park, Slough", "Upton Lea, Slough", "Elliman, Slough":
                output = "Towards Slough Town Center"

            case "Hatton Cross, London":
                output = "Towards Feltham"

            case "Sipson, London", "Poyle":
                output = "Towards Stanwell"

            default:
                output = "Towards Windsor"

            }
        }
        
        if stopName.contains(" - N-bound"){

            switch stopDescription{

            case "Langley":
                output = "Towards Iver, Uxbridge"
                
            case "Wexham Court, Slough":
                output = "Towards Stoke Green"

            case "Iver", "George Green", "Richings Park", "Heathrow Airport, London", "Brands Hill":
                output = "Towards Uxbridge"
                
            case "Colnbrook":
                output = "Towards Langley, Iver"
                
            case "Stanwell":
                output = "Towards Colnbrook"

            case "Slough Town Centre, Slough", "Slough", "Chalvey, Slough", "Slough Trading Estate, Slough", "Baylis, Slough":
                output = "Towards Wexham, Farnham Royal"

            case "Upton, Slough", "Cippenham, Slough":
                output = "Towards Slough Town Center, Farnham"
                
            case "Britwell, Slough":
                output = "Towards Farnham"

            case "Burnham", "Burnham, Slough":
                output = "Towards Cookham, Maidenhead"

            case "Farnham Royal":
                output = "Towards Farnham Common"

            case "Manor Park, Slough", "Upton Lea, Slough", "Elliman, Slough":
                output = "Towards Farnham Royal"

            case "Hatton Cross, London":
                output = "Towards Heathrow Airport, Uxbridge"

            case "Sipson, London", "Poyle":
                output = "Towards West Drayton"

            default:
                output = "Towards Wexham"

            }
        }
        
        return output

        }
    
}
