//
//  SecondRegisterVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class DoctorSecondRegisterVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator=false

        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customCecondRegisterView:CustomSecondRegisterView = {
        let v = CustomSecondRegisterView()
        v.index = index
        v.name = name
        v.email = email
        v.passowrd = passowrd
        v.mobile = mobile
        //        putSomeData()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.signUpButton.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        v.cvView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenFiles)))
        
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
    
    var email:String? {
        didSet {
            customCecondRegisterView.doctorSecondRegisterViewModel.email=email
        }
    }
    var photo:UIImage? {
           didSet {
               customCecondRegisterView.doctorSecondRegisterViewModel.image=photo
            customCecondRegisterView.photo=photo
           }
       }
    var secondPhone:String? {
        didSet {
            customCecondRegisterView.doctorSecondRegisterViewModel.secondPhone=secondPhone
        }
    }
    
    var male:String? {
        didSet{
            guard let male = male else { return  }
            customCecondRegisterView.male=male
        }
    }
    //check to go specific way
    fileprivate let index:Int!
    fileprivate let name:String!
    fileprivate let mobile:String!
    fileprivate let passowrd:String!
    
    init(indexx:Int,name:String,mobile:String,passowrd:String) {
        self.index = indexx
        self.name = name
        self.passowrd = passowrd
        self.mobile = mobile
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customCecondRegisterView)
        customCecondRegisterView.fillSuperview()
    }
    
    fileprivate  func setupViewModelObserver()  {
        customCecondRegisterView.doctorSecondRegisterViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customCecondRegisterView.signUpButton)
        }
        
        customCecondRegisterView.doctorSecondRegisterViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Register...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
    }
    
    
    
    
    fileprivate func goToNext(id:Int)  {
        let verify = MainVerificationVC(indexx: index, isFromForgetPassw: false, isFromDoctor: true, phone: mobile, user_id: id)
        navigationController?.pushViewController(verify, animated: true)
    }
    
    fileprivate func saveAllTokens(_ user_id: Int) {
        
        userDefaults.set(true, forKey: UserDefaultsConstants.waitForSMSCodeForSpecific)
        
        userDefaults.set(index, forKey: UserDefaultsConstants.indexForSMSCodeForSpecific)
        userDefaults.set(user_id, forKey: UserDefaultsConstants.user_idForAll)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.emailForAll)
        userDefaults.removeObject(forKey: UserDefaultsConstants.nameForAll)
        userDefaults.removeObject(forKey: UserDefaultsConstants.secondMobikeForAll)
        userDefaults.removeObject(forKey: UserDefaultsConstants.passwordForAll)
        userDefaults.removeObject(forKey: UserDefaultsConstants.imageForpecific)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterMale)
        userDefaults.synchronize()
    }
    
    func saveToken(user_id:Int,_ sms:Int)  {
        saveAllTokens(user_id)
        goToNext(id: user_id)
    }
    
    //TODO: -handle methods
    
    
    
    @objc  func handleOpenFiles()  {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
        
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignup()  {
        
        customCecondRegisterView.doctorSecondRegisterViewModel.performRegister { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.saveToken(user_id: user.id,user.smsCode)
            }
        }
        
    }
    
    
    
    @objc func handleDismissKeyboard()  {
        view.endEditing(true)
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



//MARK:-Extension

extension DoctorSecondRegisterVC : UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let cico = url as URL
        
        self.customCecondRegisterView.cvLabel.text = url.lastPathComponent
        self.customCecondRegisterView.doctorSecondRegisterViewModel.cvName = url.lastPathComponent
        do {
            //                let imageData = try Data(contentsOf: cico as URL)
            try  self.customCecondRegisterView.doctorSecondRegisterViewModel.cvFile = Data(contentsOf: cico)
        } catch {
            print("Unable to load data: \(error)")
        }
    }
}
