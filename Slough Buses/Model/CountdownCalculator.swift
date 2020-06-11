//
//  CountdownCalculator.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 28/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

class CountDownCalculator{
    
    func countdown (_ time: String, _ date: String) -> String{
        
        let completedtime :String = date + " " + time
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        guard let formattedDate1 = format.date(from: completedtime) else {return ""}
        
        print (formattedDate1)
        return stringFromTimeInterval(formattedDate1)
        
    }
    

    func stringFromTimeInterval(_ interval: Date) -> String {
        
        let date = Date()
        let iv = interval.timeIntervalSince(date)
        let minutes = floor(iv/60)
        
        print(minutes)
        
        return String(minutes)

    }
    
}
