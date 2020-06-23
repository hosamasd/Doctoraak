//
//  MainLABGetOrdersModel.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainLABGetOrdersModel:Codable {
    let status: Int
    let message, messageEn: String
    var data: [LABGetOrdersModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct LABGetOrdersModel:Codable {
    let id, labID, patientID: Int
    let notes: String?
    let photo: String
    let insuranceAccept: String
    var insuranceCode: String?
    let createdAt, updatedAt: String
    let pharmacyOrderID: Int
    let accept: String
    let patient: PatientModel
    let details: [RADDetailModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case labID = "lab_id"
        case patientID = "patient_id"
        case notes, photo
        case insuranceAccept = "insurance_accept"
        case insuranceCode = "insurance_code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pharmacyOrderID = "pharmacy_order_id"
        case accept, patient, details
    }
}

struct LABOrderModel:Codable {
    let id, labID, patientID: Int
       var notes: JSONNull?
       let photo: String
       var insuranceCode: JSONNull?
       let insuranceAccept, createdAt, updatedAt: String
       let accept: Int
       let patient: PatientModelNotification
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
