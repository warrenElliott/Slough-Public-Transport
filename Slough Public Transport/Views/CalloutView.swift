//
//  CalloutView.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 22/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import Firebase

class CalloutView: UIView{
    
    let db = Firestore.firestore()
 
    @IBOutlet weak var busStopName: UILabel!
    @IBOutlet weak var torwardsInfo: UILabel!
    @IBOutlet weak var busRoutes: UILabel!
    @IBOutlet weak var addToFavourites: UIButton!
    
    var atCoCode: String?
    
    @IBAction func addToFavouritesPressed(_ sender: UIButton) {
        
        if let code = atCoCode, let stopName = busStopName.text, let towards = torwardsInfo.text{
            
            db.collection("Favourites").addDocument(data: [
                "stopName" : stopName,
                "towards" : towards,
                "code" : code,
                "timestamp" : Date().timeIntervalSince1970
                ]) { (error) in
                    
                    if let e = error{
                        print (e, "there has been an error")
                    }
                    else{
                        print ("successfully saved into database!")
                    }
                
            }
            
        }
        
        
        
        
    }
    
}
