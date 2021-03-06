//
//  MedicalSpecificationCategory.swift
//  Doctoraak
//
//  Created by Ahmad Eisa on 3/11/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import Foundation



struct MainSpecificationModel: Codable {
    let status: Int
    let message, messageEn: String
    var data: [SpecificationModel]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}
struct SpecificationModel: Codable {
    let id: Int
    let name, nameAr, nameFr: String
    let icon: String
    let createdAt, updatedAt: String
//    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameFr = "name_fr"
        case icon
        case createdAt = "created_at"
        case updatedAt = "updated_at"
//        case url
    }
}


