//
//  VerificationVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SVProgressHUD
import MOLH

class MainVerificationVC: CustomBaseViewVC {
    
    lazy var customVerificationView:CustomMainVerificationView = {
        let v = CustomMainVerificationView()
        v.index = index
        v.id = user_id
        v.resendButton.addTarget(self, action: #selector(handleResendCode), for: .touchUpInside)
        v.confirmButton.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
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
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleDismiss()
        }
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
    fileprivate let isFromDoctor:Bool!
    fileprivate let isFromForgetPassw:Bool!

    fileprivate let phoneNumber:String!
    fileprivate let user_id:Int!
    init(indexx:Int,isFromForgetPassw:Bool,isFromDoctor:Bool,phone:String,user_id:Int) {
        self.index = indexx
        self.isFromForgetPassw = isFromForgetPassw
        self.isFromDoctor=isFromDoctor
        self.phoneNumber = phone
        self.user_id = user_id
        super.init(nibName: nil, bundle: nil)
    }
    
    fileprivate var timer = Timer()
    fileprivate var seconds = 30
    //    let sMSCodeViewModel = SMSCodeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
        setupViewModelObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customVerificationView.firstNumberTextField.becomeFirstResponder()
        //        setupTimer()
    }
    
    func setupViewModelObserver()  {
        customVerificationView.sMSCodeViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            self.changeButtonState(enable: isValid, vv: self.customVerificationView.confirmButton)
        }
        customVerificationView.sMSCodeViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Waiting...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
        
