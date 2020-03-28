//
//  RegisterVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class DoctorRegisterVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 800)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customRegisterView:CustomRegisterView = {
        let v = CustomRegisterView()
        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        v.mobileNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.emailTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.fullNameTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.userEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
        return v
    }()
    var index:Int = 0
    
    let doctorRegisterViewModel = DoctorRegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        doctorRegisterViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customRegisterView.nextButton)
        }
        
        doctorRegisterViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
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
        mainView.addSubViews(views: customRegisterView)
        customRegisterView.fillSuperview()
    }
    
    @objc func handleGirl(sender:UIButton)  {
        if sender.backgroundColor == nil {
            doctorRegisterViewModel.male = false;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: customRegisterView.boyButton)
        doctorRegisterViewModel.male = false
    }
    
    @objc func handleBoy(sender:UIButton)  {
        if sender.backgroundColor == nil {
            doctorRegisterViewModel.male = true;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: customRegisterView.girlButton)
        doctorRegisterViewModel.male = true
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        doctorRegisterViewModel.index = index
        doctorRegisterViewModel.male = true
        //        registerViewModel.insurance = "asd"
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customRegisterView.mobileNumberTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    doctorRegisterViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorRegisterViewModel.phone = texts
                }
                
            }else if text == customRegisterView.fullNameTextField {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid name".localized
                    doctorRegisterViewModel.name = nil
                }
                else {
                    
                    doctorRegisterViewModel.name = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }  else if text == customRegisterView.emailTextField {
                if  !texts.isValidEmail    {
                    floatingLabelTextField.errorMessage = "Invalid   Email".localized
                    doctorRegisterViewModel.email = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorRegisterViewModel.email = texts
                }
                
            }else   if text == customRegisterView.confirmPasswordTextField {
                if text.text != customRegisterView.passwordTextField.text {
                    floatingLabelTextField.errorMessage = "Passowrd should be same".localized
                    doctorRegisterViewModel.confirmPassword = nil
                }
                else {
                    doctorRegisterViewModel.confirmPassword = texts
                    floatingLabelTextField.errorMessage = ""
                }
            }else
                if(texts.count < 8 ) {
                    floatingLabelTextField.errorMessage = "password must have 8 character".localized
                    doctorRegisterViewModel.password = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorRegisterViewModel.password = texts
            }
        }
    }
    
    
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}



//MARK:-Extension

extension DoctorRegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            doctorRegisterViewModel.image = img
            customRegisterView.userProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            doctorRegisterViewModel.image = img
            customRegisterView.userProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        doctorRegisterViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
