//
//  MainDoctorsUpdateProfileModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainDoctorsUpdateProfileModel:Codable {
    let status: Int
       let message, messageEn: String
       var data: DoctorModel?

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
}
