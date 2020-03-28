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
    var city:String? {didSet {checkFormValidity()}}
    var phone:String? {didSet {checkFormValidity()}}
    var address:String? {didSet {checkFormValidity()}}
    var area:String? {didSet {checkFormValidity()}}
    var workingHours:[String]? {didSet {checkFormValidity()}}
    var fees:String? {didSet {checkFormValidity()}}
    var consultaionFees:String? {didSet {checkFormValidity()}}
    var waitingHours:String?  {didSet {checkFormValidity()}}
    var index:Int? = -1 {didSet {checkFormValidity()}}
    var image:UIImage? {didSet {checkFormValidity()}}
    
    
    func performRegister(completion:@escaping (Error?)->Void)  {
        guard let city = city,let area = area,let fees = fees,let phone = phone,let address = address,let waitingHours = waitingHours, let image = image
          ,let consultaionFees = consultaionFees  else { return  }
        bindableIsResgiter.value = true
        
        //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = city?.isEmpty == false && area?.isEmpty == false && fees?.isEmpty == false  &&  phone?.isEmpty == false && waitingHours?.isEmpty == false && address?.isEmpty == false && workingHours?.isEmpty == false && consultaionFees?.isEmpty == false && index != -1 && image != nil
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
