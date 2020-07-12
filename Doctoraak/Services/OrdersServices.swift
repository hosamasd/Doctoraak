//
//  OrdersServices.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class OrdersServices {
    static let shared = OrdersServices()
    
    func fetchPharmacyOrders(api_token:String,pharmacy_id:Int,completion: @escaping (MainPharmacyGetOrdersModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)pharmacy/order/get".toSecrueHttps()
        let postString = urlString+"?api_token=\(api_token)&pharmacy_id=\(pharmacy_id)"
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
    }
    
    func fetchLABOrders(api_token:String,lab_id:Int,completion: @escaping (MainLABGetOrdersModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)lab/order/get".toSecrueHttps()
        let postString = urlString+"?api_token=\(api_token)&lab_id=\(lab_id)"
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
    }
    
    func fetchRADOrders(api_token:String,radiology_id:Int,completion: @escaping (MainRadGetOrdersModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)radiology/order/get".toSecrueHttps()
        let postString = urlString+"?api_token=\(api_token)&radiology_id=\(radiology_id)"
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
    }
    
    func acceptDoctorOrders(api_token:String,pharmacy_id:Int,order_id:Int,completion: @escaping (MainAddFavoriteModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)pharmacy/accept/order".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "api_token=\(api_token)&order_id=\(order_id)&pharmacy_id=\(pharmacy_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func acceptPharmacyOrders(api_token:String,pharmacy_id:Int,order_id:Int,completion: @escaping (MainAddFavoriteModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)pharmacy/accept/order".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "api_token=\(api_token)&order_id=\(order_id)&pharmacy_id=\(pharmacy_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func acceptRADORLABOrders(message:String? = nil,isAccept:Bool,index:Int,api_token:String,user_id:Int,order_id:Int,completion: @escaping (MainAddFavoriteModel?, Error?) ->Void)  {
        let acc = isAccept ? "accept" : "cancel"
        
        let urlString = "\(baseUrl)\(acc)-order".toSecrueHttps()
        let user_type = index == 2 ? "LAB" : "RADIOLOGY"
        
        guard  let url = URL(string: urlString) else { return  }
        let postString = message == nil ? "api_token=\(api_token)&user_id=\(user_id)&order_id=\(order_id)&user_type=\(user_type)" :  "api_token=\(api_token)&user_id=\(user_id)&order_id=\(order_id)&user_type=\(user_type)&message=\(message!)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
//    func acceptRADORLABOrders(isAccept:Bool,index:Int,api_token:String,user_id:Int,order_id:Int,completion: @escaping (MainAddFavoriteModel?, Error?) ->Void)  {
//           let acc = isAccept ? "accept" : "cancel"
//
//           let urlString = "\(baseUrl)accept-order".toSecrueHttps()
//           let user_type = index == 2 ? "LAB" : "RADIOLOGY"
//
//           guard  let url = URL(string: urlString) else { return  }
//           let postString = "api_token=\(api_token)&user_id=\(user_id)&order_id=\(order_id)&user_type=\(user_type)"
//           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
//       }
    
    func cancelRADORLABOrders(message:String,index:Int,api_token:String,user_id:Int,order_id:Int,completion: @escaping (MainAddFavoriteModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)cancel-order".toSecrueHttps()
        let user_type = index == 2 ? "LAB" : "RADIOLOGY"
        
        guard  let url = URL(string: urlString) else { return  }
        let postString = "api_token=\(api_token)&order_id=\(order_id)&user_id=\(user_id)&user_type=\(user_type)&message=\(message)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    
}
