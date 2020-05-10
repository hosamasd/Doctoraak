//
//  MainRadiologyLoginModel.swift
//  Doctoraak
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
struct MainRadiologyLoginModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data: RadiologyLoginModel?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}
