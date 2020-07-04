//
//  LoginViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class LoginViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var phone:String? {didSet {checkFormValidity()}}
    var password:String? {didSet {checkFormValidity()}}
    var index:Int?  = -1 {didSet {checkFormValidity()}}
    var specificationId:Int?  = -1 {didSet {checkFormValidity()}}

    func performDoctorLogging(specificationId:Int? = nil,completion:@escaping (MainDoctorLoginModel?,Error?)->Void)  {
        guard let phone = phone,let password = password,let index=index
            else { return  }
        bindableIsLogging.value = true
        
        LoginServices.shared.DoctorLoginUser(specId:specificationId,index: index, phone: phone, password: password, completion: completion)
    }
    
    func performPharamacyLogging(completion:@escaping (MainPharamacyLoginModel?,Error?)->Void)  {
        guard let phone = phone,let password = password   else { return  }
        bindableIsLogging.value = true
        LoginServices.shared.PharamacyLoginUser( phone: phone, password: password, completion: completion)
    }
    
    func performLabLogging(completion:@escaping (MainLabLoginModel?,Error?)->Void)  {
        guard let phone = phone,let password = password else { return  }
        bindableIsLogging.value = true
        LoginServices.shared.LabLoginUser( phone: phone, password: password, completion: completion)
    }
    
    func performRadLogging(completion:@escaping (MainRadiologyLoginModel?,Error?)->Void)  {
        guard let phone = phone,let password = password else { return  }
        bindableIsLogging.value = true
        LoginServices.shared.radiologyLoginUser( phone: phone, password: password, completion: completion)
    }
    
    
    func checkFormValidity() {
        let isFormValid = phone?.isEmpty == false && password?.isEmpty == false && index != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
