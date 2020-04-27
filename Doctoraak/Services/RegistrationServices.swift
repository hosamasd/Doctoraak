//
//  RegistrationServices.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationServices {
    
    static let shared = RegistrationServices()
    
    func mainRegister(index:Int,photo:UIImage,cvName:String,name:String,email:String,phone:String,password:String,insurance:[Int],delivery:Int,avaliable_days:[Int] ,latt:Double,lang:Double,city:Int,area:Int,completion: @escaping (MainDoctorRegisterModel?, Error?) -> Void)  {
        let nn = index == 2 ? "lab_register" : index == 3 ? "radiology_register" : "pharmacy_register"
        
        let urlString = "http://doctoraak.sphinxatapps.com/public/api/\(nn)".toSecrueHttps()
        let postString = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&lang=\(lang)&latt=\(latt)&avaliable_days=\(avaliable_days)&insurance=\(insurance)&city=\(city)&area=\(area)"
    }
    
    func registerDoctor(isInsurance:Bool,coverImage:UIImage,cvName:String,cvFile:Data,name:String,email:String,phone:String,password:String,gender:String,specialization_id:Int,degree_id:Int,insurance:[Int] ,completion: @escaping (MainDoctorRegisterModel?, Error?) -> Void ) {
        let urlString = "http://doctoraak.sphinxatapps.com/public/api/doctor_register".toSecrueHttps()
        
        let basics = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&gender=\(gender)&specialization_id=\(specialization_id)&degree_id=\(degree_id)"
        
        let postString = !isInsurance ?  basics : basics+"&insurance=\(insurance)" //insurance if not empty
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = coverImage.pngData() {
                multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
            }
            
            multipartFormData.append(cvFile, withName: "cv", fileName: cvName, mimeType:"application/pdf")
        }, to:postString)
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
                        let objects = try JSONDecoder().decode(MainDoctorRegisterModel.self, from: data)
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
    
    func RegiasterClinicCreate(fees:Int,lang:Double,latt:Double,phone:String,waiting_time:Int,city:Int,area:Int,api_token:String,doctor_id:Int,photo:String,working_hours:[String:Any])  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/doctor_create_clinic"
        guard let url = URL(string: urlString) else { return  }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let signUpDict : [String:Any] =
            [
                "fees":fees,
                "lang":lang,
                "latt":latt,
                "phone":phone,
                "waiting_time":waiting_time,
                "city":city,
                "area":area,
                "api_token":api_token,
                "doctor_id":doctor_id,
                "photo":photo,
                "working_hours":working_hours
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: signUpDict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                }
        }
    }
    
    //replace model
    func MainLoginUser(index:Int,phone:String,password:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void)  {
        let nnn = index == 0 || index == 1 ? "doctor_login" : index == 2 ? "lab_login" : index == 3 ? "radiology_login" : "pharmacy_login"
        let urlString = "http://doctoraak.sphinxatapps.com/public/api/\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&password=\(password)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    //
    func MainForgetPassword(index:Int,phone:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void)  { ////baseusermodel
        let nnn = index == 0 || index == 1 ? "doctor_forget_password" : index == 2 ? "lab_forget_password" : index == 3 ? "radiology_forget_password" : "pharmacy_forget_password"
        let urlString = "http://doctoraak.sphinxatapps.com/public/api/\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
    func MainUpdateWithoutSMSPassword(index:Int,phone:String,old_password:String,new_password:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void) {
        let nnn = index == 0 || index == 1 ? "doctor_verify_account" : index == 2 ? "lab_verify_account" : index == 3 ? "radiology_verify_account" : "pharmacy_verify_account"
        let urlString = "http://doctoraak.sphinxatapps.com/public/api/\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&old_password=\(old_password)&new_password=\(new_password)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
    func MainUpdateUsingSMSPassword(index:Int,phone:String,old_password:String,new_password:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void) {
        let nnn = index == 0 || index == 1 ? "doctor_verify_account" : index == 2 ? "lab_verify_account" : index == 3 ? "radiology_verify_account" : "pharmacy_verify_account"
        let urlString = "http://doctoraak.sphinxatapps.com/public/api/\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&old_password=\(old_password)&new_password=\(new_password)" // old_password is smscode
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainReceiveSmsCode(index:Int,user_id:Int,sms_code:String,completion:@escaping (MainDoctorVerificationModel?,Error?)->Void)  {
        let nnn = index == 0 || index == 1 ? "doctor_verify_account" : index == 2 ? "lab_verify_account" : index == 3 ? "radiology_verify_account" : "pharmacy_verify_account"
        
        let urlString = "http://doctoraak.sphinxatapps.com/public/api/\(nnn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        
        let postString = "user_id=\(user_id)&sms_code=\(sms_code)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
}
