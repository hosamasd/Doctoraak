//
//  DoctorEdirProfileViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/29/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DoctorEdirProfileViewModel {
    
    var bindableIsResgiter = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var phone:String? {didSet {checkFormValidity()}}
    var email:String? {didSet {checkFormValidity()}}
    var address:String? {didSet {checkFormValidity()}}
    var hours:String? {didSet {checkFormValidity()}}
 var cvFile:String? {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    
    
    func performRegister(completion:@escaping (Error?)->Void)  {
        guard let email = email,let phone = phone,let address = address,let cv = cvFile,let waitingHours = hours else { return  }
        bindableIsResgiter.value = true
        
        //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = email?.isEmpty == false  &&  phone?.isEmpty == false  && address?.isEmpty == false && image != nil && hours?.isEmpty == false
//            5&& cvFile?.isEmpty == false
        bindableIsFormValidate.value = isFormValid
        
    }
}
