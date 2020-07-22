//
//  MainNewPassVC.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SVProgressHUD
import MOLH

class MainNewPassVC: CustomBaseViewVC {
    
    lazy var customMainNewPassView:CustomMainNewPassView = {
        let v = CustomMainNewPassView()
        v.index = index
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.newPassViewModel.mobile = self.mobile
        v.resendSMSButton.addTarget(self, action: #selector(handleResendSMS), for: .touchUpInside)
        
        v.doneButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator=false
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 800)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    
    //check to go specific way
    fileprivate let index:Int!
    fileprivate let mobile:String!
    
    init(indexx:Int,mobile:String) {
        self.index = indexx
        self.mobile=mobile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customMainNewPassView.codeTextField.becomeFirstResponder()
    }
    
    //MARK:-User methods
    
    fileprivate func setupViewModelObserver()  {
        customMainNewPassView.newPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customMainNewPassView.doneButton)
        }
        
        customMainNewPassView.newPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
                
            }else {
                //                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
        
        customMainNewPassView.newPassViewModel.bindableIsResending.bind { [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
                
            }else {
                //                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
                
            }
        }
    }
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customMainNewPassView)
        customMainNewPassView.fillSuperview()
    }
    
    func goToNext()  {
        userDefaults.set(false, forKey: UserDefaultsConstants.isWaitForMainNewPassVC)
        userDefaults.removeObject(forKey: UserDefaultsConstants.isWaitForMainNewPassVCMobile)
        userDefaults.synchronize()
        let login = MainLoginsVC(indexx: index)
        navigationController?.pushViewController(login, animated: true)
    }
    
    //TODO: -handle methods
    
    @objc func handleResendSMS()  {
        customMainNewPassView.newPassViewModel.performResendinging { (base, err) in
            
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //                SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base else {return}
            SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
        }
    }
    
    @objc func handleNext()  {
        
        customMainNewPassView.newPassViewModel.performUpdatinging { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //                SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base,let dd = user.messageEn?.trimmingCharacters(in: .whitespaces) else {SVProgressHUD.showError(withStatus: base?.messageEn); return}
            
            if dd.contains("Password Error") {
                SVProgressHUD.showError(withStatus:user.messageEn)
            }else {
                SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
                
                DispatchQueue.main.async {
                    self.goToNext()
                }
            }
            
        }
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
}
