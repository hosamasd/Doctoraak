//
//  HomeLeftMenuVC.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class DoctorHomeLeftMenuVC: CustomBaseViewVC {
    
    
    lazy var customMainHomeLeftView:CustomMainHomeLeftView = {
        let v = CustomMainHomeLeftView()
        v.handleCheckedIndex = {[unowned self] index in
            print(index.item)
        }
        
        return v
    }()
    
    var doctorApiToken:String = ""
    var doctorId = 0
    var currentDoctor:DoctorLoginModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        getUserData()
    }
    
    
    
    //MARK: -user methods
    
    func getUserData()  {
        let  index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
        if currentDoctor == nil {
            let user_id = userDefaults.integer(forKey: UserDefaultsConstants.doctorCurrentUSERID)
            guard let api_Key = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentApiToken),let name = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentNAME) else { return  }
            doctorApiToken=api_Key
            doctorId=user_id
            
            DoctorServices.shared.updateDoctorProfile(user_id: user_id, api_token: api_Key, name: name) { (base, err) in
                if let err=err{
                    SVProgressHUD.showError(withStatus: err.localizedDescription)
                    self.activeViewsIfNoData();return
                }
                guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn);  self.activeViewsIfNoData(); return}
                
                self.currentDoctor = user
//                self.customMainHomeLeftView.doctor = user
//                self.customMainHomeLeftView.doctor = user
                
                DispatchQueue.main.async {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customMainHomeLeftView)
        customMainHomeLeftView.fillSuperview()
    }
    
    func removeDefults()  {
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.DoctorPerformLogin)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorCurrentApiToken)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterIndee)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorCurrentUSERID)
        
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        
    }
    
    //TODO: -handle methods
    
    @objc func handleLogout()  {
        
        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
        removeDefults()
        currentDoctor = nil
        
        baseSlid.closeMenu()
        
        print(9999999)
    }
}
