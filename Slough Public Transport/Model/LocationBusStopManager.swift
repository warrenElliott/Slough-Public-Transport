//
//  LocationBusStopManager.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 17/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

protocol BusStopsAtLocationDelegate{
    
    func didUpdateMap(stops: [BusStops])
    func didFailWithError(error: Error)
    
}


struct LocationBusStopManager{
    
    var delegate: BusStopsAtLocationDelegate?
    
    func fetchBusStops(with latitude: String, and longitude: String){
        
        let urlString = "https://transportapi.com/v3/uk/places.json?lat=\(latitude)&lon=\(longitude)&type=bus_stop&app_id=29af5b59&app_key=300d18d6882d84b6a00adefd328f8722"
        
        performRequest(with: urlString)
        
    }
    
    func performRequest (with urlString: String){
        
        if let url = URL(string: urlString){
                    
            //create URL session
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let busStopsAtLocation = self.parseJSON(safeData){
                                               
                        self.delegate?.didUpdateMap(stops: busStopsAtLocation)
                        
                    }
                    
                }
                
            }
            
            task.resume()
        
        
        
        }
    }
    
    func parseJSON (_ locationData: Data) -> [BusStops]?{
        
        let decoder = JSONDecoder()
        
        do{
            
            var locationBusStops: [BusStops] = []
            let decodedData = try decoder.decode(LocationBusStopsData.self, from: locationData)
            
            for stop in decodedData.member{
                
                for locality in Localities().localities{
                    
                    if stop.description == locality{
                        
                        let busStop = BusStops(name: stop.name, latitude: stop.latitude, longitude: stop.longitude, description: stop.description, atcocode: stop.atcocode)
                        locationBusStops.append(busStop)
                        
                    }
                    
                }
  
            }
    
            return locationBusStops
        }
        
        catch{
            
            print (error)
        }
        
        return nil
        
    }
    
    
}
