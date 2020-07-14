//
//  EdirProfileViewModel.swift
//  Doctoraak
//
//  Created by hosam on 6/17/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class EdirProfileViewModel {
    
    
    var bindableIsResgiter = Bindable<Bool>()
    var bindableIsFormValidate = Bindable<Bool>()
    
    //variables
    var apiToekn:String? {didSet {checkFormValidity()}}
    var user_Id:Int? = -1 {didSet {checkFormValidity()}}
    
    var name:String? {didSet {checkFormValidity()}}
    var phone:String? {didSet {checkFormValidity()}}
    var email:String? {didSet {checkFormValidity()}}
    var latt:Double? = -1.0 {didSet {checkFormValidity()}}
    var lang:Double? = -1.0 {didSet {checkFormValidity()}}
    
    
    var insurance:[Int]? {didSet {checkFormValidity()}}
    var working_hours:[PharamacyWorkModel]? {didSet {checkFormValidity()}}
    
    var delivery:Int? = 1 {didSet {checkFormValidity()}}
    
    var image:UIImage? {didSet {checkFormValidity()}}
    
    func performPHARAMACYUpdating(completion:@escaping (MainPharamacyLoginModel?,Error?)->Void)  {
        guard let name = name, let insurance = insurance,let image=image,let delivery=delivery,let working_hours=working_hours,let api_token=apiToekn , let user_id = user_Id
            else { return  }
        bindableIsResgiter.value = true
        
        ProfileServices.shared.updatePharamacyProfile(api_token: api_token, user_id: user_id, photo: image, name: name, insurance: insurance, delivery: delivery,working_hours:working_hours, latt: latt, lang: lang, completion: completion)
    }
    
    func performLABUpdating(completion:@escaping (MainLabLoginModel?,Error?)->Void)  {
        guard let name = name, let insurance = insurance,let image=image,let delivery=delivery,let working_hours=working_hours,let api_token=apiToekn , let user_id = user_Id
            else { return  }
        bindableIsResgiter.value = true
        
        ProfileServices.shared.updateLABProfile(api_token: api_token, user_id: user_id, photo: image, name: name, insurance: insurance, delivery: delivery,working_hours:working_hours, latt: latt, lang: lang, completion: completion)
    }
    
    func performRADUpdating(completion:@escaping (MainRadiologyLoginModel?,Error?)->Void)  {
        guard let name = name, let insurance = insurance,let image=image,let delivery=delivery,let working_hours=working_hours,let api_token=apiToekn , let user_id = user_Id
            else { return  }
        bindableIsResgiter.value = true
        
        ProfileServices.shared.updateRADProfile(api_token: api_token, user_id: user_id, photo: image, name: name, insurance: insurance, delivery: delivery,working_hours:working_hours, latt: latt, lang: lang, completion: completion)
    }
    
    
    
    func checkFormValidity() {
        let isFormValid =    name?.isEmpty == false   && insurance?.isEmpty == false   && apiToekn?.isEmpty == false && user_Id != -1
        
        bindableIsFormValidate.value = isFormValid
        
    }
}
