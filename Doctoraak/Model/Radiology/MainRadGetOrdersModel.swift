//
//  MainRadGetOrdersModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainRadGetOrdersModel:Codable {
    let status: Int
         let message, messageEn: String
         var data: [RadGetOrdersModel]?

         enum CodingKeys: String, CodingKey {
             case status, message
             case messageEn = "message_en"
             case data
         }
}

struct RadGetOrdersModel:Codable {
    let id, radiologyID, patientID: Int
       let notes: String?
       let photo: String
       let insuranceAccept: String
       var insuranceCode: String?
       let createdAt, updatedAt: String
//       let pharmacyOrderID: Int
       let accept: AnyType
       let patient: PatientModel
       let details: [RADDetailModel]

       enum CodingKeys: String, CodingKey {
           case id
           case radiologyID = "radiology_id"
           case patientID = "patient_id"
           case notes, photo
           case insuranceAccept = "insurance_accept"
           case insuranceCode = "insurance_code"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
//           case pharmacyOrderID = "pharmacy_order_id"
           case accept, patient, details
       }
}
