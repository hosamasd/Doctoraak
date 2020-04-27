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
    var email:String? {didSet {checkFormValidity()}}
    var password:String? {didSet {checkFormValidity()}}
    var confirmPassword:String? {didSet {checkFormValidity()}}
    var male:String = "male" {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
//    var isInsurance:Bool? = false {didSet {checkFormValidity()}}
//    var insurance:[Int]? {didSet {checkFormValidity()}}
//
//    var cvFile:Data? {didSet {checkFormValidity()}}
//       var cvName:String? {didSet {checkFormValidity()}}
//    var specialization_id:Int? {didSet {checkFormValidity()}}
//    var degree_id:Int? {didSet {checkFormValidity()}}
    
    
    func performRegister(completion:@escaping (UIImage,String,String,String,String,String,Int) -> Void )  {
        guard let email = email,let password = password,let name = name,let phone = phone,let img = image,let index=index
            else { return  }
        bindableIsResgiter.value = true

        completion(img,name,phone,email,password,male,index)
//        RegistrationServices.shared.registerDoctor(isInsurance: isInsurance, coverImage: img, cvName: cvName, cvFile: cvData, name: name, email: email, phone: phone, password: password, gender: male, specialization_id: specialization_id, degree_id: degree_id, insurance: insurance, completion: completion)
        //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false   && index != -1 && image != nil 
        
        bindableIsFormValidate.value = isFormValid
        
    }
    
}

