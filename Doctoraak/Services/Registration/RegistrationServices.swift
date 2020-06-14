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
    
    
    func mainLABRegister(photo:UIImage,name:String,email:String,phone:String,password:String,insurance:[Int],delivery:Int,working_hours:[SecondWorkModel] ,latt:Double,lang:Double,city:Int,area:Int,completion: @escaping (MainLabRegisterModel?, Error?) -> Void)  {
        let nn = "lab_register"
        
        let urlString = "\(baseUrl)\(nn)".toSecrueHttps()
        let postString = "name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&lang=\(lang)&latt=\(latt)&insurance=\(insurance)&city=\(city)&area=\(area)&delivery=\(delivery)"
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString, photo: photo,working_hours: working_hours, completion: completion)
        
    }
    
    func mainRADRegister(photo:UIImage,name:String,email:String,phone:String,password:String,insurance:[Int],delivery:Int,working_hours:[SecondWorkModel] ,latt:Double,lang:Double,city:Int,area:Int,completion: @escaping (MainRadiologyRegisterModel?, Error?) -> Void)  {
        let nn = "radiology_register"
        
        let urlString = "\(baseUrl)\(nn)".toSecrueHttps()
        let postString = "name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&lang=\(lang)&latt=\(latt)&insurance=\(insurance)&city=\(city)&area=\(area)&delivery=\(delivery)"
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString, photo: photo,working_hours: working_hours, completion: completion)
        
    }
    
    func mainPHARAMACYRegister(photo:UIImage,name:String,email:String,phone:String,password:String,insurance:[Int],delivery:Int,working_hours:[SecondWorkModel] ,latt:Double,lang:Double,city:Int,area:Int,completion: @escaping (MainPharamcyyRegisterModel?, Error?) -> Void)  {
        let nn =  "pharmacy_register"
        
        let urlString = "\(baseUrl)\(nn)".toSecrueHttps()
        let postString = "name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&lang=\(lang)&latt=\(latt)&insurance=\(insurance)&city=\(city)&area=\(area)&delivery=\(delivery)"
        
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString, photo: photo,working_hours: working_hours, completion: completion)
    }
    
    
    func registerDoctor(index:Int,isInsurance:Bool,coverImage:UIImage,cvName:String,cvFile:Data,name:String,email:String,phone:String,password:String,gender:String,specialization_id:Int,degree_id:Int,insurance:[Int] ,completion: @escaping (MainDoctorRegisterModel?, Error?) -> Void ) {
        let urlString = "\(baseUrl)doctor_register".toSecrueHttps()
        
        let basics = "name=\(name)&email=\(email)&phone=\(phone)&password=\(password)&gender=\(gender)&specialization_id=\(specialization_id)&degree_id=\(degree_id)&is_medical_center=\(index)"
        
        let postString = !isInsurance ?  basics : basics+"&insurance=\(insurance)" //insurance if not empty
        
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString,cvcs: cvFile,cvName: name,photo: coverImage, completion: completion)
    }
    
    
    func RegiasterClinicCreate(fees2:Int,fees:Int,lang:String,latt:String,phone:String,photo:UIImage,city:Int,area:Int,api_token:String,waiting_time:Int,doctor_id:Int,working_hours:[WorkModel],completion:@escaping (MainDoctorClinicCreateModel?,Error?)->Void)  {
        let urlString = "\(baseUrl)doctor_create_clinic".toSecrueHttps()
        
        let postString = "fees=\(fees)&lang=\(lang)&latt=\(latt)&phone=\(phone)&city=\(city)&area=\(area)&api_token=\(api_token)&doctor_id=\(doctor_id)&fees2=\(fees2)&waiting_time=\(waiting_time)"
        
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString,photo: photo,clinicWork: working_hours, completion: completion)
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
    
    func MainDoctorReceiveSmsCode(user_id:Int,sms_code:String,completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
        let nnn = "doctor_verify_account"
        
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        
        let postString = "user_id=\(user_id)&sms_code=\(sms_code)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainLABReceiveSmsCode(user_id:Int,sms_code:String,completion:@escaping (MainLabSMSCodeModel?,Error?)->Void)  {
           let nnn =  "lab_verify_account"
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           
           let postString = "user_id=\(user_id)&sms_code=\(sms_code)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
    
    func MainRADReceiveSmsCode(user_id:Int,sms_code:String,completion:@escaping (MainRadiologySMSCodeModel?,Error?)->Void)  {
           let nnn = "radiology_verify_account"
           
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           
           let postString = "user_id=\(user_id)&sms_code=\(sms_code)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
    
    func MainPHYReceiveSmsCode(user_id:Int,sms_code:String,completion:@escaping (MainPharamacySMSCodeModel?,Error?)->Void)  {
           let nnn = "pharmacy_verify_account"
           
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           
           let postString = "user_id=\(user_id)&sms_code=\(sms_code)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
    
    func MainReceiveSmsCode(index:Int,user_id:Int,sms_code:String,completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
           let nnn = index == 0 || index == 1 ? "doctor_verify_account" : index == 2 ? "lab_verify_account" : index == 3 ? "radiology_verify_account" : "pharmacy_verify_account"
           
           let urlString = baseUrl+nnn.toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           
           let postString = "user_id=\(user_id)&sms_code=\(sms_code)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
    
    func MainResendSmsCodeAgainPHY(user_id:Int,completion:@escaping (MainPharamacySMSCodeModel?,Error?)->Void)  {
        let nnn =  "pharmacy_resend"
        
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        
        let postString = "user_id=\(user_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainResendSmsCodeAgainDOC(user_id:Int,completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
        let nnn =  "doctor_resend"
        
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        
        let postString = "user_id=\(user_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainResendSmsCodeAgainRAD(user_id:Int,completion:@escaping (MainRadiologySMSCodeModel?,Error?)->Void)  {
        let nnn =  "radiology_resend"
        
        let urlString = baseUrl+nnn.toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        
        let postString = "user_id=\(user_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func MainResendSmsCodeAgainLAB(user_id:Int,completion:@escaping (MainLabSMSCodeModel?,Error?)->Void)  {
        let nnn = "lab_resend"
        
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
