//
//  MainMedicineTypeModel.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainMedicineTypeModel:Codable {
    let status: Int
       let message, messageEn: String
       var data: [MedicineTypeModel]?

       enum CodingKeys: String, CodingKey {
           case status, message
           case messageEn = "message_en"
           case data
       }
    
}

struct MedicineTypeModel:Codable {
    let id: Int
       let name, nameAr, nameFr: String
       var createdAt, updatedAt: String?

       enum CodingKeys: String, CodingKey {
           case id, name
           case nameAr = "name_ar"
           case nameFr = "name_fr"
           case createdAt = "created_at"
           case updatedAt = "updated_at"
       }
}
