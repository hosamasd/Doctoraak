//
//  Date.swift
//  MapKitSwiftUI
//
//  Created by hosam on 6/21/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit



extension Date {
    
    func formatHeaderTimeLabel(time: Date) ->String {
        var text = ""
        let currentDate = Date()
        let currentDateString = currentDate.toString(dateForamt: "yyyyMMdd")
        let pastDateString = time.toString(dateForamt: "yyyyMMdd")
        if pastDateString.elementsEqual(currentDateString) == true {
            text = time.toString(dateForamt: "HH:mm a") + ", Today"
        } else {
            text = time.toString(dateForamt: "dd/MM/yyyy")
        }
        
        return text
    }
    
    func timeSinceAgoDisplay() -> String {
        
        let second = Int(Date().timeIntervalSince( self))
        
        let mintue = 60
        let hour = 60 * mintue
        let day = 24 * hour
        let week = 7 * day
        
        if second < mintue {
            return "\(second) seconds ago"
        }else if second < hour{
            return "\(second / mintue) Mintues ago"
        }else if second < day {
            return "\(second / hour) hours ago"
        }else if second < week{
            return "\(second / day) days ago"
        }
        return "\(second / week) weeks ago"
    }
    
    func toString(dateForamt:String) -> String {
        let dateForamteer = DateFormatter()
        dateForamteer.dateFormat = dateForamt
        return dateForamteer.string(from:self)
    }
}

