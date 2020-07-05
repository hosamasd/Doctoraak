//
//  DoctorHomeVC.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH
//import 

var chossedClinic:ClinicGetDoctorsModel?


class DoctorHomeVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customDoctorHomeView:CustomDoctorHomeView = {
        let v = CustomDoctorHomeView()
        v.listImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenMenu)))
        v.notifyImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleNotification)))
        v.handleSelectedIndex = {[unowned self] indexPath in
            self.goToSpecifyIndex(indexPath)
        }
        [v.allButton,v.newButton,v.continueButton,v.consultaionButton].forEach({$0.addTarget(self, action: #selector(handleFilterData), for: .touchUpInside)})
        v.handleChoosedClinicID = {[unowned self] index in
            self.getDataAccordingToIndex(index)
        }
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    var docotrClinicID = [Int]()
    
    var doctorPatientsArray = [PatientModel]()
    
    var docotrAllPatientsArray = [DoctorGetPatientsFromClinicModel]()
    
    var filterDoctorPatientsArray = [DoctorGetPatientsFromClinicModel]()
    var isFilter:Bool = false
    
    var doc:DoctorModel?{
        didSet{
            guard let lab = doc else { return  }
            customDoctorHomeView.topDoctorHomeCell.doctor=lab
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedDoctor) ? () : checkData()
        }
    }
    var numberOfClinicsAvaiable = [String]()
    var doctorsClinicArray:[ClinicGetDoctorsModel] = [ClinicGetDoctorsModel]()
    
    fileprivate let index:Int!
    init(inde:Int) {
        self.index = inde
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if userDefaults.bool(forKey: UserDefaultsConstants.DoctorPerformLogin) {
            doc = cacheDoctorObjectCodabe.storedValue
        }
    }
    
    //MARK:-User methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubview(customDoctorHomeView)
        customDoctorHomeView.fillSuperview()
        
    }
    
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
        guard   let qq = customDoctorHomeView.topDoctorHomeCell.doctorClinicDrop.selectedIndex,let doc = doc else {return}
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
            
            self.customDoctorHomeView.docotrCollectionView.doctorPatientsArray = patients
            
            DispatchQueue.main.async {
                self.customDoctorHomeView.topDoctorHomeCell.doctorReservationLabel.text = "\(patients.count) "+"Reservation ".localized
                
                self.customDoctorHomeView.docotrCollectionView.collectionView.reloadData()
                //                                          self.view.layoutIfNeeded()
            }
        }
    }
    
    func putClinics(_ gg:MainClinicGetDoctorsModel?)  {
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
                self.customDoctorHomeView.topDoctorHomeCell.numberOfReserve = patients.count
                
                self.customDoctorHomeView.topDoctorHomeCell.doctorReservationLabel.text = "\(patients.count) "+"Reservation ".localized
                self.customDoctorHomeView.topDoctorHomeCell.doctor = self.doc
                self.customDoctorHomeView.docotrCollectionView.doctorPatientsArray = patients
                
                
            }
            if group2?.data != nil && group2!.data!.count > 0 {
                if let clinics = group2?.data {
                    self.doctorsClinicArray=clinics
                    for n in 1...clinics.count  {
                        let s = "Clinic \(n)"
                        self.numberOfClinicsAvaiable.append(s)
                    }
                    
                    self.customDoctorHomeView.topDoctorHomeCell.numberOfClinics = self.numberOfClinicsAvaiable.count
                    self.customDoctorHomeView.topDoctorHomeCell.mainDropView.isHide(self.numberOfClinicsAvaiable.count > 0 ? false : true)
                    self.customDoctorHomeView.topDoctorHomeCell.doctorReservationLabel.isHide(self.numberOfClinicsAvaiable.count > 0 ? false : true)
                    
                    //                self.customDoctorHomeView.topDoctorHomeCell.doctorReservationLabel.isHide(self.numberOfClinicsAvaiable.count > 0 ? false : true)
                    self.customDoctorHomeView.topDoctorHomeCell.doctorClinicDrop.optionArray = self.numberOfClinicsAvaiable
                    self.customDoctorHomeView.topDoctorHomeCell.doctorClinicDrop.text = "Clinic 1".localized
                    self.customDoctorHomeView.topDoctorHomeCell.doctorClinicDrop.selectedIndex = 0
                    
                    
                    self.customDoctorHomeView.docotrCollectionView.collectionView.reloadData()
                    userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedDoctor)
                    userDefaults.set(self.numberOfClinicsAvaiable, forKey: UserDefaultsConstants.DoctornumberOfClinicsAvaiable)
                    
                    userDefaults.synchronize()
                }
                self.view.layoutIfNeeded()
                
            } }
    }
    
    fileprivate func putUserPhoto(doctor:DoctorModel)  {
        customDoctorHomeView.topDoctorHomeCell.doctor = doctor
        
        
    }
    
    fileprivate func goToSpecifyIndex(_ indexx:IndexPath)  {
        print(indexx.item)
        let patients = isFilter ? filterDoctorPatientsArray[indexx.item] : docotrAllPatientsArray[indexx.item]
        
        let patient = DoctorPatientDataVC(patient: patients)
        navigationController?.pushViewController(patient, animated: true)
        
    }
    
    fileprivate func takeTag(_ bt:UIButton,btns:UIButton...,tag:Int)  {
        addGradientInSenderAndRemoveOtherss(sender: bt, vvv: btns)
        filterDoctorPatientsArray = tag == 4 ? docotrAllPatientsArray : docotrAllPatientsArray.filter({$0.type.toInt() == tag})
        customDoctorHomeView.docotrCollectionView.doctorPatientsArray = tag == 4 ? docotrAllPatientsArray : filterDoctorPatientsArray
        DispatchQueue.main.async {
            self.customDoctorHomeView.docotrCollectionView.collectionView.reloadData()
            //            self.view.layoutIfNeeded()
        }
    }
    
    //TODO:-Handle methods
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleOpenMenu()  {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
        
    }
    
    @objc func handleFilterData(sender:UIButton)  {
        switch sender.tag {
        case 1:
            takeTag(customDoctorHomeView.newButton, btns: customDoctorHomeView.allButton ,customDoctorHomeView.consultaionButton,customDoctorHomeView.continueButton,tag: 1)
        case 2:
            takeTag(customDoctorHomeView.consultaionButton, btns: customDoctorHomeView.newButton,customDoctorHomeView.allButton,customDoctorHomeView.continueButton,tag: 2)
        case 3:
            takeTag(customDoctorHomeView.continueButton, btns: customDoctorHomeView.newButton,customDoctorHomeView.consultaionButton,customDoctorHomeView.allButton,tag: 3)
        default:
            takeTag(customDoctorHomeView.allButton, btns: customDoctorHomeView.newButton,customDoctorHomeView.consultaionButton,customDoctorHomeView.continueButton,tag: 4)
        }
        isFilter = true
    }
    
    
    
    @objc func handleNotification()  {
        let profile = NotificationVC(index: index, isFromMenu: false)
        profile.doctor=doc
        
        let nav = UINavigationController(rootViewController: profile)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
}

