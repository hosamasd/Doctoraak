//
//  DoctorServices.swift
//  Doctoraak
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import Alamofire

class DoctorServices {
    
    static let shared = DoctorServices()
    
    
    func getDocotrsClinic(api_token:String,doctor_id:Int,completion:@escaping (MainClinicGetDoctorsModel?,Error?)->Void)  {
        let urlString = "\(baseUrl)clinic/get/doctor?api_token=\(api_token)&doctor_id=\(doctor_id)".toSecrueHttps()
        
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func updateClinic(clinic_id:Int,fees2:Int,fees:Int,lang:Double,latt:Double,phone:String,photo:UIImage?,city:Int,area:Int,api_token:String,waiting_time:Int,working_Hours:[WorkModel]?,doctor_id:Int,completion:@escaping (MainDoctorClinicCreateModel?,Error?)->Void)  {
        let urlString = "\(baseUrl)update_clinic".toSecrueHttps()
        
        let postString = "fees=\(fees)&lang=\(lang)&latt=\(latt)&phone=\(phone)&city=\(city)&area=\(area)&api_token=\(api_token)&doctor_id=\(doctor_id)&fees2=\(fees2)&waiting_time=\(waiting_time)&clinic_id=\(clinic_id)"
        
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString,photo: photo,clinicWork: working_Hours, completion: completion)
    }
    
    
    
    func updateClinicWorkingHours(working_hours:[WorkModel],api_token:String,clinic_id:Int,doctor_id:Int,completion:@escaping (MainDoctorClinicCreateModel?,Error?)->Void)  {
        let urlString = "\(baseUrl)doctor_update_clinic".toSecrueHttps()

        let postString = "clinic_id=\(clinic_id)&api_token=\(api_token)&doctor_id=\(doctor_id)"
        
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString,clinicWork: working_hours, completion: completion)
        
               
        
    }
    
    func rejectClinicOrderDoctorOfToday(doctor_id:Int,api_token:String,clinic_id:Int,completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
        let urlString = "\(baseUrl)clinic/availability?api_token=\(api_token)&clinic_id=\(clinic_id)&doctor_id=\(doctor_id)".toSecrueHttps()
        
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getDocotrsPatientsInClinic(clinic_id:Int,api_token:String,doctor_id:Int,completion:@escaping (MainDoctorGetPatientsFromClinicModel?,Error?)->Void)  {
        let urlString = "\(baseUrl)clinic/order/get?api_token=\(api_token)&doctor_id=\(doctor_id)&clinic_id=\(clinic_id)".toSecrueHttps()
        
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func updateDoctorProfile(user_id:Int,api_token:String,name:String,completion:@escaping (MainDoctorLoginModel?,Error?)->Void)  {
        let nnn = "doctor_update_profile"
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "api_token=\(api_token)&user_id=\(user_id)&name=\(name)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func rejectClinicOrder(user_id:Int,api_token:String,doctor_id:Int,completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
        let nnn = "clinic/order/reject"
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "api_token=\(api_token)&order_id=\(user_id)&doctor_id=\(doctor_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
    func makeMainPostGenericUsingAlmofireWorkingHours<T:Codable>(urlString:String,postStrings:String,cvcs:Data? = nil,cvName:String? = nil,photo:UIImage? = nil,working_hours:[PharamacyWorkModel]? = nil,clinicWork:[WorkModel]? = nil,completion:@escaping (T?,Error?)->Void)  {
        
        
        guard let urlsString = postStrings.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
        let ddd = urlString+"?"+urlsString
        
        //
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let data = photo?.pngData() {
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
