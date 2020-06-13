//
//  MainClinicGetDoctorsModel.swift
//  Doctoraak
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainClinicGetDoctorsModel:Codable {
    
    let status: Int
    var message, messageEn: String?
    var data: [ClinicGetDoctorsModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct ClinicGetDoctorsModel:Codable {
    
    
    
    
    
    let id: Int
    let photo, phone, fees, fees2: String
    let city, area, lang, latt: String
    let waitingTime, active, availability, doctorID: Int
    let availableDays: Int
    let createdAt, updatedAt: String
    var availabilityDate: String?
    let workingHours: [ClinicWorkingHourModel]
    var degree, specialization: ClinicDegreeModel?
    let freeDays: [ClinicFreeDayModel]
    let doctor: ClinicDoctorLoginModel
    
    enum CodingKeys: String, CodingKey {
        case id, photo, phone, fees, fees2, city, area, lang, latt
        case waitingTime = "waiting_time"
        case active, availability
        case doctorID = "doctor_id"
        case availableDays = "available_days"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case availabilityDate = "availability_date"
        case workingHours = "working_hours"
        case degree, specialization
        case freeDays = "free_days"
        case doctor
    }
}

struct ClinicDoctorLoginModel:Codable {
    
    let id: Int
    let name: String
    var nameAr, nameFr: String?
    let gender, phone, smsCode, apiToken: String
    let firebaseToken, email, password: String
    let active, specializationID: Int
    let cv: String
    let cv2: String
    let photo: String
    var reservationRate, degreeRate: Int?
    let createdAt, updatedAt: String
    let isHospital: Int
    var doctorDescription: String?
    let isMedicalCenter, rate: Int
    let insuranceCompany: [ClinicDegreeModel]
    var degree, specialization: ClinicDegreeModel?
    var degreeID:Int? 
    
    
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

struct ClinicDegreeModel:Codable {
    let id: Int
    let name: Name
    let nameAr: NameAr
    let nameFr: Name
    let createdAt: String?
    let updatedAt: String?
    //       let createdAt: CreatedAt?
    //       let updatedAt: UpdatedAt?
    let photo: Photo?
    let url: String?
    let icon: Icon?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case photo, url, icon
    }
}

struct ClinicFreeDayModel: Codable {
    let date: String
    let partID: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case partID = "part_id"
    }
}


//enum CreatedAt: String, Codable {
//    case the20191122111137 = "2019-11-22 11:11:37"
//    case the20191204102000 = "2019-12-04 10:20:00"
//    case the20191204103325 = "2019-12-04 10:33:25"
//}

enum Icon: String, Codable {
    case the157719941458396PNG = "157719941458396.png"
}

enum Name: String, Codable {
    case chest = "Chest"
    case gff = "Gff"
    case insurance3 = "insurance3"
    case insurance4 = "insurance4"
    case insurance5 = "insurance5"
    case master = "master"
    case ngff = "Ngff"
    case oncareMedical = "oncare medical"
}

enum NameAr: String, Codable {
    case hgf = "Hgf"
    case insurance3 = "insurance3"
    case insurance4 = "insurance4"
    case insurance5 = "insurance5"
    case oncareMedical = "oncare medical"
    case طبيبصدر = "طبيب صدر"
    case ماجستير = "ماجستير"
}

enum Photo: String, Codable {
    case insurancePNG = "insurance.png"
    case the157442109712072JPEG = "157442109712072.jpeg"
    case the157786933146609PNG = "157786933146609.png"
}

enum UpdatedAt: String, Codable {
    case the20191122111137 = "2019-11-22 11:11:37"
    case the20191204103325 = "2019-12-04 10:33:25"
    case the20191224145654 = "2019-12-24 14:56:54"
    case the20200101090211 = "2020-01-01 09:02:11"
}


struct ClinicWorkingHourModel:Codable {
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
