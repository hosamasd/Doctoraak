//
//  MainPharmacyNotificationModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainPharmacyNotificationModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [PharmacyNotificationModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct PharmacyNotificationModel:Codable {
    let id, userID: Int
    var orderID: String?
    let userType: String
    let messageAr, messageEn: String
    let titleEn: String
    let icon: String
    let titleAr: String
    let sent, seen: Int
    let createdAt, updatedAt: String
    var orderType: String?
    var order: PharmacyOrderModel?

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

struct PharmacyOrderModel:Codable {
    let id: Int
       var pharmacyID: Int?
       let patientID: Int
       var notes: String?
       let photo: String
       let insuranceAccept: String
       var insuranceCode: String?
       let createdAt, updatedAt: String
       let patient: PatientModel?
       let details: [PharmacyDetailModel]

       enum CodingKeys: String, CodingKey {
           case id
           case pharmacyID = "pharmacy_id"
           case patientID = "patient_id"
           case notes, photo
           case insuranceAccept = "insurance_accept"
           case insuranceCode = "insurance_code"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case patient, details
       }
}

struct PharmacyDetailModel:Codable {
    let id, pharmacyOrder, medicineID, amount: Int
    let medicineTypeID: Int
    let createdAt, updatedAt: String
    let medicine, medicineType: PharmacyMedicineModel

    enum CodingKeys: String, CodingKey {
        case id
        case pharmacyOrder = "pharmacy_order"
        case medicineID = "medicine_id"
        case amount
        case medicineTypeID = "medicine_type_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case medicine
        case medicineType = "medicine_type"
    }
}


struct PharmacyMedicineModel:Codable {
    let id: Int
       let name, nameAr, nameFr: String
       var createdAt: String?
       let updatedAt: UpdatedAt?
       let photo: String?
       let url: String?

       enum CodingKeys: String, CodingKey {
           case id, name
           case nameAr = "name_ar"
           case nameFr = "name_fr"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case photo, url
       }
}
