//
//  ShowAnnotationView.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 22/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import MapKit

class ShowAnnotationView: MKAnnotationView{
    
     override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? { //bring to front
         
         let hitView = super.hitTest(point, with: event)
         if (hitView != nil){
             
             self.superview?.bringSubviewToFront(self)
            
         }
         
         return hitView
     }
     
     override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
         
         let rect = self.bounds
         var isInside: Bool = rect.contains(point)
         if(!isInside)
         {
             for view in self.subviews
             {
                 isInside = view.frame.contains(point)
                 if isInside
                 {
                     break
                 }
             }
         }
         return isInside
         
     }
}
