//
//  PaymentViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class PaymentViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var vodafoneVode:String? {didSet {checkFormValidity()}}
    var fawryCode:String? {didSet {checkFormValidity()}}
    var index:Int?  = -1 {didSet {checkFormValidity()}}
    
    
    func performLogging(completion:@escaping (Error?)->Void)  {
        guard let vodafoneVode = vodafoneVode,let fawryCode = fawryCode
            else { return  }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = vodafoneVode?.isEmpty == false && index != -1 || fawryCode?.isEmpty == false && index != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
