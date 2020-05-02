//
//  MainDoctorVerificationModel.swift
//  Doctoraak
//
//  Created by hosam on 4/27/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
struct MainDoctorSMSAndResendCodeModel:Codable {
    
    let status: Int
       let message, messageEn: String
       var data: DoctorModel?

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
}

struct DoctorModel:Codable {
    let id: Int
    let name: String
    var nameAr, nameFr: String?
    let gender, phone, smsCode, apiToken: String
    var firebaseToken: String?
    let email, password: String
    let active, specializationID, degreeID: Int
    let cv: String
    var cv2: String?
    let photo: String
    var reservationRate, degreeRate: String?
    let createdAt, updatedAt: String
    let isHospital: Int
    var dataDescription: String?
    let isMedicalCenter: Int
    let doctorInsurances: [AllInsuranceModel]
    let degree, specialization: DegreeDoctorModel
    let insuranceCompany: [DegreeDoctorModel]

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case gender, phone
        case smsCode = "sms_code"
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case email, password, active
        case specializationID = "specialization_id"
        case degreeID = "degree_id"
        case cv, cv2, photo
        case reservationRate = "reservation_rate"
        case degreeRate = "degree_rate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isHospital
        case dataDescription = "description"
        case isMedicalCenter = "is_medical_center"
        case doctorInsurances = "doctor_insurances"
        case degree, specialization
        case insuranceCompany = "insurance_company"
    }
    
}
