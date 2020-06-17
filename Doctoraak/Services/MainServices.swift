//
//  MainServices.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import Alamofire

let baseUrl = "http://doctoraak.com/public/api/"


class MainServices {
    static let shared = MainServices()
    func getDegrees(completion: @escaping (MainDegreeModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_degree"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getSpecificationss(completion: @escaping (MainSpecificationModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_specialization"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getCitiess(completion: @escaping (MainCityModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_city"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getAreas(completion: @escaping (MainAreaModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_area"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getInsuracness(completion: @escaping (MainInsurcaneModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_insurance"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getMedicineTypes(completion: @escaping (MainMedicineTypeModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_medicines_type"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getMedicines(completion: @escaping (MainMedicineModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_medicines"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    //    func getRays(completion: @escaping (MainRaysModel?, Error?) -> ())  {
    //        let urlString = baseUrl+"show_rays"
    //        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    //    }
    
    func getPharamacysName(completion: @escaping (MainPharamacyNameModel?, Error?) -> ())  {
        let urlString = baseUrl+"show/pharmacy"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getspecialization(completion: @escaping (MainNotificationsModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_specialization"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getLabs(completion: @escaping (MainGetLabModel?, Error?) -> ())  {
        let urlString = baseUrl+"show/lab"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getRadiologys(completion: @escaping (MainGetRadiologyModel?, Error?) -> ())  {
        let urlString = baseUrl+"show/radiology"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getAnaylsisLabs(completion: @escaping (MainLABAanalysisModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_anlysis"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getAnaylsisRadiologys(completion: @escaping (MainRadiologyAanalysisModel?, Error?) -> ())  {
        let urlString = baseUrl+"show_rays"
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    static func mainGetMethodGenerics<T:Codable>(urlString:String,completion:@escaping (T?,Error?)->Void)  {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, err)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
    
    static func registerationPostMethodGeneric<T:Codable>(postString:String,url:URL,completion:@escaping (T?,Error?)->Void)  {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let error = err {
                completion(nil,error)
            }
            guard let data = data else {return}
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                // success
                completion(objects,nil)
            } catch let error {
                completion(nil,error)
            }
        }.resume()
    }
    
    func makeMainPostGenericUsingAlmofire<T:Codable>(urlString:String,postStrings:String,cvcs:Data? = nil,cvName:String? = nil,photo:UIImage,working_hours:[PharamacyWorkModel]? = nil,clinicWork:[WorkModel]? = nil,completion:@escaping (T?,Error?)->Void)  {
        
        
        guard let urlsString = postStrings.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
        let ddd = urlString+"?"+urlsString
        
        //
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let data = photo.pngData() {
                multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
            }
            
            if  cvcs != nil && cvName != nil {
                if let cvFile = cvcs,let cvName = cvName {
                    
                    multipartFormData.append(cvFile, withName: "cv", fileName: cvName, mimeType:"application/pdf")
                }
            }
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(working_hours)
            if working_hours?.isEmpty != nil {
                
                multipartFormData.append(jsonData ?? Data(), withName: "working_hours")
            }
            let jsonsEncoder = JSONEncoder()
            let jsonsData = try? jsonsEncoder.encode(clinicWork)
            if clinicWork?.isEmpty != nil {
                multipartFormData.append(jsonsData ?? Data(), withName: "working_hours")
            }
        }, to:ddd)//urlsString)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                    print(progress)
                })
                
                upload.responseJSON { response in
                    //print response.result
                    print(response.result)
                    guard let data = response.data else {return}
                    
                    do {
                        let objects = try JSONDecoder().decode(T.self, from: data)
                        // success
                        completion(objects,nil)
                    } catch let error {
                        completion(nil,error)
                    }
                }
                
            case .failure( let encodingError):
                completion(nil,encodingError)
                break
                //print encodingError.description
            }
        }
    }
}
