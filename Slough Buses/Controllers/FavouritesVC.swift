//
//  FavouritesVC.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 08/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class FavouritesVC: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var favourites = [FavouriteBusStop]()
    var busStopName = String()
    var busStopAtCoCode = String()
    
    var faveStopCode = String()
    var faveStopName = String()
    var faveStopTowards = String()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadMessages()
        
    }
    
    func loadMessages(){
        
        db.collection("Favourites").order(by: "timestamp").addSnapshotListener { (querySnapshot, error) in
            
            self.favourites = []
            
            if let e = error{
                
                print (e)
                
            }
                
            else{
                
                if let snapshotDocs = querySnapshot?.documents{
                    
                    for doc in snapshotDocs{
                        
                        let data = doc.data()
                        
                        if let stopCode = data["code"] as? String, let stopName = data["stopName"] as? String, let stopTowards = data["towards"] as? String{
                            
                            let newEntry = FavouriteBusStop(code: stopCode, stopName: stopName, towardsInfo: stopTowards)
                            
                            self.favourites.append(newEntry)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                            }
                        }
                        
                    }
                    
                }
            }
        }

    }
}

extension FavouritesVC: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favourites.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath)
        
        cell.textLabel?.text = favourites[indexPath.row].stopName + ", " + favourites[indexPath.row].towardsInfo
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        faveStopCode = favourites[indexPath.row].code
        faveStopName = favourites[indexPath.row].stopName
        faveStopTowards = favourites[indexPath.row].towardsInfo
        
        performSegue(withIdentifier: "showFaveStopTime", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showFaveStopTime"{
            
            let destinationVC = segue.destination as! FaveStopTimesVC
            
            destinationVC.requiredData.atcoCode = faveStopCode
            destinationVC.requiredData.stopName = faveStopName
            destinationVC.requiredData.torwards = faveStopTowards
            
        }
        
    }
    
    
}
