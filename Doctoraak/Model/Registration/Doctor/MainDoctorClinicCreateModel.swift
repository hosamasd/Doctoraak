//
//  MainDoctorClinicCreateModel.swift
//  Doctoraak
//
//  Created by hosam on 4/29/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainDoctorClinicCreateModel:Codable {
    
    let status: Int
    var message, messageEn: String?
    var data: DoctorClinicCreateModel?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct DoctorClinicCreateModel:Codable {
    let fees, fees2, lang, latt: String
    let phone, city, area, waitingTime: String
    let doctorID, updatedAt, createdAt: String
    let id: Int
    let workingHours: [DoctorWorkingHoursModel]
    let photo: String
    let degree, specialization: DegreeDoctorModel
    let freeDays: [FreeDayModel]
    let doctor: DoctorSecondModel
    
    enum CodingKeys: String, CodingKey {
        case fees, fees2, lang, latt, phone, city, area
        case waitingTime = "waiting_time"
        case doctorID = "doctor_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case workingHours = "working_hours"
        case photo, degree, specialization
        case freeDays = "free_days"
        case doctor
    }
}

struct DoctorSecondModel:Codable {
    
    let id: Int
    let name: String
    var nameAr, nameFr: String?
    let gender, phone, smsCode, apiToken: String
    var email,firebaseToken: String?
    let  password: String
    let active, specializationID, degreeID: Int
    let cv: String
    let cv2: String
    let photo: String
    var reservationRate, degreeRate: String?
    let createdAt, updatedAt: String
    let isHospital: Int
    var doctorDescription: String?
    let isMedicalCenter, rate: Int
    let insuranceCompany: [DegreeDoctorModel]
    let degree, specialization: DegreeDoctorModel

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
        case doctorDescription = "description"
        case isMedicalCenter = "is_medical_center"
        case rate
        case insuranceCompany = "insurance_company"
        case degree, specialization
    }
}

struct FreeDayModel:Codable {
    
    let date: String
    let partID: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case partID = "part_id"
    }
}


struct LabWorkingHoursModel:Codable {
    
    let id, labID, day: Int
    let partFrom, partTo: String
    let active: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case labID = "lab_id"
        case day
        case partFrom = "part_from"
        case partTo = "part_to"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
//    let id, labID, day: Int
//    let part1From, part1To, part2From, part2To: String
//    let active, reservationNumber1, reservationNumber2: Int
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case day
//        case part1From = "part1_from"
//        case part1To = "part1_to"
//        case part2From = "part2_from"
//        case part2To = "part2_to"
//        case active
//        case reservationNumber1 = "reservation_number_1"
//        case reservationNumber2 = "reservation_number_2"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case labID = "lab_id"
//
//    }
}

struct DoctorWorkingHoursModel:Codable {
    let id, clinicID, day: Int
    let part1From, part1To, part2From, part2To: String
    let active, reservationNumber1, reservationNumber2: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case clinicID = "clinic_id"
        case day
        case part1From = "part1_from"
        case part1To = "part1_to"
        case part2From = "part2_from"
        case part2To = "part2_to"
        case active
        case reservationNumber1 = "reservation_number_1"
        case reservationNumber2 = "reservation_number_2"
        case createdAt = "created_at"
        case updatedAt = "updated_at"

    }
}
