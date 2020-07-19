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
    
    func updateClinic(clinic_id:Int,fees2:Int,fees:Int,lang:Double,latt:Double,phone:String,photo:UIImage,city:Int,area:Int,api_token:String,waiting_time:Int,doctor_id:Int,completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
           let urlString = "\(baseUrl)doctor_create_clinic".toSecrueHttps()
           
           let postString = "fees=\(fees)&lang=\(lang)&latt=\(latt)&phone=\(phone)&city=\(city)&area=\(area)&api_token=\(api_token)&doctor_id=\(doctor_id)&fees2=\(fees2)&waiting_time=\(waiting_time)&clinic_id=\(clinic_id)"
           
           MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString,photo: photo, completion: completion)
       }
    
    func rejectClinicOrderDoctorOfToday(api_token:String,clinic_id:Int,completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
        let urlString = "\(baseUrl)clinic/availability?api_token=\(api_token)&clinic_id=\(clinic_id)".toSecrueHttps()
               
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
