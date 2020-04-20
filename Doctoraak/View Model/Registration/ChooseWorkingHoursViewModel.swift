//
//  CooseWorkingHoursViewModel.swift
//  Doctoraak
//
//  Created by hosam on 4/20/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class ChooseWorkingHoursViewModel {
    
    var bindableIsResgiter = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var isShiftOne:Bool? = true {didSet {checkFormValidity()}}
    var isShiftTwo:Bool? = false {didSet {checkFormValidity()}}
    var day1:Bool? = true {didSet {checkFormValidity()}}
    var day2:Bool? = false {didSet {checkFormValidity()}}
    var day3:Bool? = false {didSet {checkFormValidity()}}
    var day4:Bool? = false {didSet {checkFormValidity()}}
    var day5:Bool? = false {didSet {checkFormValidity()}}
    var day6:Bool? = false {didSet {checkFormValidity()}}
    var day7:Bool? = false {didSet {checkFormValidity()}}
    
    var d1TXT1:String? {didSet {checkFormValidity()}}
    var d1TXT2:String? {didSet {checkFormValidity()}}
    var d2TXT1:String? {didSet {checkFormValidity()}}
    var d2TXT2:String? {didSet {checkFormValidity()}}
    var d3TXT1:String? {didSet {checkFormValidity()}}
    var d3TXT2:String? {didSet {checkFormValidity()}}
    var d4TXT1:String? {didSet {checkFormValidity()}}
    var d4TXT2:String? {didSet {checkFormValidity()}}
    var d5TXT1:String? {didSet {checkFormValidity()}}
    var d5TXT2:String? {didSet {checkFormValidity()}}
    var d6TXT1:String? {didSet {checkFormValidity()}}
    var d6TXT2:String? {didSet {checkFormValidity()}}
    var d7TXT1:String? {didSet {checkFormValidity()}}
    var d7TXT2:String? {didSet {checkFormValidity()}}
    
    var day12:Bool? = true {didSet {checkFormValidity()}}
       var day22:Bool? = false {didSet {checkFormValidity()}}
       var day32:Bool? = false {didSet {checkFormValidity()}}
       var day42:Bool? = false {didSet {checkFormValidity()}}
       var day52:Bool? = false {didSet {checkFormValidity()}}
       var day62:Bool? = false {didSet {checkFormValidity()}}
       var day72:Bool? = false {didSet {checkFormValidity()}}
       
       var d12TXT1:String? {didSet {checkFormValidity()}}
       var d12TXT2:String? {didSet {checkFormValidity()}}
       var d22TXT1:String? {didSet {checkFormValidity()}}
       var d22TXT2:String? {didSet {checkFormValidity()}}
       var d32TXT1:String? {didSet {checkFormValidity()}}
       var d32TXT2:String? {didSet {checkFormValidity()}}
       var d42TXT1:String? {didSet {checkFormValidity()}}
       var d42TXT2:String? {didSet {checkFormValidity()}}
       var d52TXT1:String? {didSet {checkFormValidity()}}
       var d52TXT2:String? {didSet {checkFormValidity()}}
       var d62TXT1:String? {didSet {checkFormValidity()}}
       var d62TXT2:String? {didSet {checkFormValidity()}}
       var d72TXT1:String? {didSet {checkFormValidity()}}
       var d72TXT2:String? {didSet {checkFormValidity()}}
    
    func performRegister(completion:@escaping (Error?)->Void)  {
//        guard let city = city,let area = area,let fees = fees,let phone = phone,let address = address,let waitingHours = waitingHours, let image = image
//            ,let consultaionFees = consultaionFees  else { return  }
        bindableIsResgiter.value = true
        
        //        RegistrationServices.shared.registerUser(name: username, email: email, phone: phone, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        let isFormValid = true
//            day1 == true && d1TXT1?.isEmpty == false && d1TXT2?.isEmpty == false ||
//         day2 == true && d2TXT1?.isEmpty == false && d2TXT2?.isEmpty == false ||
//             day3 == true && d3TXT1?.isEmpty == false && d3TXT2?.isEmpty == false ||
//             day4 == true && d4TXT1?.isEmpty == false && d4TXT2?.isEmpty == false ||
//             day5 == true && d5TXT1?.isEmpty == false && d5TXT2?.isEmpty == false ||
//             day6 == true && d6TXT1?.isEmpty == false && d6TXT2?.isEmpty == false ||
//             day7 == true && d7TXT1?.isEmpty == false && d7TXT2?.isEmpty == false
            
        bindableIsFormValidate.value = isFormValid
        
    }
    
    
}

