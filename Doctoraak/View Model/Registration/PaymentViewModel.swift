//
//  PaymentViewModel.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//



import UIKit

class PaymentViewModel {
    
    var bindableIsLogging = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var vodafoneVode:String? {didSet {checkFormValidity()}}
    var fawryCode:String? {didSet {checkFormValidity()}}
    var visaCard:String? {didSet {checkFormValidity()}}
    var visaMonthCard:String? {didSet {checkFormValidity()}}
    var visaCVCCard:String? {didSet {checkFormValidity()}}

    var firstChosen:Bool?  = true {didSet {checkFormValidity()}}
    var secondChosen:Bool?  = false {didSet {checkFormValidity()}}
    var thirdChosen:Bool?  = false {didSet {checkFormValidity()}}

    var isPaymentOperationDone:Bool?  = false {didSet {checkFormValidity()}}

    
    func performLogging(completion:@escaping (Error?)->Void)  {
        guard let vodafoneVode = vodafoneVode,let fawryCode = fawryCode,let visaCard=visaCard,let firstChosen=firstChosen,let secondChosen=secondChosen,let thirdChosen=thirdChosen
            else { return  }
        bindableIsLogging.value = true
        
        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
    }
    
    func checkFormValidity() {
        
        let isFormValid = vodafoneVode?.isEmpty == false && firstChosen == true && secondChosen == false && thirdChosen == false
                   || secondChosen == true &&  fawryCode?.isEmpty == false && thirdChosen == false
                   || firstChosen == false && secondChosen == false && thirdChosen == true && isPaymentOperationDone == true
               
               bindableIsFormValidate.value = isFormValid
        
//        let isFormValid = vodafoneVode?.isEmpty == false && firstChosen == true && secondChosen == false && thirdChosen == false
//            || secondChosen == true &&  fawryCode?.isEmpty == false && thirdChosen == false
//            || firstChosen == false && secondChosen == false && thirdChosen == true && visaCard?.isEmpty == false && visaCVCCard?.isEmpty == false && visaMonthCard?.isEmpty == false
//
//        bindableIsFormValidate.value = isFormValid
        
    }
}



//import UIKit
//
//class PaymentViewModel {
//
//    var bindableIsLogging = Bindable<Bool>()
//    var bindableIsFormValidate = Bindable<Bool>()
//
//    //variables
//    var vodafoneVode:String? {didSet {checkFormValidity()}}
//    var fawryCode:String? {didSet {checkFormValidity()}}
//    var index:Int?  = -1 {didSet {checkFormValidity()}}
//
//
//    func performLogging(completion:@escaping (Error?)->Void)  {
//        guard let vodafoneVode = vodafoneVode,let fawryCode = fawryCode
//            else { return  }
//        bindableIsLogging.value = true
//
//        //        RegistrationServices.shared.loginUser(phone: email, password: password, completion: completion)
//    }
//
//    func checkFormValidity() {
//        let isFormValid = vodafoneVode?.isEmpty == false && index != -1 || fawryCode?.isEmpty == false && index != -1
//
//        bindableIsFormValidate.value = isFormValid
//
//    }
//}
