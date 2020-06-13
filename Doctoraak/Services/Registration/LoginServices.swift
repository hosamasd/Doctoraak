//
//  LoginServices.swift
//  Doctoraak
//
//  Created by hosam on 6/13/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class LoginServices {
    static let shared = LoginServices()
    
    func DoctorLoginUser(index:Int,phone:String,password:String,completion:@escaping (MainDoctorLoginModel?,Error?)->Void)  {
           let nnn = "doctor_login"
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           let postString = "phone=\(phone)&password=\(password)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
       
       func LabLoginUser(phone:String,password:String,completion:@escaping (MainLabLoginModel?,Error?)->Void)  {
           let nnn = "lab_login"
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           let postString = "phone=\(phone)&password=\(password)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
       
       func PharamacyLoginUser(phone:String,password:String,completion:@escaping (MainPharamacyLoginModel?,Error?)->Void)  {
           let nnn = "pharmacy_login"
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           let postString = "phone=\(phone)&password=\(password)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
       
       func radiologyLoginUser(phone:String,password:String,completion:@escaping (MainRadiologyLoginModel?,Error?)->Void)  {
           let nnn = "radiology_login"
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           let postString = "phone=\(phone)&password=\(password)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
}
