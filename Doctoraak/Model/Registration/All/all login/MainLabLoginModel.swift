//
//  MainLoginAllModel.swift
//  Doctoraak
//
//  Created by hosam on 5/2/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainLabLoginModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data: LabLoginModel?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}
