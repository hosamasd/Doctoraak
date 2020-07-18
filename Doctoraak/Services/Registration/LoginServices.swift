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
    
    func DoctorLoginUser(specId:Int? = nil,index:Int,phone:String,password:String,completion:@escaping (MainDoctorLoginModel?,Error?)->Void)  {
        let nnn = "doctor_login"
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString :String
        postString = index == 1 ? "phone=\(phone)-\(specId!)&password=\(password)" : "phone=\(phone)&password=\(password)"
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
    
    func mainForgetPassword(index:Int,phone:String,completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
        let nn = index == 0 || index == 1 ? "doctor_forget_password" : index == 2 ? "lab_forget_password" : index == 3 ? "radiology_forget_password" : "pharmacy_forget_password"
        
        let urlString = "\(baseUrl)\(nn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func mainUpdatePassword(index:Int,phone:String,old_password:String,new_password:String,completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
        let nn = index == 0 || index == 1 ? "doctor_update_password" : index == 2 ? "lab_update_password" : index == 3 ? "radiology_update_password" : "pharmacy_update_password"
        
        let urlString = "\(baseUrl)\(nn)".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "phone=\(phone)&old_password=\(old_password)&new_password=\(new_password)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
}
