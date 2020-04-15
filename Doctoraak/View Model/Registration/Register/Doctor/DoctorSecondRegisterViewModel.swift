//
//  DoctorSecondRegisterViewModel.swift
//  Doctoraak
//
//  Created by hosam on 4/7/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DoctorSecondRegisterViewModel {
    
    var bindableIsResgiter = Bindable<Bool>()
       var bindableIsFormValidate = Bindable<Bool>()
       
       //variables
       var specialization:Int? = -1 {didSet {checkFormValidity()}}
       var degree:Int? = -1 {didSet {checkFormValidity()}}
       var description:String? {didSet {checkFormValidity()}}
       var cvFile:Data? {didSet {checkFormValidity()}}
     var cvName:String? {didSet {checkFormValidity()}}
       var insurance:String? {didSet {checkFormValidity()}}
       var isAccept:Bool? = false {didSet {checkFormValidity()}}
       var index:Int? = -1 {didSet {checkFormValidity()}}
    var isInsurance:Bool?  = false {didSet {checkFormValidity()}}
    
       
       func performRegister(completion:@escaping (MainDoctorRegisterModel,Error?)->Void)  {
        if isInsurance ?? false {
             guard let specialization = specialization,let degree = degree,let description = description,let cvFile = cvFile,let cvName = cvName,let insurance = insurance
                          else { return  }
        }else {
            guard let specialization = specialization,let degree = degree,let description = description,let cvFile = cvFile,let cvName = cvName
                          else { return  }
            
        }
//           guard let specialization = specialization,let degree = degree,let description = description,let cvFile = cvFile,let cvName = cvName,let insurance = insurance else { return  }
           bindableIsResgiter.value = true
           
//        RegistrationServices.shared.registerDoctor(isInsurance: isInsurance, coverImage: , cvName: <#T##String#>, cvFile: <#T##Data#>, name: <#T##String#>, email: <#T##String#>, phone: <#T##String#>, password: <#T##String#>, gender: <#T##String#>, specialization_id: <#T##Int#>, degree_id: <#T##Int#>, insurance: <#T##[Int]#>, completion: <#T##(MainDoctorRegisterModel?, Error?) -> Void#>)
           //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
       }
       
       func checkFormValidity() {
           let isFormValid = specialization != -1 && isInsurance == true && degree != -1 && description?.isEmpty == false &&   cvFile?.isEmpty ==  false &&   cvName?.isEmpty ==  false && insurance?.isEmpty == false   && index != -1 && isAccept != false
           || specialization != -1 && isInsurance == false && degree != -1 && description?.isEmpty == false &&   cvFile?.isEmpty ==  false &&   cvName?.isEmpty ==  false    && index != -1 && isAccept != false
           bindableIsFormValidate.value = isFormValid
           
       }
}
