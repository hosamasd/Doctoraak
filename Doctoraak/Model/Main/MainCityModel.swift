//
//  MainCityModel.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

struct MainCityModel:Codable {
    
    let status: Int
    let message, messageEn: String
    var data: [CityModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case messageEn = "message_en"
        case data
    }
    
}

struct CityModel:Codable {
    
    let id: Int
      let name, nameAr, nameFr, createdAt: String
      let updatedAt: String

      enum CodingKeys: String, CodingKey {
          case id, name
          case nameAr = "name_ar"
          case nameFr = "name_fr"
          case createdAt = "created_at"
          case updatedAt = "updated_at"
      }
}
