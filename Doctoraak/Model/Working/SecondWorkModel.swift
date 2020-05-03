//
//  SecondWorkModel.swift
//  Doctoraak
//
//  Created by hosam on 5/3/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct SecondWorkModel:Codable {
    
    let partFrom,partTo: String
          let day, active: Int

          enum CodingKeys: String, CodingKey {
              case partFrom = "part_from"
            case partTo = "part_to"

              case day, active
          }
    
//    init(partFrom:String,partTo:String,day:Int,active:Int) {
//        self.day=day
//        self.active=active
//        self.partTo=partTo
//        self.partFrom=partFrom
//    }
}
