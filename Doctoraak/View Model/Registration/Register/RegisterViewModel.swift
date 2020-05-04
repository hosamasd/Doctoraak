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
    var latt:String? {didSet {checkFormValidity()}}
    var lang:String? {didSet {checkFormValidity()}}
    
    var password:String? {didSet {checkFormValidity()}}
    var confirmPassword:String? {didSet {checkFormValidity()}}
    var city:Int? = -1 {didSet {checkFormValidity()}}
    var area:Int? = -1 {didSet {checkFormValidity()}}
    
    var insurance:[Int]? {didSet {checkFormValidity()}}
    var working_hours:[SecondWorkModel]? {didSet {checkFormValidity()}}
    
    var delivery:Int? = 1 {didSet {checkFormValidity()}}
    
    var index:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    
    
    func performRegister(completion:@escaping (MainLabRegisterModel?,Error?)->Void)  {
        guard let email = email,let password = password,let name = name,let phone = phone, let insurance = insurance,let city=city,let area=area,let image=image,let delivery=delivery,let working_hours=working_hours,let latt=latt,let lang=lang,let index=index
            else { return  }
        bindableIsResgiter.value = true
        
        RegistrationServices.shared.mainRegister(index: index, photo: image, name: name, email: email, phone: phone, password: password, insurance: insurance, delivery: delivery, working_hours: working_hours, latt:latt, lang: lang, city: city, area: area, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false && confirmPassword?.isEmpty == false && confirmPassword == password &&  phone?.isEmpty == false && name?.isEmpty == false && lang?.isEmpty == false && latt?.isEmpty == false && working_hours?.isEmpty == false  && insurance?.isEmpty == false && index != -1 && image != nil && city != -1  && area != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
