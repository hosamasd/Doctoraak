//
//  MainRadiologySMSCodeModel.swift
//  Doctoraak
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainRadiologySMSCodeModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data: RadiologyModel?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct RadiologyModel:Codable {
    
    let id: Int
    let name: String
    var nameAr, nameFr: String?
    let apiToken: String
    var firebaseToken: String?
    let phone: String
    var phone2: String?
    var city, area: Int?
    let lang, latt, smsCode, email: String
    let password: String
    let active: Int
    let delivery: String
    let avaliableDays: Int
    var radiologyDoctorID: Int?
    let photo: String
    let reservationRate, degreeRate, createdAt, updatedAt: String
    let radiologyInsurances: [RadiologyInsuranceModel]
    let workingHours: [RadiologyWorkingHourModel]
    let insuranceCompany: [InsurcaneCompanyModel]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case phone, phone2, city, area, lang, latt
        case smsCode = "sms_code"
        case email, password, active, delivery
        case avaliableDays = "avaliable_days"
        case radiologyDoctorID = "radiology_doctor_id"
        case photo
        case reservationRate = "reservation_rate"
        case degreeRate = "degree_rate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case radiologyInsurances = "radiology_insurances"
        case workingHours = "working_hours"
        case insuranceCompany = "insurance_company"
    }
}

struct RadiologyWorkingHourModel:Codable {
    
    let id, radiologyID, day: Int
    let partFrom, partTo: String
    let active: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case radiologyID = "radiology_id"
        case day
        case partFrom = "part_from"
        case partTo = "part_to"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
