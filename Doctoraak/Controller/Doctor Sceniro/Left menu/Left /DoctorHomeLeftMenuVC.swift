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
        v.handleCheckedDocIndex = {[unowned self] index in
            self.checkIfLogginedDoc(index)
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
    
    var meidicalCenter:DoctorModel?{
        didSet{
            guard let lab = meidicalCenter else { return  }
            customDoctorMainHomeLeftView.meidicalCenter=lab
            
            
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if userDefaults.bool(forKey: UserDefaultsConstants.DoctorPerformLogin) {
            doctor = cacheDoctorObjectCodabe.storedValue
        }
    }
    
    
    //MARK: -user methods
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customDoctorMainHomeLeftView)
        customDoctorMainHomeLeftView.fillSuperview()
    }
    
    fileprivate func removeDefults()  {
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.DoctorPerformLogin)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorCurrentApiToken)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorCurrentUSERID)
        
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        
    }
    
    fileprivate  func checkIfLogginedDoc(_ indexPath:IndexPath)  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC ,let doc = doctor else {return}
        
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                baseSlid.closeMenu()
                let profile = DoctorProfileVC(index: index)
                profile.doc=doctor
                let nav = UINavigationController(rootViewController: profile)
                
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            }else if indexPath.item == 1 {
                baseSlid.closeMenu()
                let profile = DoctorClinicDataVC(indexx: index, api_token: doc.apiToken, doctor_id: doc.id, isFromProfile: true)
                let nav = UINavigationController(rootViewController: profile)
                
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            }else if indexPath.item == 2 {
                baseSlid.closeMenu()
            }else if indexPath.item == 3 {
                baseSlid.closeMenu()
                let profile = DoctorClinicWorkingHoursVC()//DoctorClinicDataVC(indexx: index, api_token: doc.apiToken, doctor_id: doc.id, isFromProfile: true)
                profile.doctor=chossedClinic
                let nav = UINavigationController(rootViewController: profile)
                
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            } else if indexPath.item == 4 {
                goToSameNotification(baseSlid)
            }else if indexPath.item == 5 {
                goToSameAnayltics(baseSlid)
            }
        }else {
            makeSameActions(indexPath, baseSlid)
            
        }
    }
    
    fileprivate func makeSameActions(_ indexPath: IndexPath, _ baseSlid: BaseSlidingVC) {
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
    
    fileprivate func goToSameAnayltics(_ baseSlid: BaseSlidingVC) {
        baseSlid.closeMenu()
        let profile = AnaylticsVC()
        profile.doctor=doctor
        let nav = UINavigationController(rootViewController: profile)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    fileprivate func goToSameNotification(_ baseSlid: BaseSlidingVC) {
        baseSlid.closeMenu()
        let profile = NotificationVC(index: index, isFromMenu: true)
        profile.doctor=doctor
        let nav = UINavigationController(rootViewController: profile)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    
    
    fileprivate func createAlerts() {
        let alert = UIAlertController(title: "Warring...".localized, message: "Do You Want To Log Out?".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Log Out".localized, style: .destructive) {[unowned self] (_) in
            self.performLogout()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    fileprivate func chooseLanguage()  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
        
        //        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
        
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
        guard let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC else {return}
        //        removeDefults()
        
        
        if userDefaults.bool(forKey: UserDefaultsConstants.DoctorPerformLogin) {
            cacheDoctorObjectCodabe.deleteFile(doctor!)
            userDefaults.set(false, forKey: UserDefaultsConstants.DoctorPerformLogin)
            userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedDoctor)
            userDefaults.removeObject(forKey: UserDefaultsConstants.doctorCurrentApiToken)
            userDefaults.removeObject(forKey: UserDefaultsConstants.doctorCurrentUSERID)
            self.doctor=nil
        }else if userDefaults.bool(forKey: UserDefaultsConstants.medicalCenterPerformLogin){
            cacheMedicalObjectCodabe.deleteFile(meidicalCenter!)
            self.meidicalCenter=nil
            userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedMedicalCenterr)
            userDefaults.removeObject(forKey: UserDefaultsConstants.medicalCenterCurrentApiToken)
            userDefaults.removeObject(forKey: UserDefaultsConstants.medicalCenterCurrentUSERID)
        }
        userDefaults.removeObject(forKey: UserDefaultsConstants.MainLoginINDEX)
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        userDefaults.synchronize()
        baseSlid.closeMenu()
        
        DispatchQueue.main.async {
            self.customDoctorMainHomeLeftView.userImage.image = #imageLiteral(resourceName: "Group 4143")
            self.customDoctorMainHomeLeftView.userNameLabel.text = ""
        }
    }
    
    //TODO: -handle methods
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
