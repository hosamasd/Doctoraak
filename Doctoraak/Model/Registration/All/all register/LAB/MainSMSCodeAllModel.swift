//
//  MainSMSCodeAllModel.swift
//  Doctoraak
//
//  Created by hosam on 5/2/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainLabSMSCodeModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data:LabLoginModel?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}
struct LabLoginModel:Codable {
    let id: Int
    let name: String
    var nameAr, nameFr: String?
    let phone: String
    var phone2: String?
    let city, area: Int
    let lang, latt, apiToken: String
    var firebaseToken: String?
    let smsCode, email, password: String
    let active: Int
    let delivery: String
    let avaliableDays: Int
    var labDoctorID: String?
    let photo: String
    let createdAt, updatedAt: String
    let labInsurances: [AllInsuranceModel]
    let workingHours: [LabWorkingHoursModel]
    let insuranceCompany: [InsurcaneCompanyModel]

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case phone, phone2, city, area, lang, latt
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case smsCode = "sms_code"
        case email, password, active, delivery
        case avaliableDays = "avaliable_days"
        case labDoctorID = "lab_doctor_id"
        case photo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case labInsurances = "lab_insurances"
        case workingHours = "working_hours"
        case insuranceCompany = "insurance_company"
    }
}
