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
    
    var name:String? {didSet {checkFormValidity()}}
    var phone:String? {didSet {checkFormValidity()}}
    var secondPhone:String? {didSet {checkFormValidity()}}

    var email:String? {didSet {checkFormValidity()}}
    var password:String? {didSet {checkFormValidity()}}
    var male:String = "male" {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    
    var cvFile:Data? {didSet {checkFormValidity()}}
    var cvName:String? {didSet {checkFormValidity()}}
    var specialization_id:Int? {didSet {checkFormValidity()}}
    var degree_id:Int? {didSet {checkFormValidity()}}
    var title:String? {didSet {checkFormValidity()}}
    var insurance:[Int]? {didSet {checkFormValidity()}}

    var description:String? {didSet {checkFormValidity()}}
    var isAccept:Bool? = false {didSet {checkFormValidity()}}
    
    
    func performRegister(completion:@escaping (MainDoctorRegisterModel?, Error?) -> Void)  {
        guard let password = password,let name = name,let phone = phone,let img = image,let specialization_id=specialization_id,let degree_id=degree_id,let index=index
            else { return  }
        bindableIsResgiter.value = true
        
        RegistrationServices.shared.registerDoctor(index: index, coverImage: img, name: name,insurance: insurance,cvName: cvName,cvFile: cvFile,email: email,secondPhone: secondPhone,title: title, phone: phone, password: password, gender: male, specialization_id: specialization_id, degree_id: degree_id, completion: completion)
    }
    
    func checkFormValidity() {
        
        let isFormValid =     password?.isEmpty == false &&  phone?.isEmpty == false && name?.isEmpty == false   && index != -1 && image != nil  && isAccept != false && degree_id != -1 && specialization_id != -1
        
            //password?.isEmpty == false &&  phone?.isEmpty == false && name?.isEmpty == false   && index != -1 && image != nil && isInsurance == false && isAccept != false &&   cvFile?.isEmpty ==  false &&   cvName?.isEmpty ==  false  ||  email?.isEmpty == false && &&   cvFile?.isEmpty ==  false &&   cvName?.isEmpty ==  false
        bindableIsFormValidate.value = isFormValid
    }
}
