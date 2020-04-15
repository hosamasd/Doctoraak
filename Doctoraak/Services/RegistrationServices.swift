//
//  RegistrationServices.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit


class RegistrationServices {
    
    static let shared = RegistrationServices()
    
    func registerDoctor(isInsurance:Bool,name:String,email:String,phone:String,password:String,gender:String,specialization_id:Int,degree_id:Int,insurance:[Int] ) {
            let urlString = "https://doctoraak.sphinxat.us/public/api/doctor_register"
           
        let postString = urlString+"?name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&gender=\(gender)&specialization_id=\(specialization_id)&degree_id=\(degree_id)"//insurance if not empty
               
               
               Alamofire.upload(multipartFormData: { (multipartFormData) in
                 
                       if let data = coverImage?.pngData() {
                           multipartFormData.append(data, withName: "cover", fileName: "asd.jpeg", mimeType: "image/jpeg")
                   }
                    
                           if let second = photoImage?.pngData() {
                               multipartFormData.append(second, withName: "photo", fileName: "dsa.jpeg", mimeType: "image/jpeg")
                           }
                       
                       
                   
                   
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
                               let objects = try JSONDecoder().decode(BaseUserSecondModel.self, from: data)
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
