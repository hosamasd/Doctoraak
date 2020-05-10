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
        return v
    }()
    //     var currentDoctor:DoctorLoginModel?
    var currentDoctor:DoctorLoginModel!
    var currentLab:LabLoginModel!
    var currentRadiolog:RadiologyLoginModel!
    var currentPharamacy:MainPharamacyLoginModel!
    var doctorPatientsArray = [ClinicGetDoctorsModel]()
    var filterDoctorPatientsArray = [ClinicGetDoctorsModel]()

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
//            checkData()
        }
        //        checkData()
    }
    
    //MARK:-User methods
    
    func checkData()  {
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        SVProgressHUD.show(withStatus: "Looding...")
        index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
        if index == 0 && currentDoctor == nil {
            let user_id = userDefaults.integer(forKey: UserDefaultsConstants.doctorCurrentUSERID)
            guard let api_Key = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentApiToken),let name = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentNAME) else { return  }
            var group2: MainClinicGetDoctorsModel?
            var group1:DoctorLoginModel?
            
            
            let semaphore = DispatchSemaphore(value: 0)
            
            let dispatchQueue = DispatchQueue.global(qos: .background)
            
            
            dispatchQueue.async {
                // using user location
                
                
                RegistrationServices.shared.updateDoctorProfile(user_id: user_id, api_token: api_Key, name: name) { (base, err) in
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
                
                DoctorServices.shared.getDocotrsClinic(api_token: api_Key, doctor_id: user_id) { (base, err) in
                    
                    
                    if let err = err {
                        SVProgressHUD.showError(withStatus: err.localizedDescription)
                        self.activeViewsIfNoData();return
                    }
                    group2 = base
                    semaphore.signal()
                }
                semaphore.wait()
                
                
                 
                
                semaphore.signal()
                           self.reloadMainData(group2: group2,group1)
                           semaphore.wait()
            }
        }
    }
    
    fileprivate func reloadMainData(group2:MainClinicGetDoctorsModel?,_ docotr:DoctorLoginModel?) {
        var clinicsss = [String]()
        
           DispatchQueue.main.async {
               
               
               SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents() // disbale all events in the screen

            if let group1 = docotr ,let clinic = group2?.data{
                self.doctorPatientsArray = clinic
                let dd = clinic.count
                for n in 1...dd  {
                    let s = "Clinic \(n)"
                    clinicsss.append(s)
                }
                self.customDoctorHomeView.topDoctorHomeCell.doctorClinicDrop.optionArray = clinicsss
                self.customDoctorHomeView.topDoctorHomeCell.doctorReservationLabel.text = "\(dd-1) Reservation "
                self.customDoctorHomeView.topDoctorHomeCell.doctor = group1
                self.customDoctorHomeView.docotrCollectionView.doctorPatientsArray = clinic
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
        let patient = DoctorBookVC(inde: index)
        navigationController?.pushViewController(patient, animated: true)
        
    }
    
    //TODO:-Handle methods
    
    @objc func handleOpenMenu()  {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
        
    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
}
