//
//  HomeLeftMenuVC.swift
//  Doctoraak
//
//  Created by hosam on 6/14/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit

class HomeLeftMenuVC: CustomBaseViewVC {
    
    
    lazy var customMainHomeLeftView:CustomMainHomeLeftView = {
        let v = CustomMainHomeLeftView()
        v.index = index
        
        v.handleCheckedIndex = {[unowned self] index in
            self.checkIfLoggined(index)
        }
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
            customMainHomeLeftView.lab=lab
        }
    }
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            customMainHomeLeftView.phy=phy
            
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            customMainHomeLeftView.rad=lab
            
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
        [lab,rad,phy].forEach({$0 == nil})
        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
            lab = cacheLABObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
            rad = cachdRADObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
            phy = cachdPHARMACYObjectCodabe.storedValue
        }
    }
    
    //MARK: -user methods
    
    override func setupNavigation()  {
        //        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customMainHomeLeftView)
        customMainHomeLeftView.fillSuperview()
    }
    
    fileprivate func makeSameActions(_ indexPath: IndexPath, _ baseSlid: BaseSlidingVC) {
        if indexPath.item == 2 {
            //            performLogout()
            //            baseSlid.closeMenu()
            showAlertForLogout()
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
        profile.phy=phy
        profile.lab=lab
        profile.rad=rad
        //        profile.doctor=doctor
        let nav = UINavigationController(rootViewController: profile)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    fileprivate func goToSameNotification(_ baseSlid: BaseSlidingVC) {
        baseSlid.closeMenu()
        let profile = NotificationVC(index: index, isFromMenu: true)
        profile.phy=phy
        profile.lab=lab
        //        profile.doctor=doctor
        profile.rad=rad
        let nav = UINavigationController(rootViewController: profile)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    fileprivate func checkIfLoggined(_ indexPath:IndexPath)  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
        if indexPath.section == 0 {
            if indexPath.item == 0  {
                baseSlid.closeMenu()
                let profile = PharamacyProfileVC(index: index)
                profile.phy=phy
                profile.lab=lab
                profile.rad=rad
                let nav = UINavigationController(rootViewController: profile)
                
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            }else if indexPath.item == 1 {
                baseSlid.closeMenu()
                let profile = MainClinicWorkingHoursNotDoctorVC(index: index, isFromUpdateProfile: false,isFromRegister: false)//MainClinicWorkingHoursVCWithoutEditingVC()
                profile.phy=phy
                profile.lab=lab
                profile.rad=rad
                let nav = UINavigationController(rootViewController: profile)
                
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
                
            }else if indexPath.item == 2 {
                goToSameNotification(baseSlid)
            }else if indexPath.item == 3 {
                goToSameAnayltics(baseSlid)
                
            }
        }else {
            makeSameActions(indexPath, baseSlid)
        }
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
    
    fileprivate func showAlertForLogout()  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
        
        
        baseSlid.closeMenu()
        baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertMainLoodingssView, height: 250)
        baseSlid.present(baseSlid.customMainAlertVC, animated: true)
    }
    
    //    fileprivate  func performLogout()  {
    //
    //        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
    //            cacheLABObjectCodabe.deleteFile(lab!)
    //            userDefaults.set(false, forKey: UserDefaultsConstants.labPerformLogin)
    //            userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedLAB)
    //
    //            self.lab=nil
    //
    //        }else if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
    //            cachdRADObjectCodabe.deleteFile(rad!)
    //            userDefaults.set(false, forKey: UserDefaultsConstants.radiologyPerformLogin)
    //            userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedRAD)
    //
    //            self.rad=nil
    //
    //        }else if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
    //            cachdPHARMACYObjectCodabe.deleteFile(phy!)
    //            userDefaults.set(false, forKey: UserDefaultsConstants.pharamacyPerformLogin)
    //            userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedPHY)
    //
    //            self.phy=nil
    //
    //        }
    //        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
    //        userDefaults.removeObject(forKey: UserDefaultsConstants.MainLoginINDEX)
    //
    //        userDefaults.synchronize()
    //        //        goToWelcome()
    //
    //        DispatchQueue.main.async {
    //            self.customMainHomeLeftView.userImage.image = #imageLiteral(resourceName: "Group 4143")
    //            self.customMainHomeLeftView.userNameLabel.text = ""
    //        }
    //    }
    
    fileprivate func goToWelcome()  {
        let welcome = WelcomeVC()
        let nav = UINavigationController(rootViewController: welcome)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func resetUserDefaults()  {
        
    }
    
    fileprivate func createAlerts() {
        let alert = UIAlertController(title: "Warring...".localized, message: "Do You Want To Log Out?".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Log Out".localized, style: .destructive) {[unowned self] (_) in
            //            self.performLogout()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    //TODO: -handle methods
    
    @objc func handleDismiss()  {
        //        removeViewWithAnimation(vvv: customAlertMainLoodingssView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //    @objc func handleLogout()  {
    //
    //        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
    //        baseSlid.closeMenu()
    //        customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertMainLoodingssView, height: 250)
    //        present(customMainAlertVC, animated: true)
    //        //        createAlerts()
    //    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
