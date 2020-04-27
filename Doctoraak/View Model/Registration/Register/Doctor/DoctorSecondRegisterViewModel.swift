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
    var email:String? {didSet {checkFormValidity()}}
    var password:String? {didSet {checkFormValidity()}}
    var confirmPassword:String? {didSet {checkFormValidity()}}
    var male:String = "male" {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    var isInsurance:Bool? = false {didSet {checkFormValidity()}}
    var insurance:[Int]? {didSet {checkFormValidity()}}
    
    var cvFile:Data? {didSet {checkFormValidity()}}
       var cvName:String? {didSet {checkFormValidity()}}
    var specialization_id:Int? {didSet {checkFormValidity()}}
    var degree_id:Int? {didSet {checkFormValidity()}}
//       var specialization:Int? = -1 {didSet {checkFormValidity()}}
//       var degree:Int? = -1 {didSet {checkFormValidity()}}
       var description:String? {didSet {checkFormValidity()}}
//       var cvFile:Data? {didSet {checkFormValidity()}}
//     var cvName:String? {didSet {checkFormValidity()}}
//       var insurance:String? {didSet {checkFormValidity()}}
       var isAccept:Bool? = false {didSet {checkFormValidity()}}
//       var index:Int? = -1 {didSet {checkFormValidity()}}
//    var isInsurance:Bool?  = false {didSet {checkFormValidity()}}
    
       
       func performRegister(completion:@escaping (MainDoctorRegisterModel?, Error?) -> Void)  {
        guard let email = email,let password = password,let name = name,let phone = phone,let img = image,let isInsurance = isInsurance,let cvName=cvName,let cvData=cvFile,let specialization_id=specialization_id,let degree_id=degree_id,let insurance=insurance
                   else { return  }
               bindableIsResgiter.value = true
               
               RegistrationServices.shared.registerDoctor(isInsurance: isInsurance, coverImage: img, cvName: cvName, cvFile: cvData, name: name, email: email, phone: phone, password: password, gender: male, specialization_id: specialization_id, degree_id: degree_id, insurance: insurance, completion: completion)
//        if isInsurance ?? false {
//             guard let specialization = specialization,let degree = degree,let description = description,let cvFile = cvFile,let cvName = cvName,let insurance = insurance
//                          else { return  }
//        }else {
//            guard let specialization = specialization,let degree = degree,let description = description,let cvFile = cvFile,let cvName = cvName
//                          else { return  }
//
//        }
//           guard let specialization = specialization,let degree = degree,let description = description,let cvFile = cvFile,let cvName = cvName,let insurance = insurance else { return  }
//           bindableIsResgiter.value = true
           
//        RegistrationServices.shared.registerDoctor(isInsurance: isInsurance, coverImage: , cvName: <#T##String#>, cvFile: <#T##Data#>, name: <#T##String#>, email: <#T##String#>, phone: <#T##String#>, password: <#T##String#>, gender: <#T##String#>, specialization_id: <#T##Int#>, degree_id: <#T##Int#>, insurance: <#T##[Int]#>, completion: <#T##(MainDoctorRegisterModel?, Error?) -> Void#>)
           //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
       }
       
       func checkFormValidity() {
        
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false   && index != -1 && image != nil && isInsurance == false || isInsurance == true &&   email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false   && index != -1 && image != nil && insurance?.isEmpty == false
               
               bindableIsFormValidate.value = isFormValid
        
//           let isFormValid = specialization != -1 && isInsurance == true && degree != -1 && description?.isEmpty == false &&   cvFile?.isEmpty ==  false &&   cvName?.isEmpty ==  false && insurance?.isEmpty == false   && index != -1 && isAccept != false
//           || specialization != -1 && isInsurance == false && degree != -1 && description?.isEmpty == false &&   cvFile?.isEmpty ==  false &&   cvName?.isEmpty ==  false    && index != -1 && isAccept != false
//           bindableIsFormValidate.value = isFormValid
           
       }
}
