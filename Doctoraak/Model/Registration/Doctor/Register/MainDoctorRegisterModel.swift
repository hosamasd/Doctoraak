//
//  MainDoctorRegisterModel.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainDoctorRegisterModel:Codable {
    let status: Int
    let message, messageEn: String
    let data: DoctorRegisterModel
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct DoctorRegisterModel:Codable {
    
    var isMedicalCenter: String?

   let name, email, phone, gender: String
    let specializationID, degreeID, password: String
    let smsCode, active: Int
    let updatedAt, createdAt: String
    let id: Int
    let cv: String
    let photo: String
    let doctorInsurances: [DoctorInsuranceModel]
    let degree, specialization: DegreeDoctorModel
    let insuranceCompany: [DegreeDoctorModel]

    enum CodingKeys: String, CodingKey {
        case name, email, phone, gender
        case specializationID = "specialization_id"
        case degreeID = "degree_id"
        case password
        case smsCode = "sms_code"
        case active
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, cv, photo
        case doctorInsurances = "doctor_insurances"
        case degree, specialization
        case insuranceCompany = "insurance_company"
    }
}

struct DoctorInsuranceModel:Codable {
    let id, doctorID, insuranceID: Int
       let createdAt, updatedAt: String

       enum CodingKeys: String, CodingKey {
           case id
           case doctorID = "doctor_id"
           case insuranceID = "insurance_id"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
       }
}

struct DegreeDoctorModel:Codable {
   let id: Int
    let name, nameAr, nameFr: String
    let createdAt, updatedAt: String?
    let photo: String?
    let url: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case photo, url, icon
    }
}
