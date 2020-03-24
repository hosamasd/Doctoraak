//
//  SMSCodeViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class SMSCodeViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var smsCode:String? {didSet {checkFormValidity()}}
    
    
    func performLogging(completion:@escaping (Error?)->Void)  {
        guard let smsCode = smsCode
            else { return  }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = smsCode?.isEmpty == false && smsCode?.count ?? 0 > 4
        
        bindableIsFormValidate.value = isFormValid
        
    }
}


