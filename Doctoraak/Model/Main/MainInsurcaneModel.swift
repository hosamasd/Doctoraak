//
//  MainInsurcaneModel.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainInsurcaneModel:Codable {
    let status: Int
    let message, messageEn: String
    let data: [InsurcaneModel]

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
}

struct InsurcaneModel:Codable {
    let id: Int
       let name, photo, nameAr, nameFr: String
       let createdAt, updatedAt: String?
       var url: String?

       enum CodingKeys: String, CodingKey {
           case id, name, photo
           case nameAr = "name_ar"
           case nameFr = "name_fr"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
           case url
       }
}
