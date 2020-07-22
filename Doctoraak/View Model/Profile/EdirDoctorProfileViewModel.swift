//
//  EdirDoctorProfileViewModel.swift
//  Doctoraak
//
//  Created by hosam on 6/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class EdirDoctorProfileViewModel {
    var bindableIsResgiter = Bindable<Bool>()
      var bindableIsFormValidate = Bindable<Bool>()
      
      //variables
      var apiToekn:String? {didSet {checkFormValidity()}}
      var user_Id:Int? = -1 {didSet {checkFormValidity()}}
      
      var name:String? {didSet {checkFormValidity()}}
      var phone:String? {didSet {checkFormValidity()}}
    var phone2:String? {didSet {checkFormValidity()}}
    var title:String? {didSet {checkFormValidity()}}
    var description:String? {didSet {checkFormValidity()}}

    
    var gender:String? {didSet {checkFormValidity()}}

      var email:String? {didSet {checkFormValidity()}}
      var cvFile:Data? {didSet {checkFormValidity()}}
         var cvName:String? {didSet {checkFormValidity()}}
      
      var insurance:[Int]? {didSet {checkFormValidity()}}
      
      var degreeId:Int? = -1 {didSet {checkFormValidity()}}

      var image:UIImage? {didSet {checkFormValidity()}}
    
    func performUpdating(completion:@escaping (MainDoctorLoginModel?,Error?)->Void)  {
        guard let name = name, let insurance = insurance,let image=image,let user_Id=user_Id,let degreeId=degreeId,let api_token=apiToekn , let cvName = cvName,let cvFile=cvFile
            else { return  }
        bindableIsResgiter.value = true
        
        ProfileServices.shared.updateDoctorProfile(api_token: api_token, user_id: user_Id, photo: image, name: name, insurance: insurance, degree_id: degreeId,cvName: cvName,cvFile: cvFile, completion: completion)
    }
    
    func checkFormValidity() {
           let isFormValid =    name?.isEmpty == false     && image != nil && apiToekn?.isEmpty == false && user_Id != -1 && degreeId != -1 
           
           bindableIsFormValidate.value = isFormValid
           
       }
}
