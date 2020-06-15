//
//  MainDOCTORNotificationModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainDOCTORNotificationModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [DOCTORNotificationModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct DOCTORNotificationModel:Codable {
    let id, userID: Int
    let orderID: String?
    let userType: String
    let messageAr, messageEn: String
    let titleEn: String
    let icon: String
    let titleAr: String
    let sent, seen: Int
    let createdAt, updatedAt: String
    var orderType: String?
    let order: DoctorOrderModel?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case orderID = "order_id"
        case userType = "user_type"
        case messageAr = "message_ar"
        case messageEn = "message_en"
        case titleEn = "title_en"
        case icon
        case titleAr = "title_ar"
        case sent, seen
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderType = "order_type"
        case order
    }
}

struct DoctorOrderModel:Codable {
    let id, clinicID, patientID, partID: Int
    let active, reservationNumber: Int
    let type: String
    let notes: String?
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
