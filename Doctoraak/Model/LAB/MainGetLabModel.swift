//
//  MainGetLabModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit

struct MainGetLabModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [GetLabModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct GetLabModel:Codable {
    let id: Int
    let name: String
    var nameAr, nameFr,email: String?
    let phone: String
    let phone2: String?
    let city, area: Int?
    let lang, latt, apiToken: String
    let firebaseToken: String?
    let smsCode, password: String
    let active: Int
    let delivery: String
    let avaliableDays: Int
    var labDoctorID: Int?
    let photo, createdAt, updatedAt: String
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
        case insuranceCompany = "insurance_company"
    }
}
