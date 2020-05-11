//
//  DoctorServices.swift
//  Doctoraak
//
//  Created by hosam on 5/9/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DoctorServices {
    
    static let shared = DoctorServices()
    
    
    func getDocotrsClinic(api_token:String,doctor_id:Int,completion:@escaping (MainClinicGetDoctorsModel?,Error?)->Void)  {
        let urlString = "\(baseUrl)clinic/get/doctor?api_token=\(api_token)&doctor_id=\(doctor_id)".toSecrueHttps()
        
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
}
