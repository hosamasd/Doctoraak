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
}
