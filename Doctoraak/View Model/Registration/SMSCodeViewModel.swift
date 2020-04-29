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
    var bindableIsResendingSms = Bindable<Bool>()

    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var smsCode:String? {didSet {checkFormValidity()}}
     var sms2Code:String? {didSet {checkFormValidity()}}
     var sms3Code:String? {didSet {checkFormValidity()}}
     var sms4Code:String? {didSet {checkFormValidity()}}
    var sms5Code:String? {didSet {checkFormValidity()}}

    
     var id:Int? = -1 {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}

    
    func performLogging(completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
        guard let smsCode = smsCode, let sms2Code = sms2Code, let sms3Code = sms3Code,let sms4Code = sms4Code,let sms5Code=sms5Code,let index=index,let id=id
            else { return  }
        let mainsmsCode = smsCode+sms2Code+sms3Code+sms4Code+sms5Code
        
        bindableIsLogging.value = true
        
        RegistrationServices.shared.MainReceiveSmsCode(index: index, user_id: id, sms_code: mainsmsCode, completion: completion)
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func performResendSMSCode(completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
           guard let id = id,let index=index  else { return  }
           
           bindableIsResendingSms.value = true
           
        RegistrationServices.shared.MainResendSmsCodeAgain(index: index, user_id: id, completion: completion)
       }
    
    func checkFormValidity() {
        let isFormValid = smsCode?.isEmpty == false && sms2Code?.isEmpty == false && sms3Code?.isEmpty == false && sms4Code?.isEmpty == false && sms5Code?.isEmpty == false && index != -1 && id != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}


