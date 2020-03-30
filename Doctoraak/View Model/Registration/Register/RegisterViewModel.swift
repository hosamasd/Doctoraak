//
//  RegisterViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit

class RegisterViewModel {
    
    
    var bindableIsResgiter = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
     var name:String? {didSet {checkFormValidity()}}
     var phone:String? {didSet {checkFormValidity()}}
    var email:String? {didSet {checkFormValidity()}}
    var address:String? {didSet {checkFormValidity()}}
    var password:String? {didSet {checkFormValidity()}}
    var confirmPassword:String? {didSet {checkFormValidity()}}
    var hours:String? {didSet {checkFormValidity()}}
    
      var insurance:String? {didSet {checkFormValidity()}}
    var delivery:Bool? = true {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    
    
    func performRegister(completion:@escaping (Error?)->Void)  {
        guard let email = email,let password = password,let name = name,let phone = phone,let address = address,let hours = hours, let insurance = insurance
            else { return  }
        bindableIsResgiter.value = true
        
//        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false && address?.isEmpty == false && hours?.isEmpty == false && insurance?.isEmpty == false && index != -1 && image != nil
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
