//
//  NewPassViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
class NewPassViewModel {
    var bindableIsResending = Bindable<Bool>()

    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()

    //variables
    var password:String? {didSet {checkFormValidity()}}

    var mobile:String? {didSet {checkFormValidity()}}

    var confirmPassword:String? {didSet {checkFormValidity()}}
    var index:Int?  = -1 {didSet {checkFormValidity()}}
    
    
    func performUpdatinging(completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
        guard let password = password,let confirmPassword = confirmPassword,let index=index,let mobile=mobile
            else { return  }
        bindableIsLogging.value = true
        
        LoginServices.shared.mainUpdatePassword(index: index, phone: mobile, old_password: password, new_password: confirmPassword, completion: completion)
    }
    
    func performResendinging(completion:@escaping (MainAddFavoriteModel?,Error?)->Void)  {
           guard let mobile=mobile,let index=index
               else { return  }
           bindableIsLogging.value = true
           
           LoginServices.shared.mainForgetPassword(index: index, phone: mobile, completion: completion)
       }
    
    func checkFormValidity() {
        let isFormValid = password?.isEmpty == false && confirmPassword?.isEmpty == false && index != -1 && mobile?.isEmpty == false
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
