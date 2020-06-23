//
//  MainDoctorLoginModel.swift
//  Doctoraak
//
//  Created by hosam on 4/29/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainDoctorLoginModel:Codable {
     let status: Int
       let message, messageEn: String
       var data: DoctorModel?

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
}

//struct DoctorLoginModel:Codable {
//
//}
