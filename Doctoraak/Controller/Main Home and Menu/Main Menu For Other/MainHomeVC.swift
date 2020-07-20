//
//  MainHomeVC.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

var chossedClinic:ClinicGetDoctorsModel?


class MainHomeVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator=false
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 900)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customMainHomeView:CustomMainHomeView = {
        let v = CustomMainHomeView()
        
        v.listImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenMenu)))
        v.notifyImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenNotifications)))
        v.handledisplayRADNotification = {[unowned self] noty,ind in
            guard let phy=self.rad else {return}
            let patient = SelectedPharmacyPatientDataVC(inde: self.index!, isFromMain: true)
            patient.delgate = self
            patient.radOrder = noty
            patient.indexPath=ind
            
            patient.rad=cachdRADObjectCodabe.storedValue ?? self.rad
            self.navigationController?.pushViewController(patient, animated: true)
        }
        v.handledisplayLABNotification = {[unowned self] noty,ind in
            guard let phy=self.lab else {return}
            let patient = SelectedPharmacyPatientDataVC(inde: self.index!, isFromMain: true)
            patient.delgate = self
            //            patient.labOrderss = noty.details.first?.labOrder
            patient.labOrder = noty
            patient.lab = cacheLABObjectCodabe.storedValue ?? self.lab
            patient.indexPath=ind
            self.navigationController?.pushViewController(patient, animated: true)
        }
        v.handledisplayPHYNotification = {[unowned self] noty,ind in
            guard let phy=self.phy else {return}
            let patient = SelectedPharmacyPatientDataVC(inde: self.index!, isFromMain: true)
            patient.phy = cachdPHARMACYObjectCodabe.storedValue ?? self.phy
            patient.phyOrder=noty
            patient.delgate = self
            patient.indexPath=ind
            
            self.navigationController?.pushViewController(patient, animated: true)
        }
        v.handleDoctorSelectedIndex = {[unowned self] indexPath in
            self.goToSpecifyIndex(indexPath)
        }
        [v.allButton,v.newButton,v.continueButton,v.consultaionButton].forEach({$0.addTarget(self, action: #selector(handleFilterData), for: .touchUpInside)})
        v.handleChoosedClinicID = {[unowned self] index in
            let ss = self.doctorsClinicArray[index]
            self.addAndRemoveCacheClinicWorkingHours(clinics: ss)
            self.getDataAccordingToIndex(index)
        }
        v.handleRefreshCollection={[unowned self] in
            self.fetchOrders()
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
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleDismiss()
        }
        return v
    }()
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
            customMainHomeView.lab=lab
            customMainHomeView.topMainHomeCell.lab=lab
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched) ? () : fetchOrders()
            
        }
    }
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            customMainHomeView.phy=phy
            customMainHomeView.topMainHomeCell.phy=phy
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched) ? () : fetchOrders()
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            customMainHomeView.rad=lab
            customMainHomeView.topMainHomeCell.rad=lab
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched) ? () : fetchOrders()
        }
    }
    var doc:DoctorModel?{
        didSet{
            guard let lab = doc else { return  }
            customMainHomeView.doctor=lab
            customMainHomeView.topMainHomeCell.doctor=lab
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched) ? () : fetchOrders()
        }
    }
    var medicalCenter:DoctorModel?{
        didSet{
            guard let lab = medicalCenter else { return  }
            customMainHomeView.medicalCenter=lab
            customMainHomeView.topMainHomeCell.medicalCenter=lab
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched) ? () : fetchOrders()
        }
    }
    var numberOfClinicsAvaiable = [String]()
    var doctorsClinicArray:[ClinicGetDoctorsModel] = [ClinicGetDoctorsModel]()
    var docotrClinicID = [Int]()
    
    var doctorPatientsArray = [PatientModel]()
    
    var docotrAllPatientsArray = [DoctorGetPatientsFromClinicModel]()
    
    var filterDoctorPatientsArray = [DoctorGetPatientsFromClinicModel]()
    var isFilter:Bool = false
    
    var index:Int? {
        didSet{
            guard let index = index else { return  }
            customMainHomeView.index=index
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) && index == nil  {
//            view.alpha = 0
//        }else {
//            view.alpha = 1
//
//            if userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched) {
//
//            }else {
                
                index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
                if userDefaults.bool(forKey: UserDefaultsConstants.DoctorPerformLogin) {
                    doc = cacheDoctorObjectCodabe.storedValue
                }
                if userDefaults.bool(forKey: UserDefaultsConstants.medicalCenterPerformLogin) {
                    medicalCenter = cacheMedicalObjectCodabe.storedValue
                }
                
                if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
                    lab = cacheLABObjectCodabe.storedValue
                }
                if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
                    rad = cachdRADObjectCodabe.storedValue
                }
                if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
                    phy = cachdPHARMACYObjectCodabe.storedValue
                }
                
