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
    
    func mainAllRegister(index:Int,photo:UIImage,name:String,email:String,phone:String,password:String,insurance:[Int],working_hours:[Any] ,latt:Double,lang:Double,city:Int,area:Int,completion: @escaping (MainLabRegisterModel?, Error?) -> Void)  {
        let nn = index == 2 ? "lab_register" : index == 3 ? "radiology_register" : "pharmacy_register"
        
        let urlString = baseUrl+nn.toSecrueHttps()
        let postString = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&lang=\(lang)&latt=\(latt)&working_hours=\(working_hours)&insurance=\(insurance)&city=\(city)&area=\(area)"
    }
    
    func mainRegister(index:Int,photo:UIImage,name:String,email:String,phone:String,password:String,insurance:[Int],delivery:Int,working_hours:[SecondWorkModel] ,latt:String,lang:String,city:Int,area:Int,completion: @escaping (MainLabRegisterModel?, Error?) -> Void)  {
        let nn = index == 2 ? "lab_register" : index == 3 ? "radiology_register" : "pharmacy_register"
        
        let urlString = baseUrl+"\(nn)".toSecrueHttps()
        let postString = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&lang=\(lang)&latt=\(latt)&insurance=\(insurance)&city=\(city)&area=\(area)&delivery=\(delivery)"
        let urlsString = postString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = photo.pngData() {
                multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
            }
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(working_hours)
            multipartFormData.append(jsonData ?? Data(), withName: "working_hours")
            
            
        }, to:urlsString!)
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
                        let objects = try JSONDecoder().decode(MainLabRegisterModel.self, from: data)
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
    
    func registerDoctor(index:Int,isInsurance:Bool,coverImage:UIImage,cvName:String,cvFile:Data,name:String,email:String,phone:String,password:String,gender:String,specialization_id:Int,degree_id:Int,insurance:[Int] ,completion: @escaping (MainDoctorRegisterModel?, Error?) -> Void ) {
        let urlString = baseUrl+"doctor_register".toSecrueHttps()
        
        let basics = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&gender=\(gender)&specialization_id=\(specialization_id)&degree_id=\(degree_id)&is_medical_center=\(index)"
        
        let postString = !isInsurance ?  basics : basics+"&insurance=\(insurance)" //insurance if not empty
        let urlsString = postString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = coverImage.pngData() {
                multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
            }
            
            multipartFormData.append(cvFile, withName: "cv", fileName: cvName, mimeType:"application/pdf")
        }, to:urlsString as! URLConvertible)
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
    
    
    func RegiasterClinicCreate(fees2:Int,fees:Int,lang:String,latt:String,phone:String,photo:UIImage,city:Int,area:Int,api_token:String,waiting_time:Int,doctor_id:Int,working_hours:[WorkModel],completion:@escaping (MainDoctorClinicCreateModel?,Error?)->Void)  {
        let urlString = baseUrl+"doctor_create_clinic".toSecrueHttps()
        
        let postString = urlString+"?fees=\(fees)&lang=\(lang)&latt=\(latt)&phone=\(phone)&city=\(city)&area=\(area)&api_token=\(api_token)&doctor_id=\(doctor_id)&fees2=\(fees2)&waiting_time=\(waiting_time)"
        
        let urlsString = postString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = photo.pngData() {
                multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
            }
            let jsonEncoder = JSONEncoder()
                       let jsonData = try? jsonEncoder.encode(working_hours)
                       multipartFormData.append(jsonData ?? Data(), withName: "working_hours")
        }, to:urlsString!)
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
                        let objects = try JSONDecoder().decode(MainDoctorClinicCreateModel.self, from: data)
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
    
    
    
    //replace model
    
   
    
    //
    func LabForgetPassword(phone:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void)  { ////baseusermodel
        let nnn = "lab_forget_password"
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func PharamacyForgetPassword(phone:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void)  { ////baseusermodel
           let nnn = "pharmacy_forget_password"
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           let postString = "phone=\(phone)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
    
    func RdiologyForgetPassword(phone:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void)  { ////baseusermodel
              let nnn = "radiology_forget_password"
              let urlString = baseUrl+nnn.toSecrueHttps()
              guard  let url = URL(string: urlString) else { return  }
              let postString = "phone=\(phone)"
              MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
          }
    
    
    func MainUpdateWithoutSMSPassword(index:Int,phone:String,old_password:String,new_password:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void) {
        let nnn = index == 0 || index == 1 ? "doctor_verify_account" : index == 2 ? "lab_verify_account" : index == 3 ? "radiology_verify_account" : "pharmacy_verify_account"
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&old_password=\(old_password)&new_password=\(new_password)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
    func MainUpdateUsingSMSPassword(index:Int,phone:String,old_password:String,new_password:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void) {
        let nnn = index == 0 || index == 1 ? "doctor_verify_account" : index == 2 ? "lab_verify_account" : index == 3 ? "radiology_verify_account" : "pharmacy_verify_account"
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&old_password=\(old_password)&new_password=\(new_password)" // old_password is smscode
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainReceiveSmsCode(index:Int,user_id:Int,sms_code:String,completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
        let nnn = index == 0 || index == 1 ? "doctor_verify_account" : index == 2 ? "lab_verify_account" : index == 3 ? "radiology_verify_account" : "pharmacy_verify_account"
        
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        
        let postString = "user_id=\(user_id)&sms_code=\(sms_code)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainResendSmsCodeAgain(index:Int,user_id:Int,completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
        let nnn = index == 0 || index == 1 ? "doctor_resend" : index == 2 ? "lab_resend" : index == 3 ? "radiology_resend" : "pharmacy_resend"
        
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        
        let postString = "user_id=\(user_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
    func updateDoctorProfile(user_id:Int,api_token:String,name:String,completion:@escaping (MainDoctorLoginModel?,Error?)->Void)  {
        let nnn = "doctor_update_profile"
                  let urlString = baseUrl+nnn.toSecrueHttps()
                  guard  let url = URL(string: urlString) else { return  }
                  let postString = "api_token=\(api_token)&user_id=\(user_id)&name=\(name)"
                  MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
}
