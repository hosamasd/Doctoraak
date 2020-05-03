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
    
    //check to go specific way
    fileprivate let index:Int!
    fileprivate let isFromForgetPassw:Bool!
    fileprivate let phoneNumber:String!
    fileprivate let user_id:Int!
    init(indexx:Int,isFromForgetPassw:Bool,phone:String,user_id:Int) {
        self.index = indexx
        self.isFromForgetPassw = isFromForgetPassw
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
                SVProgressHUD.show(withStatus: "Waiting...".localized)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
        
        customVerificationView.sMSCodeViewModel.bindableIsResendingSms.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Resending SMS Code...".localized)
                
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
        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForClinicData)
        userDefaults.set(false, forKey: UserDefaultsConstants.isClinicWorkingHoursSaved)

        userDefaults.set(api_token, forKey: UserDefaultsConstants.DoctorVerificationAPITOKEN)
        userDefaults.set(doctor_id, forKey: UserDefaultsConstants.DoctorVerificationDoctorId)

        userDefaults.set(index, forKey: UserDefaultsConstants.isUserRegisterAndWaitForClinicDataIndex)
        userDefaults.synchronize()
    }
    
    func goToNext(api_token:String,_ doctor_id:Int)  {
        self.updateStates(api_token: api_token,doctor_id)
        if  isFromForgetPassw {
            let  vc =  MainNewPassVC(indexx: index)
            navigationController?.pushViewController(vc, animated: true)
        }else {
            
            let vc =  MainClinicDataVC(indexx: index,api_token: api_token,doctor_id: doctor_id)
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    
    //TODO: -handle Methods
    
    @objc fileprivate func updateTimer() {
        if seconds == 0 {
            resetViews()
        }else {
            seconds -= 1
            
            upadteLabels()
        }
    }
    
    @objc func handleResendCode()  {
        setupTimer()
        resetViewModel()
        customVerificationView.sMSCodeViewModel.performResendSMSCode { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            SVProgressHUD.showSuccess(withStatus: "SMS Code is sent again....")
            self.activeViewsIfNoData()
        }
    }
    
    @objc  func handleConfirm()  {
        resetViews()
        customVerificationView.sMSCodeViewModel.performLogging { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn);self.setupTimer(); return}
            
            DispatchQueue.main.async {
                self.goToNext(api_token: user.apiToken,user.id)
            }
        }
        
        
        
        
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
