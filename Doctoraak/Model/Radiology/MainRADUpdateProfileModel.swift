//
//  MainRADUpdateProfileModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainRADUpdateProfileModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: RadiologyModel?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}
