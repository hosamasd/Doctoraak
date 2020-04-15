//
//  SecondRegisterVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

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
    
    //    init(indexx:Int) {
    //        self.index = indexx
    //        super.init(nibName: nil, bundle: nil)
    //    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customCecondRegisterView.doctorSecondRegisterViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customCecondRegisterView.signUpButton)
        }
        
        customCecondRegisterView.doctorSecondRegisterViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
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
        let verify = MainVerificationVC(indexx: index, isFromForgetPassw: false)
        navigationController?.pushViewController(verify, animated: true)
    }
    
}



//MARK:-Extension

extension DoctorSecondRegisterVC : UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let cico = url as URL
        print(cico)
        print(url)
        
        print(url.lastPathComponent)
        
        self.customCecondRegisterView.cvLabel.text = url.lastPathComponent
        self.customCecondRegisterView.doctorSecondRegisterViewModel.cvFile = url.lastPathComponent
        print(url.pathExtension)
        
    }
}
