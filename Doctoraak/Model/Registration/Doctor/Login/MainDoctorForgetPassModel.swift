//
//  MainDoctorForgetPassModel.swift
//  Doctoraak
//
//  Created by hosam on 4/29/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MainDoctorForgetPassModel: Codable {
    
    let status: Int
       let message, messageEn: String
       var data: String?

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
}
