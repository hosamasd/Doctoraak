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
    
    
    func performRADRegister(completion:@escaping (MainRadiologySMSCodeModel?,Error?)->Void)  {
        guard let smsCode = smsCode, let sms2Code = sms2Code, let sms3Code = sms3Code,let sms4Code = sms4Code,let sms5Code=sms5Code,let id=id
            else { return  }
        let mainsmsCode = smsCode+sms2Code+sms3Code+sms4Code+sms5Code
        
        bindableIsLogging.value = true
        
        RegistrationServices.shared.MainRADReceiveSmsCode( user_id: id, sms_code: mainsmsCode, completion: completion)
    }
    
    func performDoctorRegister(completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
        guard let smsCode = smsCode, let sms2Code = sms2Code, let sms3Code = sms3Code,let sms4Code = sms4Code,let sms5Code=sms5Code,let index=index,let id=id
            else { return  }
        let mainsmsCode = smsCode+sms2Code+sms3Code+sms4Code+sms5Code
        
        bindableIsLogging.value = true
        
        RegistrationServices.shared.MainReceiveSmsCode(index: index, user_id: id, sms_code: mainsmsCode, completion: completion)
    }
    
    func performLABRegister(completion:@escaping (MainLabSMSCodeModel?,Error?)->Void)  {
        guard let smsCode = smsCode, let sms2Code = sms2Code, let sms3Code = sms3Code,let sms4Code = sms4Code,let sms5Code=sms5Code,let id=id
            else { return  }
        let mainsmsCode = smsCode+sms2Code+sms3Code+sms4Code+sms5Code
        
        bindableIsLogging.value = true
        
        RegistrationServices.shared.MainLABReceiveSmsCode( user_id: id, sms_code: mainsmsCode, completion: completion)
    }
    
    func performPHARAMACYRegister(completion:@escaping (MainPharamacySMSCodeModel?,Error?)->Void)  {
        guard let smsCode = smsCode, let sms2Code = sms2Code, let sms3Code = sms3Code,let sms4Code = sms4Code,let sms5Code=sms5Code,let id=id
            else { return  }
        let mainsmsCode = smsCode+sms2Code+sms3Code+sms4Code+sms5Code
        
        bindableIsLogging.value = true
        
        RegistrationServices.shared.MainPHYReceiveSmsCode( user_id: id, sms_code: mainsmsCode, completion: completion)
    }
    
    //resending
    
    func performResendDOCSMSCode(completion:@escaping (MainDoctorSMSAndResendCodeModel?,Error?)->Void)  {
        guard let id = id  else { return  }
        
        bindableIsResendingSms.value = true
        
        RegistrationServices.shared.MainResendSmsCodeAgainDOC( user_id: id, completion: completion)
    }
    
    func performResendLABSMSCode(completion:@escaping (MainLabSMSCodeModel?,Error?)->Void)  {
        guard let id = id  else { return  }
        
        bindableIsResendingSms.value = true
        
        RegistrationServices.shared.MainResendSmsCodeAgainLAB(user_id: id, completion: completion)
    }
    
    func performResendRADSMSCode(completion:@escaping (MainRadiologySMSCodeModel?,Error?)->Void)  {
        guard let id = id  else { return  }
        
        bindableIsResendingSms.value = true
        
        RegistrationServices.shared.MainResendSmsCodeAgainRAD(user_id: id, completion: completion)
    }
    
    func performResendPHYSMSCode(completion:@escaping (MainPharamacySMSCodeModel?,Error?)->Void)  {
        guard let id = id  else { return  }
        
        bindableIsResendingSms.value = true
        
        RegistrationServices.shared.MainResendSmsCodeAgainPHY( user_id: id, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = smsCode?.isEmpty == false && sms2Code?.isEmpty == false && sms3Code?.isEmpty == false && sms4Code?.isEmpty == false && sms5Code?.isEmpty == false && index != -1 && id != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}


