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
    
    
    lazy var customDoctorMainHomeLeftView:CustomDoctorMainHomeLeftView = {
        let v = CustomDoctorMainHomeLeftView()
       v.handleCheckedIndex = {[unowned self] index in
                   self.checkIfLoggined(index)
               }
               v.index = index
        return v
    }()
    
    var doctor:DoctorModel?{
           didSet{
               guard let lab = doctor else { return  }
               customDoctorMainHomeLeftView.doctor=lab
           }
       }
    
    fileprivate let index:Int!
       init(index:Int) {
           self.index=index
           super.init(nibName: nil, bundle: nil)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        getUserData()
    }
    
    
    
    //MARK: -user methods
    
    func getUserData()  {
        let  index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
//        if currentDoctor == nil {
//            let user_id = userDefaults.integer(forKey: UserDefaultsConstants.doctorCurrentUSERID)
//            guard let api_Key = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentApiToken),let name = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentNAME) else { return  }
//            doctorApiToken=api_Key
//            doctorId=user_id
//
//            DoctorServices.shared.updateDoctorProfile(user_id: user_id, api_token: api_Key, name: name) { (base, err) in
//                if let err=err{
//                    SVProgressHUD.showError(withStatus: err.localizedDescription)
//                    self.activeViewsIfNoData();return
//                }
//                guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn);  self.activeViewsIfNoData(); return}
//
//                self.currentDoctor = user
////                self.customMainHomeLeftView.doctor = user
////                self.customMainHomeLeftView.doctor = user
//
//                DispatchQueue.main.async {
//                    self.view.layoutIfNeeded()
//                }
//            }
//        }
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customDoctorMainHomeLeftView)
        customDoctorMainHomeLeftView.fillSuperview()
    }
    
    func removeDefults()  {
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.DoctorPerformLogin)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorCurrentApiToken)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterIndee)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorCurrentUSERID)
        
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        
    }
    
     func checkIfLoggined(_ indexPath:IndexPath)  {
            guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
            if indexPath.section == 0 {
                if indexPath.item == 0  {
                    baseSlid.closeMenu()
                    let profile = DoctorProfileVC(index: index)
                    profile.doc = doctor
                    let nav = UINavigationController(rootViewController: profile)
                    
                    nav.modalPresentationStyle = .fullScreen
                    present(nav, animated: true)
                }else if indexPath.item == 1 {
                    baseSlid.closeMenu()
                    let profile = MainClinicWorkingHoursNotDoctorVC(index: index, isFromUpdateProfile: false,isFromRegister: false)
                    let nav = UINavigationController(rootViewController: profile)
                    
                    nav.modalPresentationStyle = .fullScreen
                    present(nav, animated: true)
                    
                }else if indexPath.item == 2 {
                    baseSlid.closeMenu()
                    let profile = NotificationVC(index: index, isFromMenu: true)
                    profile.doctor=doctor
                    let nav = UINavigationController(rootViewController: profile)
                    
                    nav.modalPresentationStyle = .fullScreen
                    present(nav, animated: true)
                }else if indexPath.item == 3 {
                    baseSlid.closeMenu()
                    let profile = AnaylticsVC()
                    profile.doctor=doctor
                    let nav = UINavigationController(rootViewController: profile)
                    
                    nav.modalPresentationStyle = .fullScreen
                    present(nav, animated: true)
                    
                }
            }else {
                if indexPath.item == 2 {
                    baseSlid.closeMenu()
                    createAlerts()
                }else if indexPath.item == 0 {
                    baseSlid.closeMenu()
                    showAlertForContacting()
                }else{
                    baseSlid.closeMenu()
                    chooseLanguage()
                }
            }
        }
    
    fileprivate func createAlerts() {
        let alert = UIAlertController(title: "Warring...".localized, message: "Do You Want To Log Out?".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Log Out".localized, style: .destructive) {[unowned self] (_) in
            self.performLogout()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) {[unowned self] (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    fileprivate func chooseLanguage()  {
           guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
           
           //        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
           
           baseSlid.closeMenu()
           baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertChooseLanguageView, height: 200)
           baseSlid.present(baseSlid.customMainAlertVC, animated: true)
       }
       fileprivate func showAlertForContacting()  {
           guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
           
           //        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
           
           baseSlid.closeMenu()
           baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customContactUsView, height: 120)
           baseSlid.present(baseSlid.customMainAlertVC, animated: true)
       }
       
       
       fileprivate  func performLogout()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.DoctorPerformLogin) {
                  cacheDoctorObjectCodabe.deleteFile(doctor!)
                  self.doctor=nil
                  userDefaults.set(false, forKey: UserDefaultsConstants.DoctorPerformLogin)
              }
    }
    
    //TODO: -handle methods
    
    @objc func handleLogout()  {
        
        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
        removeDefults()
        
        baseSlid.closeMenu()
        
        print(9999999)
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
