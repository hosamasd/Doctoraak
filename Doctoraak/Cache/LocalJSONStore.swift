//
//  LocalJSONStore.swift
//  Doctoraak
//
//  Created by hosam on 6/13/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit

let cacheSelectedClinicCodabe: LocalJSONStore<ClinicGetDoctorsModel> = LocalJSONStore(storageType: .cache, filename: "sdsssasad.json")

let cacheDoctorObjectCodabe: LocalJSONStore<DoctorModel> = LocalJSONStore(storageType: .cache, filename: "repos.json")
let cacheMedicalObjectCodabe: LocalJSONStore<DoctorModel> = LocalJSONStore(storageType: .cache, filename: "mc.json")
let cacheLABObjectCodabe: LocalJSONStore<LabModel> = LocalJSONStore(storageType: .cache, filename: "lb.json")
let cachdRADObjectCodabe: LocalJSONStore<RadiologyModel> = LocalJSONStore(storageType: .cache, filename: "rd.json")
let cachdPHARMACYObjectCodabe: LocalJSONStore<PharamacyModel> = LocalJSONStore(storageType: .cache, filename: "ph.json")

//for workinghours register
let cachdDOCTORWorkingHourObjectCodabe: LocalJSONStore<[WorkModel]> = LocalJSONStore(storageType: .cache, filename: "docs.json")
let cachdMEDICALCenterWorkingHourObjectCodabe: LocalJSONStore<[WorkModel]> = LocalJSONStore(storageType: .cache, filename: "docsss.json")
let cacheLABObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "lbw.json")
let cachdRADObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "rdw.json")
let cachdPHARMACYObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "phw.json")

let cacheDoctorObjectClinicWorkingHoursLeftMenu: LocalJSONStore<ClinicGetDoctorsModel> = LocalJSONStore(storageType: .cache, filename: "repossss.json")
let cacheMedicalCenterObjectCodabeClinicWorkingHoursLeftMenu: LocalJSONStore<ClinicGetDoctorsModel> = LocalJSONStore(storageType: .cache, filename: "repossss.json")


class LocalJSONStore<T> where T : Codable {
    
    let storageType: StorageType
       let filename: String
       
       init(storageType: StorageType, filename: String) {
           self.storageType = storageType
           self.filename = filename
           ensureFolderExists()
       }
       
       func save(_ object: T) {
           do {
               let data = try JSONEncoder().encode(object)
            
               try data.write(to: fileURL)
           } catch let e {
               print("ERROR: \(e)")
           }
       }
    
    func deleteFile(_ object: T) {
             do {
                    try FileManager.default.removeItem(at: fileURL)
//                try data.
             } catch let e {
                 print("ERROR: \(e)")
             }
         }
       
       var storedValue: T? {
           guard FileManager.default.fileExists(atPath: fileURL.path) else {
               return nil
           }
           do {
               let data = try Data(contentsOf: fileURL)
               let jsonDecoder = JSONDecoder()
               return try jsonDecoder.decode(T.self, from: data)
           } catch let e {
               print("ERROR: \(e)")
               return nil
           }
       }
       
       private var folder: URL {
           return storageType.folder
       }
       
       private var fileURL: URL {
           return folder.appendingPathComponent(filename)
       }
       
       private func ensureFolderExists() {
           let fileManager = FileManager.default
           var isDir: ObjCBool = false
           if fileManager.fileExists(atPath: folder.path, isDirectory: &isDir) {
               if isDir.boolValue {
                   return
               }
               
               try? FileManager.default.removeItem(at: folder)
           }
           try? fileManager.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
       }
}


