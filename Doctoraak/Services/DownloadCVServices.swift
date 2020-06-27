//
//  DownloadCVServices.swift
//  Doctoraak
//
//  Created by hosam on 6/27/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DownloadCVServices {
    static let shared=DownloadCVServices()
    
     func loadAndDownloadCVFile(url: URL, completion: @escaping (String?,Error?) -> ()) {
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
           let sessionConfig = URLSessionConfiguration.default
           let session = URLSession(configuration: sessionConfig)
           let request = try! URLRequest(url: url, method: .get)

           let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
               if let tempLocalUrl = tempLocalUrl, error == nil {
                   // Success
                   if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                       print("Success: \(statusCode)")
                   }

                   do {
                       try FileManager.default.copyItem(at: tempLocalUrl, to: destinationUrl)
                    
                    completion(destinationUrl.path,nil)
                   } catch (let writeError) {
                    completion(nil,writeError)
                       print("error writing file \(destinationUrl) : \(writeError)")
                   }

               } else {
                completion(nil,error)
                   print("Failure: %@", error?.localizedDescription);
               }
           }
           task.resume()
       }
}
