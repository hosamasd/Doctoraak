//
//  WorkingHoursModel.swift
//  Doctoraak
//
//  Created by hosam on 4/21/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct WorkingHoursModel {
    let part1From, part1To, part2From, part2To: String
    let day, active: Int

    enum CodingKeys: String, CodingKey {
        case part1From = "part1_from"
        case part1To = "part1_to"
        case part2From = "part2_from"
        case part2To = "part2_to"
        case day, active
    }
}
