//
//  MainLABNotificationModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainLABNotificationModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [LABNotificationModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct LABNotificationModel:Codable {
    let id, userID: Int
       let orderID: String?
       let userType: String
       let messageAr, messageEn, titleEn: String
       let icon: String?
       let titleAr: String
       let sent, seen: Int
       let createdAt, updatedAt: String
       var orderType: String?
       let order: LABOrderModel?

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

struct LABOrderModel:Codable {
    let id, labID, patientID: Int
       var notes: String?
       let photo: String
       var insuranceCode: String?
       let insuranceAccept, createdAt, updatedAt: String
       let accept: Int
       let patient: PatientModel
       let details: [LABDetailModel]

       enum CodingKeys: String, CodingKey {
           case id
           case labID = "lab_id"
           case patientID = "patient_id"
           case notes, photo
           case insuranceCode = "insurance_code"
           case insuranceAccept = "insurance_accept"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case accept, patient, details
       }
}

struct LABDetailModel:Codable {
    let id, labOrder, analysisID: Int
       let createdAt, updatedAt: String
       let analysis: LABInsuranceModel

       enum CodingKeys: String, CodingKey {
           case id
           case labOrder = "lab_order"
           case analysisID = "analysis_id"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case analysis
       }
}

struct LABInsuranceModel:Codable {
    let id: Int
       let name, nameAr, nameFr: String
       let createdAt: String?
       let updatedAt: String
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
