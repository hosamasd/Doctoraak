//
//  SecondWorkModel.swift
//  Doctoraak
//
//  Created by hosam on 5/3/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct PharamacyWorkModel:Codable {
    
    let partFrom,partTo: String
          let day, active: Int

          enum CodingKeys: String, CodingKey {
              case partFrom = "part_from"
            case partTo = "part_to"

              case day, active
          }
}
