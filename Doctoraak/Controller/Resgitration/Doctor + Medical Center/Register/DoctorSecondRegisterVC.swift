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
        v.photo = photo
        v.name = name
        v.email = email
        v.passowrd = passowrd
        v.male = male
        v.mobile = mobile
        //        putSomeData()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.signUpButton.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        v.cvView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenFiles)))
        
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
    fileprivate let name:String!
    fileprivate let email:String!
    fileprivate let mobile:String!
    fileprivate let passowrd:String!
    fileprivate let male:String!
    fileprivate let photo:UIImage!
    
    init(indexx:Int,male:String,photo:UIImage,email:String,name:String,mobile:String,passowrd:String) {
        self.index = indexx
        self.name = name
        self.email = email
        self.passowrd = passowrd
        self.photo = photo
        self.male = male
        self.mobile = mobile
        super.init(nibName: nil, bundle: nil)
    }
    
    //        init(indexx:Int) {
    //            self.index = indexx
    //            super.init(nibName: nil, bundle: nil)
    //        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        //        checkThis()
    }
    
    //MARK:-User methods
    
    func checkThis()  {
        let img = #imageLiteral(resourceName: "lego(1)").pngData()
        
        RegistrationServices.shared.registerDoctor(index: 0, isInsurance: true, coverImage: #imageLiteral(resourceName: "lego(1)"), cvName: "as", cvFile: img!, name: "asd", email: "xsa@s.com", phone: "00000006231", password: "00000000", gender: "male", specialization_id: 1, degree_id: 1, insurance: [1,2]) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
        }
    }
    
    func putSomeData()  {
        customCecondRegisterView.doctorSecondRegisterViewModel.image = photo
        customCecondRegisterView.doctorSecondRegisterViewModel.index = index
        customCecondRegisterView.doctorSecondRegisterViewModel.name = name
        customCecondRegisterView.doctorSecondRegisterViewModel.email = email
        customCecondRegisterView.doctorSecondRegisterViewModel.phone = mobile
        customCecondRegisterView.doctorSecondRegisterViewModel.password = passowrd
        customCecondRegisterView.doctorSecondRegisterViewModel.male = male
        
    }
    
    func setupViewModelObserver()  {
        customCecondRegisterView.doctorSecondRegisterViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customCecondRegisterView.signUpButton)
        }
        
        customCecondRegisterView.doctorSecondRegisterViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Register...".localized)
                
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
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customCecondRegisterView)
        customCecondRegisterView.fillSuperview()
    }
    func goToNext(id:Int)  {
        let verify = MainVerificationVC(indexx: index, isFromForgetPassw: false, phone: mobile, user_id: id)
        navigationController?.pushViewController(verify, animated: true)
      }
    
    func saveToken(user_id:Int,_ sms:Int)  {
        userDefaults.set(user_id, forKey: UserDefaultsConstants.doctorSecondRegisterUser_id)
        userDefaults.set(sms, forKey: UserDefaultsConstants.doctorSecondRegisterSMSCode)
        
        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        userDefaults.set(false, forKey: UserDefaultsConstants.isDoctorSecondRegister)
        userDefaults.set(mobile, forKey: UserDefaultsConstants.doctorRegisterMobile)
        userDefaults.set(false, forKey: UserDefaultsConstants.doctorRegisterSecondIsFromForgetPassw)
        
        userDefaults.set(index, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODEIndex)
        userDefaults.synchronize()
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
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.saveToken(user_id: user.id,user.smsCode)
            }
        }
        
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
