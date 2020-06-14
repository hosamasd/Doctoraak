//
//  MainPharamcyyRegisterModel.swift
//  Doctoraak
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainPharamcyyRegisterModel:Codable {
    let status: Int
    var message, messageEn: String?
    var data: PharamcyyRegisterModel?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
    
}

struct PharamcyyRegisterModel:Codable {
    
    let name, email, phone: String
    var phone2: String?
    let lang, latt, delivery, password: String
    let smsCode, active: Int
    let updatedAt, createdAt: String
    let id: Int
    let pharmacyInsurances: [PharmacyInsuranceModel]
    let workingHours: [PharamacyWorkingHourModel]
    let photo: String
    let insuranceCompany: [InsurcaneCompanyModel]
    
    enum CodingKeys: String, CodingKey {
        case name, email, phone, phone2, lang, latt, delivery, password
        case smsCode = "sms_code"
        case active
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case pharmacyInsurances = "pharmacy_insurances"
        case workingHours = "working_hours"
        case photo
        case insuranceCompany = "insurance_company"
    }
}

struct PharamacyWorkingHourModel:Codable {
    
    let id, pharmacyID, day: Int
    let partFrom, partTo: String
    let active: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case pharmacyID = "pharmacy_id"
        case day
        case partFrom = "part_from"
        case partTo = "part_to"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct PharmacyInsuranceModel :Codable {
    let id, pharmacyID, insuranceID: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case pharmacyID = "pharmacy_id"
        case insuranceID = "insurance_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
