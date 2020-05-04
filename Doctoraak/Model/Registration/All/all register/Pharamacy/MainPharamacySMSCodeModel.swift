//
//  MainPharamacySMSCodeModel.swift
//  Doctoraak
//
//  Created by hosam on 5/4/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainPharamacySMSCodeModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: PharamacyLoginModel?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct PharamacyLoginModel:Codable {
    
    let id: Int
    let name: String
    var nameAr, nameFr: String?
    let phone: String
    var phone2, address, addressAr, addressFr: String?
    let lang, apiToken: String
    var firebaseToken: String?
    let latt, smsCode, email, password: String
    let active: Int
    let delivery: String
    let avaliableDays: Int
    var pharmacyDoctorID: Int?
    let photo: String
    let createdAt, updatedAt: String
    let pharmacyInsurances: [PharmacyInsuranceModel]
    let workingHours: [PharamacyWorkingHourModel]
    let insuranceCompany: [InsurcaneCompanyModel]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case phone, phone2, address
        case addressAr = "address_ar"
        case addressFr = "address_fr"
        case lang
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case latt
        case smsCode = "sms_code"
        case email, password, active, delivery
        case avaliableDays = "avaliable_days"
        case pharmacyDoctorID = "pharmacy_doctor_id"
        case photo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pharmacyInsurances = "pharmacy_insurances"
        case workingHours = "working_hours"
        case insuranceCompany = "insurance_company"
    }
}
