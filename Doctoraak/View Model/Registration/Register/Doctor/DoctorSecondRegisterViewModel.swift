//
//  DoctorSecondRegisterViewModel.swift
//  Doctoraak
//
//  Created by hosam on 4/7/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DoctorSecondRegisterViewModel {
    
    var bindableIsResgiter = Bindable<Bool>()
       var bindableIsFormValidate = Bindable<Bool>()
       
       //variables
       var specialization:String? {didSet {checkFormValidity()}}
       var degree:String? {didSet {checkFormValidity()}}
       var description:String? {didSet {checkFormValidity()}}
       var cvFile:String? {didSet {checkFormValidity()}}
       var insurance:String? {didSet {checkFormValidity()}}
       var isAccept:Bool? = false {didSet {checkFormValidity()}}
       var index:Int? = -1 {didSet {checkFormValidity()}}
       
       
       func performRegister(completion:@escaping (Error?)->Void)  {
           guard let specialization = specialization,let degree = degree,let description = description,let cvFile = cvFile,let insurance = insurance
               else { return  }
           bindableIsResgiter.value = true
           
           //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
       }
       
       func checkFormValidity() {
           let isFormValid = specialization?.isEmpty == false && degree?.isEmpty == false && description?.isEmpty == false &&   cvFile?.isEmpty == false && insurance?.isEmpty == false   && index != -1 && isAccept != false
           
           bindableIsFormValidate.value = isFormValid
           
       }
}
