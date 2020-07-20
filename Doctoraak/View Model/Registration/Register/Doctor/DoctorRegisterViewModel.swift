//
//  DoctorRegisterViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DoctorRegisterViewModel {
 
    var bindableIsResgiter = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var name:String? {didSet {checkFormValidity()}}
    var phone:String? {didSet {checkFormValidity()}}
    var secondPhone:String? {didSet {checkFormValidity()}}

    var email:String? {didSet {checkFormValidity()}}
    var password:String? {didSet {checkFormValidity()}}
    var confirmPassword:String? {didSet {checkFormValidity()}}
    var male:String = "male" {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    
    func performRegister(completion:@escaping (UIImage?,String,String,String?,String?,String,String,Int) -> Void )  {
        guard let password = password,let name = name,let phone = phone,let index=index
            else { return  }
        bindableIsResgiter.value = true

        completion(image,name,phone,secondPhone,email,password,male,index)
    }
    
    func checkFormValidity() {
        let isFormValid =  password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false   && index != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
    
}

