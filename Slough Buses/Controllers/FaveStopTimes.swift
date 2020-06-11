//
//  FaveStopTimes.swift
//  Slough Buses
//
//  Created by Warren Elliott on 10/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import UIKit

class FaveStopTimesVC: UITableViewController{

    @IBOutlet weak var faveStopLabel: UILabel!
    @IBOutlet weak var faveTowardsLabel: UILabel!
    
    var table: StopTableView = StopTableView()
    
    struct InterfaceData{
        
        var atcoCode: String
        var stopName: String
        var torwards: String
        
    }
    
    var requiredData = InterfaceData(atcoCode: "", stopName: "", torwards: "")
    
    var busDeparturesManager = BusDeparturesManager()
    var busDepartures: [BusStopDepartures] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print (requiredData)
        tableView.register(UINib(nibName: "TimeTableCell", bundle: nil), forCellReuseIdentifier: "TimeTableCell")
        faveStopLabel.text = requiredData.stopName
        faveTowardsLabel.text = requiredData.torwards
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTable()
        
        
    }
    
    func setupTable(){
        
        let reusableTable = StopTableView(frame: tableView.frame)
        tableView.addSubview(reusableTable)
        
        // need to sort out the required ATCOCODE, IT WORKS FOR THE TIME BEING :D
        
    }

}

