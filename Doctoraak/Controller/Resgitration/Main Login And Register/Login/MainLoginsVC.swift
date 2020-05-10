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
    
    func seeee()  {
        RegistrationServices.shared.MainResendSmsCodeAgain(index: 0, user_id: 30) { (base, err) in
            if let err=err{
                SVProgressHUD.showError(withStatus: err.localizedDescription)
            }
        }
    }
    
    fileprivate func setupLoginViewModelObserver(){
        
        customLoginsView.loginViewModel.bindableIsFormValidate.bind {[unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            
            self.changeButtonState(enable: isValid, vv: self.customLoginsView.loginButton)
        }
        customLoginsView.loginViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                                SVProgressHUD.show(withStatus: "Login...".localized)
                
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
        
        view.addSubview(customLoginsView)
        customLoginsView.fillSuperview()
    }
    
    func goToMainTab()  {
//        let home = BaseSlidingVC(indexx: index)
//        home.currentDoctor = doctor
//                     //        present(home, animated: true, completion: nil)
//                     navigationController?.pushViewController(home, animated: true)
    }
    
    func saveToken(doctr_id:Int,_ api_token:String)  {
        let perform = index == 0 ? UserDefaultsConstants.DoctorPerformLogin : index == 1 ? UserDefaultsConstants.medicalCenterPerformLogin : index == 2 ? UserDefaultsConstants.labPerformLogin : index == 3 ? UserDefaultsConstants.radiologyPerformLogin : UserDefaultsConstants.pharamacyPerformLogin
        
        userDefaults.set(true, forKey: perform)
        userDefaults.set(api_token, forKey: UserDefaultsConstants.mainCurrentUserApiToken)
                userDefaults.synchronize()
         self.goToMainTab()
    }
    
    func saveDoctorToken(doctor:DoctorLoginModel)  {
        userDefaults.set(true, forKey: UserDefaultsConstants.DoctorPerformLogin)
        userDefaults.set(doctor.apiToken, forKey: UserDefaultsConstants.doctorCurrentApiToken)
        userDefaults.set(doctor.name, forKey: UserDefaultsConstants.doctorCurrentNAME)
        userDefaults.set(doctor.id, forKey: UserDefaultsConstants.doctorCurrentUSERID)
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)

                       userDefaults.synchronize()
                self.goToDoctorMainTab(doctor: doctor)
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
             SVProgressHUD.dismiss()
                    self.activeViewsIfNoData()
                        guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
                    
                    DispatchQueue.main.async {
                        self.saveDoctorToken(doctor:user)
                       
                    }
        }
    }
    
    @objc  func handleLogin()  {
        
        index == 0 ? checkDoctorLoginState() : ()
        
        
//        customLoginsView.loginViewModel.performLogging { [unowned self] (base,err) in
//        if let err = err {
//            SVProgressHUD.showError(withStatus: err.localizedDescription)
//            self.activeViewsIfNoData();return
//        }
//        SVProgressHUD.dismiss()
//        self.activeViewsIfNoData()
//            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
////        self.saveToken(token: user.apiToken)
//
//        DispatchQueue.main.async {
//            self.saveToken(doctr_id: user.id, user.apiToken)
//
//        }
//        }
        
       
        
    }
    
    @objc func handleForget()  {
        let forget = MainForgetPasswordVC(indexx: index)
        navigationController?.pushViewController(forget, animated: true)
    }
    
    @objc func handleBack()  {
        navigationController?.popToRootViewController(animated: true)
    }
   
   
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
}
