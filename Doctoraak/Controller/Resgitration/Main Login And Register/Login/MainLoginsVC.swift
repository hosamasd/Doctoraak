//
//  LoginVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class MainLoginsVC: CustomBaseViewVC {
    
    lazy var customLoginsView:CustomLoginsView = {
        let v = CustomLoginsView()
        v.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.forgetPasswordButton.addTarget(self, action: #selector(handleForget), for: .touchUpInside)
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
    init(indexx:Int) {
        self.index = indexx
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginViewModelObserver()
        //        seeee()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customLoginsView.phoneNumberTextField.becomeFirstResponder()
    }
    
    //MARK:-User methods
    
    fileprivate func setupLoginViewModelObserver(){
        
        customLoginsView.loginViewModel.bindableIsFormValidate.bind {[unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            
            self.changeButtonState(enable: isValid, vv: self.customLoginsView.loginButton)
        }
        customLoginsView.loginViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
            }else {
                //                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customLoginsView)
        customLoginsView.fillSuperview()
    }
    
    func saveDoctorToken(doctor:DoctorLoginModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.DoctorPerformLogin)
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        
        userDefaults.synchronize()
        
        cacheDoctorObjectCodabe.save(doctor)
        dismiss(animated: true)
        
    }
    
    func saveRadToken(doctor:RadiologyLoginModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.radiologyPerformLogin)
        
        userDefaults.synchronize()
        
        cachdRADObjectCodabe.save(doctor)
        dismiss(animated: true)
        
    }
    
    func saveLabToken(doctor:LabLoginModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.labPerformLogin)
        
        userDefaults.synchronize()
        
        cacheLABObjectCodabe.save(doctor)
        dismiss(animated: true)
        
    }
    
    func savePharToken(doctor:PharamacyLoginModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.pharamacyPerformLogin)
        
        userDefaults.synchronize()
        
        cachdPHARMACYObjectCodabe.save(doctor)
        dismiss(animated: true)
        
    }
    
    func goToDoctorMainTab(doctor:DoctorLoginModel)  {
        dismiss(animated: true) {
            
        }
        
        let home = BaseSlidingVC()
        home.index=index
        //               home.currentDoctor = doctor
        //        present(home, animated: true, completion: nil)
        navigationController?.pushViewController(home, animated: true)
    }
    
    //TODO: -handle methods
    
    @objc  func handleRegister()  {
        let register = MainRegisterVC(indexx: index)
        navigationController?.pushViewController(register, animated: true)
        
    }
    
    func checkDoctorLoginState()  {
        customLoginsView.loginViewModel.performDoctorLogging {[unowned self] (base, err) in
            if let err = err {
                //                                           SVProgressHUD.showError(withStatus: err.localizedDescription)
                DispatchQueue.main.async {
                    self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                    
                }
                
                self.activeViewsIfNoData();return
            }
            //            SVProgressHUD.dismiss()
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.saveDoctorToken(doctor:user)
            }
        }
    }
    
    func checkPharamacyLoginState()  {
        customLoginsView.loginViewModel.performPharamacyLogging {[unowned self] (base, err) in
            if let err = err {
                //                                           SVProgressHUD.showError(withStatus: err.localizedDescription)
                DispatchQueue.main.async {
                    self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                    
                }
                
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.savePharToken(doctor:user)
            }
        }
    }
    
    
    func checkRadLoginState()  {
        customLoginsView.loginViewModel.performRadLogging {[unowned self] (base, err) in
            if let err = err {
                //                                           SVProgressHUD.showError(withStatus: err.localizedDescription)
                DispatchQueue.main.async {
                    self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                    
                }
                
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.saveRadToken(doctor:user)
            }
        }
    }
    
    func checkLabLoginState()  {
        customLoginsView.loginViewModel.performLabLogging {[unowned self] (base, err) in
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.saveLabToken(doctor:user)
            }
        }
    }
    
    @objc  func handleLogin()  {
        
        index == 0 || index == 1 ? checkDoctorLoginState() : index == 4 ? checkPharamacyLoginState() : index == 2 ? checkLabLoginState() : checkRadLoginState()
    }
    
    @objc func handleForget()  {
        let forget = MainForgetPasswordVC(indexx: index)
        navigationController?.pushViewController(forget, animated: true)
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
