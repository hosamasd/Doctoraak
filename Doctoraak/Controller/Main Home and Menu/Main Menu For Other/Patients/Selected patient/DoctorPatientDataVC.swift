//
//  DoctorPatientDataVC.swift
//  Doctoraak
//
//  Created by hosam on 4/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class DoctorPatientDataVC: CustomBaseViewVC {
    
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
    lazy var customDoctorDataView:CustomDoctorDataView = {
        let v = CustomDoctorDataView()
        v.patient = patient
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.okButton.addTarget(self, action: #selector(handleOk), for: .touchUpInside)
        v.cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        v.patientCell.PatientProfileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomImage)))
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
    lazy var customAlertMainLoodingssView:CustomUpdateSserProfileView = {
        let v = CustomUpdateSserProfileView()
        v.okButton.setTitle("Ok".localized, for: .normal)
        v.discriptionInfoLabel.text = "Are You Sure You Want To cancel this Order?\n".localized
        v.handleLogoutTap = {[unowned self] in
            self.removeViewWithAnimation(vvv: self.customAlertMainLoodingssView)
            self.customMainAlertVC.dismiss(animated: true)
            self.performCancelPatient()
        }
        v.handleCancelTap = {[unowned self] in
            self.removeViewWithAnimation(vvv: self.customAlertMainLoodingssView)
            self.customMainAlertVC.dismiss(animated: true)
        }
        return v
    }()
    lazy var customAlertMainLoodingViewss:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "26048-info-bounce")
        v.handleOkTap = {[unowned self] in
            self.handleDismiss()
        }
        return v
    }()
    
    fileprivate let patient:DoctorGetPatientsFromClinicModel!
    fileprivate let index:Int!
    
    init(patient:DoctorGetPatientsFromClinicModel,index:Int) {
        self.patient=patient
        self.index=index
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getArrayDefaults()
    }
    
    
    
    
    
    //MARK:-User methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customDoctorDataView)
        customDoctorDataView.fillSuperview()
        
        
        
    }
    
    fileprivate func getArrayDefaults()  {
        if let doc = userDefaults.value(forKey: UserDefaultsConstants.acceptArrayDoc) as? [Int] {
            customDoctorDataView.accepetArrayDOC=doc.count > 0 ? doc.uniques : nil
        }
        if let doc = userDefaults.value(forKey: UserDefaultsConstants.acceptArrayMedicalCenter) as? [Int] {
            customDoctorDataView.accepetArrayMEDICALCENTER=doc.count > 0 ? doc.uniques : nil
        }
    }
    
    fileprivate func performCancelPatient()  {
        let userId = patient.id
        guard  let doctor =  cacheDoctorObjectCodabe.storedValue  else {return}
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder(cc: customMainAlertVC, v: customAlertMainLoodingView)
        
        
        DoctorServices.shared.rejectClinicOrder(user_id: userId, api_token: doctor.apiToken, doctor_id: doctor.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            
            guard let user = base else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.makeThis(s:MOLHLanguage.isRTLLanguage() ? user.message ?? "" : user.messageEn ?? "")
                //                SVProgressHUD.showInfo(withStatus: MOLHLanguage.isRTLLanguage() ? user.message ?? "" : user.messageEn ?? "")
                //                self.showToast(context: self, msg: MOLHLanguage.isRTLLanguage() ? user.message ?? "" : user.messageEn ?? "")
                self.makeAction(self.patient.id)
            }
        }
    }
    
    fileprivate func makeThis(s:String)  {
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingViewss, height: 250)
        customAlertMainLoodingViewss.discriptionInfoLabel.text = s
        present(customMainAlertVC, animated: true)
    }
    
    fileprivate func makeAction(_ id:Int)  {
        if index==1 {
            customDoctorDataView.accepetArrayMEDICALCENTER?.append(id)
        }  else    {
            customDoctorDataView.accepetArrayDOC?.append(id)
        }
        
        saveDefaULTS()
        self.customDoctorDataView.bottomStack.isHide(true)
    }
    
    fileprivate func saveDefaULTS()  {
        userDefaults.set(customDoctorDataView.accepetArrayDOC, forKey: UserDefaultsConstants.acceptArrayDoc)
        userDefaults.set(customDoctorDataView.accepetArrayMEDICALCENTER, forKey: UserDefaultsConstants.acceptArrayMedicalCenter)
        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
        userDefaults.synchronize()
    }
    
    //TODO:-Handle methods
    
    @objc  func handleZoomImage()  {
        let img:UIImage = #imageLiteral(resourceName: "user")
        
        let zoom = ZoomUserImageVC(img: customDoctorDataView.patientCell.PatientProfileImage.image ?? img)
        navigationController?.pushViewController(zoom, animated: true)
    }
    
    @objc   func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleOk()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleCancel()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingssView, height: 300)
        present(customMainAlertVC, animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingssView)
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        removeViewWithAnimation(vvv: customAlertMainLoodingViewss)
        DispatchQueue.main.async {
            self.customMainAlertVC.dismiss(animated: true, completion: nil)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