//            }
//        }
        
        
    }
    //MARK: -user methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    //for doctor and medical center
    
    fileprivate  func checkData()  {
        guard let doc = doc else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
        //        SVProgressHUD.show(withStatus: "Looding...")
        var group2: MainClinicGetDoctorsModel?
        var group3:MainDoctorGetPatientsFromClinicModel?
        
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        
        dispatchQueue.async {
            DoctorServices.shared.getDocotrsClinic(api_token: doc.apiToken, doctor_id: doc.id) {[unowned self] (base, err) in
                
                
                if let err = err {
                    SVProgressHUD.showError(withStatus: err.localizedDescription)
                    self.handleDismiss()
                    self.activeViewsIfNoData();return
                }
                group2 = base
                self.putClinics(group2)
                semaphore.signal()
            }
            semaphore.wait()
            
            DoctorServices.shared.getDocotrsPatientsInClinic(clinic_id: self.docotrClinicID.first ?? 1 , api_token: doc.apiToken, doctor_id: doc.id) {[unowned self] (base, err) in
                if let err = err {
                    SVProgressHUD.showError(withStatus: err.localizedDescription)
                    self.handleDismiss()
                    self.activeViewsIfNoData();return
                }
                group3 = base
                semaphore.signal()
            }
            semaphore.wait()
            
            semaphore.signal()
            self.reloadMainData(group2: group2,group3)
            semaphore.wait()
        }
        
    }
    
    fileprivate  func getDataAccordingToIndex(_ index:Int)  {
        let clinicId = self.docotrClinicID[index]
        guard   let qq = customMainHomeView.topMainHomeCell.doctorClinicDrop.selectedIndex,let doc = doc else {return}
        chossedClinic=doctorsClinicArray[qq]
        //        SVProgressHUD.show(withStatus: "Looding...".localized)
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
        DoctorServices.shared.getDocotrsPatientsInClinic(clinic_id: clinicId, api_token: doc.apiToken, doctor_id: doc.id) {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let patients = base?.data else {SVProgressHUD.showError(withStatus: base?.message); self.activeViewsIfNoData(); return}
            self.docotrAllPatientsArray = patients
            
            self.customMainHomeView.mainHomePatientsCollectionVC.doctorPatientsArray = patients
            
            
            
            DispatchQueue.main.async {
                self.customMainHomeView.topMainHomeCell.doctorReservationLabel.text = "\(patients.count) "+"Reservation ".localized
                
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
                //                                          self.view.layoutIfNeeded()
            }
        }
    }
    
    func addAndRemoveCacheClinicWorkingHours(clinics:ClinicGetDoctorsModel)  {
        if self.index == 0 {
            cacheDoctorObjectClinicWorkingHoursLeftMenu.deleteFile(cacheDoctorObjectClinicWorkingHoursLeftMenu.storedValue ?? clinics)
            cacheDoctorObjectClinicWorkingHoursLeftMenu.save(clinics)
        }
        if self.index == 1 {
            cacheMedicalCenterObjectCodabeClinicWorkingHoursLeftMenu.deleteFile(cacheDoctorObjectClinicWorkingHoursLeftMenu.storedValue ?? clinics)
            cacheMedicalCenterObjectCodabeClinicWorkingHoursLeftMenu.save(clinics)
        }
        userDefaults.set(true, forKey: UserDefaultsConstants.isSpecifiedIndexClincChoosed)
        userDefaults.synchronize()
    }
    
    fileprivate  func putClinics(_ gg:MainClinicGetDoctorsModel?)  {
        guard let cc = gg?.data else { return  }
        cc.forEach { (c) in
            let d = c.workingHours.first?.clinicID
            docotrClinicID.append(d ?? 1)
        }
    }
    
    
    
    fileprivate func reloadMainData(group2:MainClinicGetDoctorsModel?,_ mains:MainDoctorGetPatientsFromClinicModel?) {
        
        DispatchQueue.main.async {
            
            self.handleDismiss()
            //            SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents() // disbale all events in the screen
            if let patients=mains?.data {
                patients.forEach { (pp) in
                    self.doctorPatientsArray.append(pp.patient)
                    
                }
                self.docotrAllPatientsArray = patients
                self.customMainHomeView.topMainHomeCell.reservation = patients.count
                
                //                self.customMainHomeView.topDoctorHomeCell.doctorReservationLabel.text = "\(patients.count) "+"Reservation ".localized
                self.customMainHomeView.topMainHomeCell.doctor = self.doc
                self.customMainHomeView.mainHomePatientsCollectionVC.doctorPatientsArray = patients
                
                
            }
            if group2?.data != nil && group2!.data!.count > 0 {
                if let clinics = group2?.data {
                    self.doctorsClinicArray=clinics
                    for n in 1...clinics.count  {
                        let s = "Clinic \(n)"
                        self.numberOfClinicsAvaiable.append(s)
                    }
                    
                    self.customMainHomeView.topMainHomeCell.numberOfClinics = self.numberOfClinicsAvaiable.count
                    self.customMainHomeView.topMainHomeCell.mainDropView.isHide(self.numberOfClinicsAvaiable.count > 0 ? false : true)
                    self.customMainHomeView.topMainHomeCell.doctorReservationLabel.isHide(self.numberOfClinicsAvaiable.count > 0 ? false : true)
                    let xc = mains?.data?.count ?? 0
                    
                    self.customMainHomeView.topMainHomeCell.reservation = xc
                    let urlString = clinics.first?.photo
                    self.customMainHomeView.topMainHomeCell.urlString=urlString
                    //                                   self.customMainHomeView.topDoctorHomeCell.doctorReservationLabel.text = "\(xc) "+"Reservation ".localized
                    self.customMainHomeView.topMainHomeCell.doctorClinicDrop.optionArray = self.numberOfClinicsAvaiable
                    self.customMainHomeView.topMainHomeCell.doctorClinicDrop.text = "Clinic 1".localized
                    self.customMainHomeView.topMainHomeCell.doctorClinicDrop.selectedIndex = 0
                    
                    
                    userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
                    userDefaults.set(self.numberOfClinicsAvaiable, forKey: UserDefaultsConstants.DoctornumberOfClinicsAvaiable)
                    
                    userDefaults.synchronize()
                    self.addAndRemoveCacheClinicWorkingHours(clinics: clinics.first!)

                    
                    
                    self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.refreshControl?.beginRefreshing()
                    self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.refreshControl?.endRefreshing()
                    self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()

                }
                self.view.layoutIfNeeded()
                
            } }
    }
    
    //MARK:-oTHER MODULES
    
    
    
    fileprivate func getObjects()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
            lab = cacheLABObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
            rad = cachdRADObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
            phy = cachdPHARMACYObjectCodabe.storedValue
        }
    }
    
    fileprivate   func fetchOrders()  {
        index == 0 || index == 1 ? checkData() :  index == 2 ? fetchOrdersLAB() : index == 3 ? fetchOrdersRAD() : fetchOrdersPHY()
    }
    
    fileprivate func fetchOrdersLAB()  {
        guard let phy = lab else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        OrdersServices.shared.fetchLABOrders(api_token: phy.apiToken, lab_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
            userDefaults.set(true, forKey: UserDefaultsConstants.isMainDataFetched)
            userDefaults.synchronize()
            DispatchQueue.main.async {
                self.customMainHomeView.mainHomePatientsCollectionVC.notificationLABArray=user
                self.customMainHomeView.topMainHomeCell.reservation = user.count > 0 ?  user.count : 0
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.refreshControl?.beginRefreshing()
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.refreshControl?.endRefreshing()
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
            }
        }
    }
    
    fileprivate  func fetchOrdersRAD()  {
        guard let phy = rad else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        OrdersServices.shared.fetchRADOrders(api_token: phy.apiToken, radiology_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedRAD)
            userDefaults.synchronize()
            self.customMainHomeView.mainHomePatientsCollectionVC.notificationRADArray=user
            userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
            userDefaults.synchronize()
            DispatchQueue.main.async {
                self.customMainHomeView.topMainHomeCell.reservation = user.count > 0 ?  user.count : 0
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.refreshControl?.beginRefreshing()
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.refreshControl?.endRefreshing()
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func fetchOrdersPHY()  {
        guard let phy = phy else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        OrdersServices.shared.fetchPharmacyOrders(api_token: phy.apiToken, pharmacy_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
            userDefaults.synchronize()
            DispatchQueue.main.async {
                self.customMainHomeView.mainHomePatientsCollectionVC.notificationPHYArray=user
                self.customMainHomeView.topMainHomeCell.reservation = user.count > 0 ?  user.count : 0
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.refreshControl?.beginRefreshing()
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.refreshControl?.endRefreshing()
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
                
            }
        }
        
    }
    
    
    
    override func setupViews()  {
        //        view.backgroundColor = .red
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubview(customMainHomeView)
        customMainHomeView.fillSuperview()
        
    }
    
    fileprivate func goToSpecifyIndex(_ indexx:IndexPath)  {
        print(indexx.item)
        guard let index = index else { return  }
        let patient = PatientDataVC(inde: index)
        navigationController?.pushViewController(patient, animated: true)
        
    }
    
    fileprivate func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    fileprivate func takeTag(_ bt:UIButton,btns:UIButton...,tag:Int)  {
        addGradientInSenderAndRemoveOtherss(sender: bt, vvv: btns)
        filterDoctorPatientsArray = tag == 4 ? docotrAllPatientsArray : docotrAllPatientsArray.filter({$0.type.toInt() == tag})
        customMainHomeView.mainHomePatientsCollectionVC.doctorPatientsArray = tag == 4 ? docotrAllPatientsArray : filterDoctorPatientsArray
        DispatchQueue.main.async {
            self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
        }
    }
    
    //TODO:-Hnadle methods
    
    @objc func handleOpenMenu()  {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
        
    }
    
    @objc func handleDismiss()  {
        
        
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc func handleOpenNotifications()  {
        let mainIndex = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
        phy = cachdPHARMACYObjectCodabe.storedValue
        let notify = NotificationVC( index: mainIndex, isFromMenu: false)
        notify.phy=phy
        notify.rad=rad
        notify.lab=lab
        let nav = UINavigationController(rootViewController: notify)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func handleFilterData(sender:UIButton)  {
        switch sender.tag {
        case 1:
            takeTag(customMainHomeView.newButton, btns: customMainHomeView.allButton ,customMainHomeView.consultaionButton,customMainHomeView.continueButton,tag: 1)
        case 2:
            takeTag(customMainHomeView.consultaionButton, btns: customMainHomeView.newButton,customMainHomeView.allButton,customMainHomeView.continueButton,tag: 2)
        case 3:
            takeTag(customMainHomeView.continueButton, btns: customMainHomeView.newButton,customMainHomeView.consultaionButton,customMainHomeView.allButton,tag: 3)
        default:
            takeTag(customMainHomeView.allButton, btns: customMainHomeView.newButton,customMainHomeView.consultaionButton,customMainHomeView.continueButton,tag: 4)
        }
        isFilter = true
    }
}

//MARK:-extension


extension MainHomeVC: SelectedPharmacyPatientDataProtocol {
    
    func deletePHY(indexPath: IndexPath, index: Int) {
        customMainHomeView.topMainHomeCell.reservation! -= 1
        if index == 0 || index == 1 {
            customMainHomeView.mainHomePatientsCollectionVC.doctorPatientsArray.remove(at: indexPath.item)
        }else if index == 2 {
            customMainHomeView.mainHomePatientsCollectionVC.notificationLABArray.remove(at: indexPath.item)
        }else if index == 3 {
            customMainHomeView.mainHomePatientsCollectionVC.notificationRADArray.remove(at: indexPath.item)
        }else if index == 4 {
            customMainHomeView.mainHomePatientsCollectionVC.notificationPHYArray.remove(at: indexPath.item)
        }
        customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
    }
}

extension MainHomeVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
