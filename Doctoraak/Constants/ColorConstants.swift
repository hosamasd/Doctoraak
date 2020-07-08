//
//  ColorConstants.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit


let cachdDOCTORWorkingHourObjectCodabe: LocalJSONStore<[WorkModel]> = LocalJSONStore(storageType: .cache, filename: "docs.json")
let cachdMEDICALCenterWorkingHourObjectCodabe: LocalJSONStore<[WorkModel]> = LocalJSONStore(storageType: .cache, filename: "docsss.json")

let cacheLABObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "lbw.json")
let cachdRADObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "rdw.json")
let cachdPHARMACYObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "phw.json")

class ColorConstants {
    
    static let firstColorBangsegy = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
    static let secondColorBangsegy = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
    
    static let disabledButtonsGray = #colorLiteral(red: 0.7426531911, green: 0.7628864646, blue: 0.8158458471, alpha: 1)
    static let secondColorGray  = #colorLiteral(red: 0.7426531911, green: 0.7628864646, blue: 0.8158458471, alpha: 1).cgColor
    
    
}
