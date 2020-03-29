//
//  NewPassViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
class NewPassViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var password:String? {didSet {checkFormValidity()}}
    var confirmPassword:String? {didSet {checkFormValidity()}}
    var index:Int?  = -1 {didSet {checkFormValidity()}}
    
    
    func performLogging(completion:@escaping (Error?)->Void)  {
        guard let password = password,let confirmPassword = confirmPassword
            else { return  }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password && index != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