        customVerificationView.sMSCodeViewModel.bindableIsResendingSms.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Resending SMS Code...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customVerificationView)
        customVerificationView.fillSuperview()
    }
    
    
    func setupTimer()  {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        
        
        
    }
    
    fileprivate func upadteLabels() {
        DispatchQueue.main.async {
            self.customVerificationView.timerLabel.textColor = #colorLiteral(red: 0.5667257905, green: 0.9375677705, blue: 0.8425782323, alpha: 1)
            self.customVerificationView.timerLabel.text = self.timeString(time: TimeInterval(self.seconds))
            self.customVerificationView.resendButton.setTitleColor(#colorLiteral(red: 0.7814221978, green: 0.7986494303, blue: 0.843649447, alpha: 1), for: .normal)
            self.customVerificationView.resendButton.isEnabled = false
        }
        
    }
    
    func resetViewModel()  {
        customVerificationView.sMSCodeViewModel.smsCode = nil
        customVerificationView.sMSCodeViewModel.sms2Code = nil
        customVerificationView.sMSCodeViewModel.sms3Code = nil
        customVerificationView.sMSCodeViewModel.sms4Code = nil
        [customVerificationView.firstNumberTextField,customVerificationView.secondNumberTextField,customVerificationView.thirdNumberTextField,customVerificationView.forthNumberTextField,customVerificationView.fifthNumberTextField].forEach({$0.text = ""})
    }
    
    fileprivate func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i",  minutes, seconds)
    }
    
    fileprivate func resetViews()  {
        timer.invalidate()
        seconds = 30
        self.customVerificationView.timerLabel.text = "00:00"
        self.customVerificationView.timerLabel.textColor = #colorLiteral(red: 0.7814221978, green: 0.7986494303, blue: 0.843649447, alpha: 1)
        self.customVerificationView.resendButton.setTitleColor(#colorLiteral(red: 0.6663027406, green: 0.8534387946, blue: 0.9110504985, alpha: 1), for: .normal)
        self.customVerificationView.resendButton.isEnabled = true
    }
    
    func updateStates(api_token:String,_ doctor_id:Int)  {
        let ss = index == 0 ? UserDefaultsConstants.isUserRegisterAndWaitForClinicData  : index == 2 ? UserDefaultsConstants.labPerformLogin : index == 3 ? UserDefaultsConstants.radiologyPerformLogin : UserDefaultsConstants.pharamacyPerformLogin
        let ids = index == 0 ? UserDefaultsConstants.DoctorVerificationDoctorId : index == 2 ? UserDefaultsConstants.labVerificationLabId : index == 3 ? UserDefaultsConstants.RadiologyVerificationRadiologyId : UserDefaultsConstants.PharamacyVerificationPharamacyId
        
        let sss = index == 0 ? UserDefaultsConstants.DoctorVerificationAPITOKEN : index == 2 ? UserDefaultsConstants.labVerificationAPITOKEN : index == 3 ? UserDefaultsConstants.RadiologyVerificationAPITOKEN : UserDefaultsConstants.PharamacyVerificationAPITOKEN
        
        userDefaults.set(true, forKey: ss)
        userDefaults.set(false, forKey: UserDefaultsConstants.isClinicWorkingHoursCached)
        
        userDefaults.set(api_token, forKey: sss)
        userDefaults.set(doctor_id, forKey: ids)
        
        if index == 0 || index == 1 {
            userDefaults.set(index, forKey: UserDefaultsConstants.isUserRegisterAndWaitForClinicDataIndex)
            
        }
        userDefaults.synchronize()
    }
    
    func goToNext()  {
        if  isFromDoctor {
            guard let ss = cacheDoctorObjectCodabe.storedValue else{return}
            
            let vc =  DoctorClinicDataVC(indexx: index,api_token: ss.apiToken,doctor_id: ss.id)
            navigationController?.pushViewController(vc, animated: true)
        }else if isFromForgetPassw {
            let login = MainLoginsVC(indexx: index)
            navigationController?.pushViewController(login, animated: true)
        }else {
            dismiss(animated: true)
        }
        
    }
    
    // Resending
    
    func checkLabLoginStateResend()  {
        customVerificationView.sMSCodeViewModel.performResendLABSMSCode {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard (base?.data) != nil else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            SVProgressHUD.showSuccess(withStatus: "SMS Code is sent again....".localized);return
        }}
    
    func checkRadLoginStateResend()  {
        customVerificationView.sMSCodeViewModel.performResendRADSMSCode {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard (base?.data) != nil else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            SVProgressHUD.showSuccess(withStatus: "SMS Code is sent again....".localized);return
        }}
    
    func checkDoctorLoginStateResend()  {
        customVerificationView.sMSCodeViewModel.performResendDOCSMSCode {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard (base?.data) != nil else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            SVProgressHUD.showSuccess(withStatus: "SMS Code is sent again....".localized);return
        }}
    
    func checkPharamacyLoginStateResend()  {
        customVerificationView.sMSCodeViewModel.performResendPHYSMSCode {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard (base?.data) != nil else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            SVProgressHUD.showSuccess(withStatus: "SMS Code is sent again....".localized);return
        }}
    
    
    func checkPharamacyLoginState()  {
        customVerificationView.sMSCodeViewModel.performPHARAMACYRegister {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            DispatchQueue.main.async {
                self.savePharToken(doctor: user)
            } } }
    
    func checkDoctorLoginState()  {
        customVerificationView.sMSCodeViewModel.performDoctorRegister {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.saveDoctorToken(doctor: user)
            }
        }
    }
    
    
    func checkRadLoginState()  {
        customVerificationView.sMSCodeViewModel.performRADRegister {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.saveRadToken(doctor: user)
            }
        }
    }
    
    func checkLabLoginState()  {
        customVerificationView.sMSCodeViewModel.performLABRegister {[unowned self] (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            DispatchQueue.main.async {
                self.saveLabToken(doctor: user)
                //                self.saveLABToken(mobile: phone, index: self.index, user_id: user.id)
            }
        }
    }
    
    
    func saveDoctorToken(doctor:DoctorLoginModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.isDoctorWaitForClinic)
//        userDefaults.set(true, forKey: UserDefaultsConstants.DoctorPerformLogin)
        userDefaults.set(false, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        
        userDefaults.synchronize()
        
        cacheDoctorObjectCodabe.save(doctor)
        goToNext()
    }
    
    func saveRadToken(doctor:RadiologyModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.radiologyPerformLogin)
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        userDefaults.set(false, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        
        userDefaults.synchronize()
        
        cachdRADObjectCodabe.save(doctor)
        goToNext()
        
    }
    
    func saveLabToken(doctor:LabModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.labPerformLogin)
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        userDefaults.set(false, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        
        userDefaults.synchronize()
        
        cacheLABObjectCodabe.save(doctor)
        goToNext()
        
    }
    
    func savePharToken(doctor:PharamacyModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.pharamacyPerformLogin)
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        userDefaults.set(false, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        
        userDefaults.synchronize()
        removeCachedWorkingHours()
        cachdPHARMACYObjectCodabe.save(doctor)
        goToNext()
        
    }
    
    func removeCachedWorkingHours()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.isLabWorkingHoursCached) {
            cacheLABObjectWorkingHours.deleteFile(cacheLABObjectWorkingHours.storedValue!)
        }else   if userDefaults.bool(forKey: UserDefaultsConstants.isPHYWorkingHoursCached) {
            cachdPHARMACYObjectWorkingHours.deleteFile(cachdPHARMACYObjectWorkingHours.storedValue!)
        }else   if userDefaults.bool(forKey: UserDefaultsConstants.isRADWorkingHoursCached) {
            cachdRADObjectWorkingHours.deleteFile(cachdRADObjectWorkingHours.storedValue!)
        }
    }
    
    //TODO: -handle Methods
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func updateTimer() {
        if seconds == 0 {
            resetViews()
        }else {
            seconds -= 1
            
            upadteLabels()
        }
    }
    
    @objc func handleResendCode()  {
        
        
        index == 0 || index == 1 ? checkDoctorLoginStateResend() : index == 4 ? checkPharamacyLoginStateResend() : index == 2 ? checkLabLoginStateResend() : checkRadLoginStateResend()
        setupTimer()
        resetViewModel()
    }
    
    @objc  func handleConfirm()  {
        resetViews()
        index == 0 || index == 1 ? checkDoctorLoginState() : index == 4 ? checkPharamacyLoginState() : index == 2 ? checkLabLoginState() : checkRadLoginState()
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
