//
//  RadiologyRegisterModel.swift
//  Doctoraak
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainRadiologyRegisterModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data: RadiologyRegisterModel?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct RadiologyRegisterModel:Codable {
    
    let name, email, phone: String
    var phone2: String?
    let delivery, password: String
    let smsCode, active: Int
    let lang, latt, city, area: String
    let updatedAt, createdAt: String
    let id: Int
    let radiologyInsurances: [RadiologyInsuranceModel]
    let workingHours: [RadiologyWorkingHourModel]
    let photo: String
    let insuranceCompany: [InsurcaneCompanyModel]

    enum CodingKeys: String, CodingKey {
        case name, email, phone, phone2, delivery, password
        case smsCode = "sms_code"
        case active, lang, latt, city, area
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case radiologyInsurances = "radiology_insurances"
        case workingHours = "working_hours"
        case photo
        case insuranceCompany = "insurance_company"
    }
}

struct RadiologyInsuranceModel:Codable {
    let id, radiologyID, insuranceID: Int
       let createdAt, updatedAt: String

       enum CodingKeys: String, CodingKey {
           case id
           case radiologyID = "radiology_id"
           case insuranceID = "insurance_id"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
       }
}

//struct RadiologyWorkingHoursModel:Codable {
//     let id, radiologyID, day: Int
//       let partFrom, partTo: String
//       let active: Int
//       let createdAt, updatedAt: String
//
//       enum CodingKeys: String, CodingKey {
//           case id
//           case radiologyID = "radiology_id"
//           case day
//           case partFrom = "part_from"
//           case partTo = "part_to"
//           case active
//           case createdAt = "created_at"
//           case updatedAt = "updated_at"
//       }
//}
