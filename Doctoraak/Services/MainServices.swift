//
//  MainServices.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MainServices {
    static let shared = MainServices()
    
    func getDegrees(completion: @escaping (MainDegreeModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_degree"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getSpecificationss(completion: @escaping (MainSpecificationModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_specialization"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getCitiess(completion: @escaping (MainCityModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_city"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getAreas(completion: @escaping (MainAreaModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_area"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getInsuracness(completion: @escaping (MainInsurcaneModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_insurance"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getMedicineTypes(completion: @escaping (MainMedicineTypeModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_medicines_type"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getMedicines(completion: @escaping (MainMedicineModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_medicines"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getRays(completion: @escaping (MainRaysModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_rays"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    func getNotifications(completion: @escaping (MainNotificationsModel?, Error?) -> ())  {
        let urlString = "https://doctoraak.sphinxat.us/public/api/show_specialization"
        MainServices.mainGetMethodGenerics(urlString: urlString, completion: completion)
    }
    
    static func mainGetMethodGenerics<T:Codable>(urlString:String,completion:@escaping (T?,Error?)->Void)  {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, err)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
}
