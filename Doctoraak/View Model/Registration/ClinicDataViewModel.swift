//
//  ClinicDataViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class ClinicDataViewModel {
    
    
    var bindableIsResgiter = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var city:Int? = -1 {didSet {checkFormValidity()}}
    var phone:String? {didSet {checkFormValidity()}}
    var api_token:String? {didSet {checkFormValidity()}}
    var doctor_id:String? {didSet {checkFormValidity()}}

 var latt:String? {didSet {checkFormValidity()}}
     var lang:String? {didSet {checkFormValidity()}}
    var area:Int? = -1 {didSet {checkFormValidity()}}
    var workingHours:[String]? {didSet {checkFormValidity()}}
    var fees:Int? = -1 {didSet {checkFormValidity()}}
    var consultaionFees:Int? = -1 {didSet {checkFormValidity()}}
    var waitingHours:String?  {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    var workingArrayHours:[ Any]?  {didSet {checkFormValidity()}}
    
    
    func performRegister(completion:@escaping (MainDoctorClinicCreateModel?,Error?)->Void)    {
        guard let city = city,let area = area,let fees = fees,let phone = phone,let lang = lang,let lat=latt,let waitingHours = waitingHours, let image = image
          ,let consultaionFees = consultaionFees ,let api_token=api_token,let doctor_id=doctor_id,let workingArrayHours=workingArrayHours else { return  }
        bindableIsResgiter.value = true
        
        RegistrationServices.shared.RegiasterClinicCreate(fees2: consultaionFees, fees: fees, lang: lang, latt: lat, phone: phone, waiting_time: waitingHours, photo: image, city: city, area: area, api_token: api_token, doctor_id: doctor_id, working_hours:workingArrayHours , completion: completion)
        //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
    }
    
    func checkFormValidity() {
//        let isFormValid = city?.isEmpty == false && area?.isEmpty == false && fees?.isEmpty == false  &&  phone?.isEmpty == false && waitingHours?.isEmpty == false && address?.isEmpty == false && workingHours?.isEmpty == false && consultaionFees?.isEmpty == false && index != -1 && image != nil && workingArrayHours?.isEmpty == false
        let isFormValid = city != -1 && area != -1 && fees != -1  &&  phone?.isEmpty == false && waitingHours?.isEmpty == false && latt?.isEmpty == false  && lang?.isEmpty == false  && consultaionFees  != -1 && index != -1 && image != nil && workingArrayHours?.isEmpty == false && api_token?.isEmpty == false && doctor_id?.isEmpty == false
        bindableIsFormValidate.value = isFormValid
        
    }
}
