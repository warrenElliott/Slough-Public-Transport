//
//  BusDeparturesManager.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 27/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

protocol BusDeparturesManagerDelegate{
    
    func didUpdateTable(departures: [BusStopDepartures])
    func didFail(error: Error)
    
}


struct BusDeparturesManager{
    
    var secondDelegate: BusDeparturesManagerDelegate?
    
    func fetchDepartures(_ atcocode: String){
        
        let urlString = "https://transportapi.com/v3/uk/bus/stop/\(atcocode)/live.json?app_id=29af5b59&app_key=300d18d6882d84b6a00adefd328f8722&group=route&nextbuses=yes"
        
        performRequest(with: urlString)
        
    }
    
    func performRequest (with urlString: String){
        
        if let url = URL(string: urlString){
                    
            //create URL session
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    self.secondDelegate?.didFail(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let stopDepartures = self.parseJSON(safeData){
                                               
                        self.secondDelegate?.didUpdateTable(departures: stopDepartures)
                        
                    }
                    
                }
                
            }
            
            task.resume()
        
        }
    }
    
    func parseJSON (_ locationData: Data) -> [BusStopDepartures]?{
        
        let decoder = JSONDecoder()
        
        do{
            
            var stopDepartures: [BusStopDepartures] = []
            let decodedData = try decoder.decode(BusDeparturesData.self, from: locationData)
    
            
            for (_, value) in decodedData.departures{
                    
                for entry in value{

                    let instance = BusStopDepartures(line: entry.line, direction: BusDirection().setDestination(entry.direction), countdown: CountDownCalculator().countdown(entry.best_departure_estimate, entry.date), operator_name: entry.operator_name)
                    
                    print (entry.direction)
                
                    stopDepartures.append(instance)

//                    if let count = Double(instance.countdown), count<=40.0{
//
//                        stopDepartures.append(instance)
//
//                    }

                }
                
            }
    
            return stopDepartures
        }
        
        catch{
            
            print (error)
        }
        
        return nil
        
    }
    
    
}
