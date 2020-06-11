//
//  StopTableView.swift
//  Slough Buses
//
//  Created by Warren Elliott on 11/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import UIKit

class StopTableView: UITableView, UITableViewDelegate, UITableViewDataSource, BusDeparturesManagerDelegate{
    
    var busDeparturesManager = BusDeparturesManager()
    var busDepartures: [BusStopDepartures] = []
    var data: String = "040000001903"
    
    override init(frame: CGRect, style: UITableView.Style) {
        
        super.init(frame: frame, style: .plain)
        
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: "TimeTableCell", bundle: nil), forCellReuseIdentifier: "TimeTableCell")
        self.busDeparturesManager.secondDelegate = self
        self.fetchData(data)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func fetchData(_ data: String){
        
        busDeparturesManager.fetchDepartures(data)
        
    }
    

    func didUpdateTable(departures: [BusStopDepartures]) {
        
        busDepartures = []
        
        for departure in departures{
            
            if let countdownDB = Double(departure.countdown), countdownDB < 60.0 && countdownDB > 2.0{
                
                busDepartures.append(departure)
                
                }
            }
        
        DispatchQueue.main.async {
            
            self.rowHeight = 55.0
            self.separatorStyle = .singleLine
            self.backgroundView = nil
            self.tableFooterView = UIView()
            self.reloadData()
            
        }
        
        busDepartures = busDepartures.sorted{Double($0.countdown) ?? 0 < Double($1.countdown) ?? 0}
        
    }

    func didFail(error: Error) {
        
        print (error)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busDepartures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableCell", for: indexPath) as! TimeTableCell
        cell.busRouteLabel.text = busDepartures[indexPath.row].line
        cell.directionLabel.text = busDepartures[indexPath.row].direction
        cell.operatorLabel.text = busDepartures[indexPath.row].operator_name
        cell.countdownLabel.text = timeRemaining(time: busDepartures[indexPath.row].countdown)
        
        return cell
        
    }
    
    func timeRemaining (time: String) -> String{
        
        var result = String()
        
        guard let timeInDb = Double(time) else { return "0" }
        let timeInInt = Int(timeInDb)
        
        if timeInInt <= 0{
            result = "Due"
        }
        else{
            result = String(timeInInt) + " min"
        }
        
        return result
    }
    
}
