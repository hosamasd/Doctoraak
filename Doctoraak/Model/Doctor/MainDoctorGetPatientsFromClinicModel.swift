//
//  MainDoctorGetPatientsFromClinicModel.swift
//  Doctoraak
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
struct MainDoctorGetPatientsFromClinicModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [DoctorGetPatientsFromClinicModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct PatientModel:Codable {
    let id: Int
    let name: String
    var nameAr, nameFr,apiToken,firebaseToken: String?
    let phone, smsCode: String
    let email, gender, password: String
    let active: Int
    let birthdate: String
    let photo: String
    var insuranceID:Int? 
    
    var insuranceCode: String?
    let address: String
    var blockDate,addressAr, addressFr: String?
    let createdAt, updatedAt: String
    var insuranceCodeID, blockDays: Int?
    let url: String
    var insurance: InsurcaneCompanyModel?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case phone
        case smsCode = "sms_code"
        case apiToken = "api_token"
        case firebaseToken = "firebase_token"
        case email, gender, password, active
        case insuranceID = "insurance_id"
        case birthdate, photo
        case insuranceCode = "insurance_code"
        case address
        case addressAr = "address_ar"
        case addressFr = "address_fr"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case insuranceCodeID = "insurance_code_id"
        case blockDays = "block_days"
        case blockDate = "block_date"
        case url, insurance
    }
}

struct DoctorGetPatientsFromClinicModel:Codable {
    let id, clinicID, patientID, partID: Int
    let active, reservationNumber: Int
    let type: String
    var notes: String?
    let date, createdAt, updatedAt: String
    let patient: PatientModel
    let clinic: GetClinicModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case clinicID = "clinic_id"
        case patientID = "patient_id"
        case partID = "part_id"
        case active
        case reservationNumber = "reservation_number"
        case type, notes, date
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case patient, clinic
    }
}

struct DoctorModel:Codable {
    let id: Int
    let name: String
    var nameAr, nameFr,firebaseToken: String?
    let gender, phone, smsCode, apiToken: String
    let  password: String
    var email,phone2,title:String?
    
    let active, specializationID: Int
    var degreeID:Int? 
    
    let cv: String
    var cv2: String?
    let photo: String
    var reservationRate, degreeRate: Int?
    let createdAt, updatedAt: String
    let isHospital: Int
    var doctorDescription: String?
    let isMedicalCenter: Int
    var insuranceCompany: [InsurcaneCompanyModel]?
    
    enum CodingKeys: String, CodingKey {
        case id, name,phone2,title
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
        case doctorDescription = "description"
        case isMedicalCenter = "is_medical_center"
        case insuranceCompany = "insurance_company"
    }
}

struct GetClinicModel:Codable {
    let id: Int
    let photo, phone, fees, fees2: String
    let city, area, lang, latt: String
    let waitingTime, active, availability, doctorID: Int
    let availableDays: Int
    let createdAt, updatedAt: String
    var availabilityDate: String?
    let doctor: DoctorModel
    let freeDays: [FreeDayModel]
    
    enum CodingKeys: String, CodingKey {
        case id, photo, phone, fees, fees2, city, area, lang, latt
        case waitingTime = "waiting_time"
        case active, availability
        case doctorID = "doctor_id"
        case availableDays = "available_days"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case availabilityDate = "availability_date"
        case doctor
        case freeDays = "free_days"
    }
}
