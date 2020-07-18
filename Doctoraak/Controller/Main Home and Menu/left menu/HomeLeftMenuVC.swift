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
        //        v.index = index
        
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
    
    var doctor:DoctorModel?{
        didSet{
            guard let phy = doctor else { return  }
            customMainHomeLeftView.doctor=phy
        }
    }
    
    var medicalCenter:DoctorModel?{
        didSet{
            guard let phy = medicalCenter else { return  }
            customMainHomeLeftView.meidicalCenter=phy
        }
    }
    var index:Int? {
        didSet{
            guard let index = index else { return  }
            customMainHomeLeftView.index=index
        }
    }
    var doctorCacheClinic:ClinicGetDoctorsModel?{
        didSet{
            guard let doctorCacheClinic = doctorCacheClinic else { return  }
        }
    }
    
    
    //    fileprivate let index:Int!
    //    init(index:Int) {
    //        self.index=index
    //        super.init(nibName: nil, bundle: nil)
    //    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
        
        //        [lab,rad,phy].forEach({$0 == nil})
        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
            lab = cacheLABObjectCodabe.storedValue
        }
        if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
            rad = cachdRADObjectCodabe.storedValue
        }
        if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
            phy = cachdPHARMACYObjectCodabe.storedValue
        }
        if userDefaults.bool(forKey: UserDefaultsConstants.DoctorPerformLogin) {
            doctor = cacheDoctorObjectCodabe.storedValue
        }
        if userDefaults.bool(forKey: UserDefaultsConstants.medicalCenterPerformLogin) {
            medicalCenter = cacheMedicalObjectCodabe.storedValue
        }
        
        if userDefaults.bool(forKey: UserDefaultsConstants.isSpecifiedIndexClincChoosed) {
            doctorCacheClinic = cacheDoctorObjectClinicWorkingHoursLeftMenu.storedValue
        }
        
    }
    
    //    fileprivate func getObjects()  {
    //        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
    //            lab = cacheLABObjectCodabe.storedValue
    //            userDefaults.bool(forKey: UserDefaultsConstants.isLABNotificationChanged) ? getNotifications() : ()
    //
    //        }else if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
    //            rad = cachdRADObjectCodabe.storedValue
    //            userDefaults.bool(forKey: UserDefaultsConstants.isRADNotificationChanged) ? getNotifications() : ()
    //
    //        }else if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
    //            phy = cachdPHARMACYObjectCodabe.storedValue
    //            userDefaults.bool(forKey: UserDefaultsConstants.isPHYNotificationChanged) ? getNotifications() : ()
    //        }
    //    }
    
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
        profile.doctor=doctor
        profile.medicalCenter=self.medicalCenter
        //        profile.doctor=doctor
        let nav = UINavigationController(rootViewController: profile)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    fileprivate func goToSameNotification(_ baseSlid: BaseSlidingVC) {
        baseSlid.closeMenu()
        let profile = NotificationVC(index: index!, isFromMenu: true)
        profile.phy=phy
        profile.lab=lab
        profile.doctor=doctor
        profile.medicalCenter=self.medicalCenter
        profile.rad=rad
        let nav = UINavigationController(rootViewController: profile)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    fileprivate func goToClinicWorkingHours(_ baseSlid: BaseSlidingVC,isOnlyShow:Bool,doctor: ClinicGetDoctorsModel? = nil) {
           baseSlid.closeMenu()
           let profile = DoctorClinicWorkingHoursVC(isFromLeftMenu: true, isOnlyShow: isOnlyShow)
//           profile.doctor=chossedClinic
        profile.doctor = doctor
           let nav = UINavigationController(rootViewController: profile)
           
           nav.modalPresentationStyle = .fullScreen
           present(nav, animated: true)
       }
    
    fileprivate func checkIfLoggined(_ indexPath:IndexPath)  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC,let index=index else {return}
        
        if indexPath.section == 0 {
            
            if  index == 0 || index == 1 {
                if indexPath.item == 0 {
                    baseSlid.closeMenu()
                    let profile = DoctorProfileVC(index: index)
                    profile.doc=doctor
                    let nav = UINavigationController(rootViewController: profile)
                    
                    nav.modalPresentationStyle = .fullScreen
                    present(nav, animated: true)
                }else if indexPath.item == 1 {
                    guard let doctor =  cacheDoctorObjectCodabe.storedValue else { return  }
                    baseSlid.closeMenu()
                    
                    let profile = DoctorClinicDataVC(indexx: index, api_token: doctor.apiToken, doctor_id: doctor.id, isFromProfile: true)
                    let nav = UINavigationController(rootViewController: profile)
                    
                    nav.modalPresentationStyle = .fullScreen
                    present(nav, animated: true)
                }else if indexPath.item == 2 {
                    goToClinicWorkingHours(baseSlid,isOnlyShow:false)
                }else if indexPath.item == 3 {
                    goToClinicWorkingHours(baseSlid,isOnlyShow:true,doctor: cacheDoctorObjectClinicWorkingHoursLeftMenu.storedValue)
                }
                else if indexPath.item == 4 {
                    goToSameNotification(baseSlid)
                }else if indexPath.item == 5 {
                    goToSameAnayltics(baseSlid)
                    
                }
            }else {
                
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
                    profile.phy=cachdPHARMACYObjectCodabe.storedValue//phy
                    profile.lab=cacheLABObjectCodabe.storedValue//lab
                    profile.rad=cachdRADObjectCodabe.storedValue//rad
                    let nav = UINavigationController(rootViewController: profile)
                    
                    nav.modalPresentationStyle = .fullScreen
                    present(nav, animated: true)
                    
                }else if indexPath.item == 2 {
                    goToSameNotification(baseSlid)
                }else if indexPath.item == 3 {
                    goToSameAnayltics(baseSlid)
                    
                }
            }
        }else {
            makeSameActions(indexPath, baseSlid)
        }
        
    }
    
    
    fileprivate func chooseLanguage()  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
                
        baseSlid.closeMenu()
        baseSlid.customMainAlertVC.addCustomViewInCenter(views: baseSlid.customAlertChooseLanguageView, height: 200)
        baseSlid.present(baseSlid.customMainAlertVC, animated: true)
    }
    
    fileprivate func showAlertForContacting()  {
        guard let baseSlid = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingVC else {return}
                
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
        let ok = UIAlertAction(title: "Log Out".localized, style: .destructive) { (_) in
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
}
