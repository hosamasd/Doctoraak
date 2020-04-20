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
    
    func registerDoctor(isInsurance:Bool,coverImage:UIImage,cvName:String,cvFile:Data,name:String,email:String,phone:String,password:String,gender:String,specialization_id:Int,degree_id:Int,insurance:[Int] ,completion: @escaping (MainDoctorRegisterModel?, Error?) -> Void ) {
        let urlString = "https://doctoraak.sphinxat.us/public/api/doctor_register"
        
        let postString = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&gender=\(gender)&specialization_id=\(specialization_id)&degree_id=\(degree_id)"//insurance if not empty
        
        
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
    
    //    func loginUser(phone:String,password:String,completion:@escaping (BaseUserSecondModel?,Error?)->Void)  {
    //           let urlString = "http://aqarzelo.com/public/api/user/login".toSecrueHttps()
    //           guard  let url = URL(string: urlString) else { return  }
    //           let postString = "phone=\(phone)&password=\(password)"
    //           RegistrationServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    //       }
    //
    //       func forgetPassword(phone:String,completion:@escaping (BaseUserSecondModel?,Error?)->Void)  { ////baseusermodel
    //           let urlString = "http://aqarzelo.com/public/api/user/forget-password".toSecrueHttps()
    //           guard  let url = URL(string: urlString) else { return  }
    //           let postString = "phone=\(phone)"
    //           RegistrationServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    //       }
    //
    //       func receiveSmsCode(phone:String,code:String,api_Token:String,password:String,completion:@escaping (BaseUserSecondModel?,Error?)->Void)  {
    //           let urlString = "http://aqarzelo.com/public/api/user/reset-password".toSecrueHttps()
    //           guard  let url = URL(string: urlString) else { return  }
    //
    //           let postString = "phone=\(phone)&password=\(password)&api_token=\(api_Token)&sms_code=\(code)"
    //           RegistrationServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    //       }
}
