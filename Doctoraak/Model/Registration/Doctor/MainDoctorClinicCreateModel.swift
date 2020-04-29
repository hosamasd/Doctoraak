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
    let message, messageEn: String
    let data: DoctorClinicCreateModel
    
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
    let workingHours: [WorkingHoursModel]
    let photo: String
    let degree, specialization: DegreeDoctorModel
    let freeDays: [FreeDayModel]
    let doctor: DoctorModel
    
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

struct FreeDayModel:Codable {
    
    let date: String
    let partID: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case partID = "part_id"
    }
}


struct WorkingHoursModel:Codable {
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
