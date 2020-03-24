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
     var sms2Code:String? {didSet {checkFormValidity()}}
     var sms3Code:String? {didSet {checkFormValidity()}}
     var sms4Code:String? {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}

    
    func performLogging(completion:@escaping (Error?)->Void)  {
        guard let smsCode = smsCode, let sms2Code = sms2Code, let sms3Code = sms3Code,let sms4Code = sms4Code
            else { return  }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = smsCode?.isEmpty == false && sms2Code?.isEmpty == false && sms3Code?.isEmpty == false && sms4Code?.isEmpty == false && index != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}


