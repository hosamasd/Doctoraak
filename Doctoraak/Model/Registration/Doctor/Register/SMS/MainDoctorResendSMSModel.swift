//
//  MainDoctorResendSMSModel.swift
//  Doctoraak
//
//  Created by hosam on 4/29/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainDoctorResendSMSModel:Codable {
    
    let status: Int
    let message, messageEn: String
    let data: DoctorResendSMSModel

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct DoctorResendSMSModel:Codable {
    <#fields#>
}
