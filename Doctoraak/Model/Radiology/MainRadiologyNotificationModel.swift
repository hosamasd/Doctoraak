//
//  MainRadiologyNotificationModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainRadiologyNotificationModel:Codable {
    let status: Int
       let message, messageEn: String
       var data: [RadiologyNotificationModel]?

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
}

struct RadiologyNotificationModel:Codable {
    let id, userID: Int
      let orderID, userType, messageAr, messageEn: String
      let titleEn, icon, titleAr: String
      let sent, seen: Int
      let createdAt, updatedAt: String
      var orderType: String?
      let order: RadiologyOrderModel?

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

struct RadiologyOrderModel:Codable {
    let id, radiologyID, patientID: Int
       var notes: String?
       let photo: String
       var insuranceCode: String?
       let insuranceAccept, createdAt, updatedAt: String
       let accept: Int
       let patient: PatientModel
       let details: [RADDetailModel]

       enum CodingKeys: String, CodingKey {
           case id
           case radiologyID = "radiology_id"
           case patientID = "patient_id"
           case notes, photo
           case insuranceCode = "insurance_code"
           case insuranceAccept = "insurance_accept"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case accept, patient, details
       }
}

struct RADDetailModel:Codable {
    let id, radiologyOrder, raysID: Int
       let createdAt, updatedAt: String
       let rays: RADInsuranceModel

       enum CodingKeys: String, CodingKey {
           case id
           case radiologyOrder = "radiology_order"
           case raysID = "rays_id"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case rays
       }
}

struct RADInsuranceModel:Codable {
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
