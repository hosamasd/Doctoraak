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
        v.handleSelectedIndex = {[unowned self] indexPath in
            self.goToSpecifyIndex(indexPath)
        }
        [v.allButton,v.newButton,v.continueButton,v.consultaionButton].forEach({$0.addTarget(self, action: #selector(handleFilterData), for: .touchUpInside)})
        v.handleChoosedClinicID = {[unowned self] index in
            self.getDataAccordingToIndex(index)
        }
        return v
    }()
    //     var currentDoctor:DoctorLoginModel?
    var currentDoctor:DoctorLoginModel!
    var currentLab:LabLoginModel!
    var currentRadiolog:RadiologyLoginModel!
    var currentPharamacy:MainPharamacyLoginModel!
    
    var docotrClinicID = [Int]()
    var doctorApiToken:String = ""
    var doctorId:Int = 0
    
    var doctorPatientsArray = [PatientModel]()
    //    var filterDoctorPatientsArray = [PatientModel]()
    
    var docotrAllPatientsArray = [DoctorGetPatientsFromClinicModel]()
    
    var filterDoctorPatientsArray = [DoctorGetPatientsFromClinicModel]()
    var isFilter:Bool = false
    
    //    fileprivate let index:Int!
    //    init(inde:Int) {
    //        self.index = inde
    //        super.init(nibName: nil, bundle: nil)
    //    }
    var index:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) {
            let welcome = WelcomeVC()
            let nav = UINavigationController(rootViewController: welcome)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }else {
            checkData()
        }
        //                checkData()
    }
    
    //MARK:-User methods
    
    func checkData()  {
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        SVProgressHUD.show(withStatus: "Looding...")
        index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
        if index == 0 && currentDoctor == nil {
            let user_id = userDefaults.integer(forKey: UserDefaultsConstants.doctorCurrentUSERID)
            guard let api_Key = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentApiToken),let name = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentNAME) else { return  }
            doctorApiToken=api_Key
            doctorId=user_id
            var group2: MainClinicGetDoctorsModel?
            var group1:DoctorLoginModel?
            var group3:MainDoctorGetPatientsFromClinicModel?
            
            
            let semaphore = DispatchSemaphore(value: 0)
            
            let dispatchQueue = DispatchQueue.global(qos: .background)
            
            
            dispatchQueue.async {
                // using user location
                
                
                RegistrationServices.shared.updateDoctorProfile(user_id: user_id, api_token: api_Key, name: name) {[unowned self] (base, err) in
                    if let err=err{
                        SVProgressHUD.showError(withStatus: err.localizedDescription)
                        self.activeViewsIfNoData();return
                        //
                    }
                    guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn);  self.activeViewsIfNoData(); return}
                    //                group1 = user
                    group1=user
                    //                    self.putUserPhoto(doctor:user)
                    semaphore.signal()
                    
                }
                semaphore.wait()
                
                DoctorServices.shared.getDocotrsClinic(api_token: api_Key, doctor_id: user_id) {[unowned self] (base, err) in
                    
                    
                    if let err = err {
                        SVProgressHUD.showError(withStatus: err.localizedDescription)
                        self.activeViewsIfNoData();return
                    }
                    group2 = base
                    self.putClinics(group2)
                    semaphore.signal()
                }
                semaphore.wait()
                
                DoctorServices.shared.getDocotrsPatientsInClinic(clinic_id: self.docotrClinicID.first ?? 1 , api_token: api_Key, doctor_id: user_id) {[unowned self] (base, err) in
                    if let err = err {
                        SVProgressHUD.showError(withStatus: err.localizedDescription)
                        self.activeViewsIfNoData();return
                    }
                    group3 = base
                    semaphore.signal()
                }
                semaphore.wait()
                
                semaphore.signal()
                self.reloadMainData(group2: group2,group1,group3)
                semaphore.wait()
            }
        }
    }
    
    func getDataAccordingToIndex(_ index:Int)  {
        let clinicId = self.docotrClinicID[index]
        SVProgressHUD.show(withStatus: "Looding...")
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        
        DoctorServices.shared.getDocotrsPatientsInClinic(clinic_id: clinicId, api_token: doctorApiToken, doctor_id: doctorId) {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let patients = base?.data else {SVProgressHUD.showError(withStatus: base?.message); self.activeViewsIfNoData(); return}
            self.docotrAllPatientsArray = patients
            
            self.customDoctorHomeView.docotrCollectionView.doctorPatientsArray = patients
            
            DispatchQueue.main.async {
                self.customDoctorHomeView.topDoctorHomeCell.doctorReservationLabel.text = "\(patients.count) Reservation "
                
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
    
    fileprivate func reloadMainData(group2:MainClinicGetDoctorsModel?,_ docotr:DoctorLoginModel?,_ mains:MainDoctorGetPatientsFromClinicModel?) {
        var clinicsss = [String]()
        
        DispatchQueue.main.async {
            
            
            SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents() // disbale all events in the screen
            
            if let group1 = docotr ,let clinic = group2?.data,let patients=mains?.data{
                patients.forEach { (pp) in
                    self.doctorPatientsArray.append(pp.patient)
                    
                }
                for n in 1...patients.count  {
                    let s = "Clinic \(n)"
                    clinicsss.append(s)
                }
                self.docotrAllPatientsArray = patients
                self.customDoctorHomeView.topDoctorHomeCell.doctorClinicDrop.optionArray = clinicsss
                self.customDoctorHomeView.topDoctorHomeCell.doctorClinicDrop.text = "Clinic 1"
                self.customDoctorHomeView.topDoctorHomeCell.doctorClinicDrop.selectedIndex = 0
                
                self.customDoctorHomeView.topDoctorHomeCell.doctorReservationLabel.text = "\(patients.count) Reservation "
                self.customDoctorHomeView.topDoctorHomeCell.doctor = group1
                self.customDoctorHomeView.docotrCollectionView.doctorPatientsArray = patients
                self.customDoctorHomeView.docotrCollectionView.collectionView.reloadData()
                self.view.layoutIfNeeded()
                UIApplication.shared.endIgnoringInteractionEvents() // disbale all events in the screen
            }
            
            
            //           }
            
        }
    }
    
    func putUserPhoto(doctor:DoctorLoginModel)  {
        customDoctorHomeView.topDoctorHomeCell.doctor = doctor
        
        
    }
    
    
    func fetchData()  {
        
    }
    
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
    
    func goToSpecifyIndex(_ indexx:IndexPath)  {
        print(indexx.item)
        let patients = isFilter ? filterDoctorPatientsArray[indexx.item] : docotrAllPatientsArray[indexx.item]
        
        let patient = DoctorPatientDataVC(patient: patients)
        navigationController?.pushViewController(patient, animated: true)
        
    }
    
    //TODO:-Handle methods
    
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
    
    func takeTag(_ bt:UIButton,btns:UIButton...,tag:Int)  {
        addGradientInSenderAndRemoveOtherss(sender: bt, vvv: btns)
        filterDoctorPatientsArray = tag == 4 ? docotrAllPatientsArray : docotrAllPatientsArray.filter({$0.type.toInt() == tag})
        customDoctorHomeView.docotrCollectionView.doctorPatientsArray = tag == 4 ? docotrAllPatientsArray : filterDoctorPatientsArray
        DispatchQueue.main.async {
            self.customDoctorHomeView.docotrCollectionView.collectionView.reloadData()
            self.view.layoutIfNeeded()
        }
        print(filterDoctorPatientsArray.count)
    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
}
