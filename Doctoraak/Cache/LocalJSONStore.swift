//
//  LocalJSONStore.swift
//  Doctoraak
//
//  Created by hosam on 6/13/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit

let cacheDoctorObjectCodabe: LocalJSONStore<DoctorLoginModel> = LocalJSONStore(storageType: .cache, filename: "repos.json")
let cacheMedicalObjectCodabe: LocalJSONStore<DoctorLoginModel> = LocalJSONStore(storageType: .cache, filename: "mc.json")
let cacheLABObjectCodabe: LocalJSONStore<LabLoginModel> = LocalJSONStore(storageType: .cache, filename: "lb.json")
let cachdRADObjectCodabe: LocalJSONStore<RadiologyLoginModel> = LocalJSONStore(storageType: .cache, filename: "rd.json")
let cachdPHARMACYObjectCodabe: LocalJSONStore<PharamacyLoginModel> = LocalJSONStore(storageType: .cache, filename: "ph.json")


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

