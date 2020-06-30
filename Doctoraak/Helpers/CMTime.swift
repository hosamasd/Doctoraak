//
//  CMTime.swift
//  MapKitSwiftUI
//
//  Created by hosam on 6/21/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import AVKit


extension CMTime {
    
    func toStringDisplay() ->String {
        if CMTimeGetSeconds(self).isNaN {
            return "--:--"
        }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let second = totalSeconds %  60
        let mintue = totalSeconds % (60 * 60) / 60
        let hours = totalSeconds / 60 / 60
        
        let displayString = String(format: "%02d:%02d:%02d", hours,mintue,second)
        
        return displayString
    }
    
    func toSecondStringDisplay() ->String {
        if CMTimeGetSeconds(self).isNaN {
            return "--:--"
        }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let second = totalSeconds %  60
        let mintue = totalSeconds % (60 * 60) / 60
        let hours = totalSeconds / 60 / 60
        
        let displayString = String(format: "%02d:%02d", mintue,second)
        
        return displayString
    }
}
