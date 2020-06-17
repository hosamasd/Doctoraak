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
        guard  let url = URL(string: urlString) else { return  }
        let postString = urlString+"?api_token=\(api_token)&pharmacy_id=\(pharmacy_id)"
        MainServices.mainGetMethodGenerics(urlString: postString, completion: completion)
    }
    
    func fetchLABOrders(api_token:String,lab_id:Int,completion: @escaping (MainLABGetOrdersModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)pharmacy/order/get".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "api_token=\(api_token)&lab_id=\(lab_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func fetchRADOrders(api_token:String,radiology_id:Int,completion: @escaping (MainRadGetOrdersModel?, Error?) ->Void)  {
        let urlString = "\(baseUrl)pharmacy/order/get".toSecrueHttps()
        guard  let url = URL(string: urlString) else { return  }
        let postString = "api_token=\(api_token)&radiology_id=\(radiology_id)"
        MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    }
    
    func acceptPharmacyOrders(api_token:String,pharmacy_id:Int,order_id:Int,completion: @escaping (MainAddFavoriteModel?, Error?) ->Void)  {
           let urlString = "\(baseUrl)pharmacy/accept/order".toSecrueHttps()
           guard  let url = URL(string: urlString) else { return  }
           let postString = "api_token=\(api_token)&order_id=\(order_id)&pharmacy_id=\(pharmacy_id)"
           MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
       }
    
    //    func fetchDOCOrders(api_token:String,pharmacy_id:Int,completion: @escaping (madogeo?, Error?) ->Void)  {
    //       let urlString = "\(baseUrl)pharmacy/order/get".toSecrueHttps()
    //       guard  let url = URL(string: urlString) else { return  }
    //       let postString = "api_token=\(api_token)&pharmacy_id=\(pharmacy_id)"
    //       MainServices.registerationPostMethodGeneric(postString: postString, url: url, completion: completion)
    //    }
    
}
