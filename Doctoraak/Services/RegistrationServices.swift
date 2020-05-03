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
    
    func mainAllRegister(index:Int,photo:UIImage,name:String,email:String,phone:String,password:String,insurance:[Int],working_hours:[Any] ,latt:Double,lang:Double,city:Int,area:Int,completion: @escaping (MainRegisterAllModel?, Error?) -> Void)  {
        let nn = index == 2 ? "lab_register" : index == 3 ? "radiology_register" : "pharmacy_register"
        
        let urlString = baseUrl+nn.toSecrueHttps()
        let postString = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&lang=\(lang)&latt=\(latt)&working_hours=\(working_hours)&insurance=\(insurance)&city=\(city)&area=\(area)"
    }
    
    func mainRegister(index:Int,photo:UIImage,name:String,email:String,phone:String,password:String,insurance:[Int],delivery:Int,working_hours:[SecondWorkModel] ,latt:String,lang:String,city:Int,area:Int,completion: @escaping (MainRegisterAllModel?, Error?) -> Void)  {
        let nn = index == 2 ? "lab_register" : index == 3 ? "radiology_register" : "pharmacy_register"
        
        let urlString = "http://doctoraak.sphinxatapps.com/public/api/\(nn)".toSecrueHttps()
        let postString = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&lang=\(lang)&latt=\(latt)&insurance=\(insurance)&city=\(city)&area=\(area)&working_hours=\(working_hours)&delivery=\(delivery)"
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
                        let objects = try JSONDecoder().decode(MainRegisterAllModel.self, from: data)
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
    
    //    func RegiasterClinicCreate(fees2:Int,fees:Int,lang:String,latt:String,phone:String,waiting_time:String,photo:UIImage,city:Int,area:Int,api_token:String,doctor_id:Int,working_hours:[Any],completion:@escaping (MainDoctorClinicCreateModel?,Error?)->Void)  {
    //           let urlString = "http://doctoraak.sphinxatapps.com/public/api/doctor_create_clinic".toSecrueHttps()
    //
    //      let  signUpDict : [String:Any] =
    //            [
    //                "fees":fees,
    //                "fees2":fees2,
    //                "lang":lang,
    //                "latt":latt,
    //                "phone":phone,
    //                "waiting_time":waiting_time,
    //                "city":city,
    //                "area":area,
    //                "api_token":api_token,
    //                "doctor_id":doctor_id,
    ////                "photo":photo,
    //                "working_hours":working_hours
    //        ]
    //        let jsonData = try? JSONSerialization.data(withJSONObject: signUpDict)
    //        var request = URLRequest(url: URL(string: urlString)!)
    //        request.httpMethod = "POST"
    //        request.httpBody = jsonData
    //
    //        URLSession.shared.dataTask(with: request) { (data, resp, err) in
    //                   if let err = err {
    //                       completion(nil, err)
    //                       return
    //                   }
    //                   do {
    //                       let objects = try JSONDecoder().decode(MainDoctorClinicCreateModel.self, from: data!)
    //                       // success
    //                       completion(objects, err)
    //                   } catch let error {
    //                       completion(nil, error)
    //                   }
    //               }.resume()
    //
    ////        URLSession.shared.dataTask(with: request) { data, response, error in
    ////            guard let data = data, error == nil else {
    ////                print(error?.localizedDescription ?? "No data")
    ////                return
    ////            }
    ////            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
    ////            if let responseJSON = responseJSON as? [String: Any] {
    ////                print(responseJSON)
    ////            }
    ////        }.resume()
    //
    ////           let postString = urlString+"?fees=\(fees)&lang=\(lang)&latt=\(latt)&phone=\(phone)&waiting_time=\(waiting_time)&city=\(city)&area=\(area)&api_token=\(api_token)&doctor_id=\(doctor_id)&working_hours=\(working_hours)&fees2=\(fees2)"
    ////
    ////           let urlsString = postString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    //
    //
    //    }
    
    
    func RegiasterClinicCreate(fees2:Int,fees:Int,lang:String,latt:String,phone:String,waiting_time:String,photo:UIImage,city:Int,area:Int,api_token:String,doctor_id:Int,working_hours:[Any],completion:@escaping (MainDoctorClinicCreateModel?,Error?)->Void)  {
        let urlString = baseUrl+"doctor_create_clinic".toSecrueHttps()
        
        let postString = urlString+"?fees=\(fees)&lang=\(lang)&latt=\(latt)&phone=\(phone)&waiting_time=\(waiting_time)&city=\(city)&area=\(area)&api_token=\(api_token)&doctor_id=\(doctor_id)&working_hours=\(working_hours)&fees2=\(fees2)"
        
        let urlsString = postString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = photo.pngData() {
                multipartFormData.append(data, withName: "photo", fileName: "asd.jpeg", mimeType: "image/jpeg")
            }
            
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
    
    
    
    //        guard let url = URL(string: urlString) else { return  }
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //        let signUpDict : [String:Any] =
    //            [
    //                "fees":fees,
    //                "lang":lang,
    //                "latt":latt,
    //                "phone":phone,
    //                "waiting_time":waiting_time,
    //                "city":city,
    //                "area":area,
    //                "api_token":api_token,
    //                "doctor_id":doctor_id,
    //                "photo":photo,
    //                "working_hours":working_hours
    //        ]
    //        request.httpBody = try! JSONSerialization.data(withJSONObject: signUpDict)
    //        Alamofire.request(request)
    //            .responseJSON { response in
    //                // do whatever you want here
    //
    //
    //
    //                switch response.result {
    //                case .failure(let error):
    //                    print(error)
    //
    //                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
    //                        print(responseString)
    //                    }
    //                case .success(let responseObject):
    //                    print(responseObject)
    //                }
    //        }
    
    
    
    
    //replace model
    
    func DoctorLoginUser(index:Int,phone:String,password:String,completion:@escaping (MainDoctorLoginModel?,Error?)->Void)  {
        let nnn = "doctor_login"
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&password=\(password)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainLoginUser(index:Int,phone:String,password:String,completion:@escaping (MainLoginAllModel?,Error?)->Void)  {
        let nnn = index == 0 || index == 1 ? "doctor_login" : index == 2 ? "lab_login" : index == 3 ? "radiology_login" : "pharmacy_login"
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&password=\(password)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    //
    func MainForgetPassword(index:Int,phone:String,completion:@escaping (MainDoctorRegisterModel?,Error?)->Void)  { ////baseusermodel
        let nnn = index == 0 || index == 1 ? "doctor_forget_password" : index == 2 ? "lab_forget_password" : index == 3 ? "radiology_forget_password" : "pharmacy_forget_password"
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
    
    
    
}
