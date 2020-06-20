//
//  ProfileServices.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import Alamofire

class ProfileServices {
    static let shared=ProfileServices()
    
    func getNotificationsLAB(api_token:String,user_id:Int,completion: @escaping (MainLABNotificationModel?, Error?) ->Void)  {
        let urlString =  "\(baseUrl)get/notification?api_token=\(api_token)&user_id=\(user_id)&user_type=LAB".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getNotificationsRAD(api_token:String,user_id:Int,completion: @escaping (MainRadiologyNotificationModel?, Error?) ->Void)  {
        let urlString =  "\(baseUrl)get/notification?api_token=\(api_token)&user_id=\(user_id)&user_type=RADIOLOGY".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getNotificationsPHY(api_token:String,user_id:Int,completion: @escaping (MainPharmacyNotificationModel?, Error?) ->Void)  {
        let urlString =  "\(baseUrl)get/notification?api_token=\(api_token)&user_id=\(user_id)&user_type=PHARMACY".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func getNotificationsDOC(api_token:String,user_id:Int,completion: @escaping (MainDOCTORNotificationModel?, Error?) ->Void)  {
        let urlString =  "\(baseUrl)get/notification?api_token=\(api_token)&user_id=\(user_id)&user_type=DOCTOR".toSecrueHttps()
        MainServices.mainGetMethodGenerics(urlString: urlString.toSecrueHttps(), completion: completion)
    }
    
    func removeNotification(notification_id:Int,completion: @escaping (MainRemoveNotificationModel?, Error?) ->Void)  {
        
        let nnn = "notification/remove"
        
        let urlString = baseUrl+nnn
        guard  let url = URL(string: urlString.toSecrueHttps()) else { return  }
        
        let postString = "notification_id=\(notification_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func updatePharamacyProfile(api_token:String,user_id:Int,photo:UIImage,name:String,insurance:[Int],delivery:Int,working_hours:[PharamacyWorkModel]? = nil ,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainPharamacyLoginModel?, Error?) ->Void)  {
        let postString:String
        let nnn =   "pharmacy_update_profile"
        let urlString = baseUrl+nnn
        postString =    latt == nil ? "api_token=\(api_token)&user_id=\(user_id)&name=\(name)&insurance=\(insurance)&delivery=\(delivery)"  :
         "api_token=\(api_token)&user_id=\(user_id)&name=\(name)&lang=\(lang!)&latt=\(latt!)&insurance=\(insurance)&delivery=\(delivery)"
        
        MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString, photo: photo,working_hours: working_hours, completion: completion)
     }
    
    func updateRADProfile(api_token:String,user_id:Int,photo:UIImage,name:String,insurance:[Int],delivery:Int,working_hours:[PharamacyWorkModel]? = nil ,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainRadiologyLoginModel?, Error?) ->Void)  {
           let postString:String
           let nnn =   "radiology_update_profile"
           let urlString = baseUrl+nnn
           postString =    latt == nil ? "api_token=\(api_token)&user_id=\(user_id)&name=\(name)&insurance=\(insurance)&delivery=\(delivery)"  :
            "api_token=\(api_token)&user_id=\(user_id)&name=\(name)&lang=\(lang!)&latt=\(latt!)&insurance=\(insurance)&delivery=\(delivery)"
           
           MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString, photo: photo,working_hours: working_hours, completion: completion)
        }
    
    func updateLABProfile(api_token:String,user_id:Int,photo:UIImage,name:String,insurance:[Int],delivery:Int,working_hours:[PharamacyWorkModel]? = nil ,latt:Double? = nil,lang:Double? = nil,completion: @escaping (MainLabLoginModel?, Error?) ->Void)  {
           let postString:String
           let nnn =   "lab_update_profile"
           let urlString = baseUrl+nnn
           postString =    latt == nil ? "api_token=\(api_token)&user_id=\(user_id)&name=\(name)&insurance=\(insurance)&delivery=\(delivery)"  :
            "api_token=\(api_token)&user_id=\(user_id)&name=\(name)&lang=\(lang!)&latt=\(latt!)&insurance=\(insurance)&delivery=\(delivery)"
           
           MainServices.shared.makeMainPostGenericUsingAlmofire(urlString: urlString, postStrings: postString, photo: photo,working_hours: working_hours, completion: completion)
        }
}
