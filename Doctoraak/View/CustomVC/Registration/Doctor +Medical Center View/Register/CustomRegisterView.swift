//
//  CustomRegisterView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CustomRegisterView: CustomBaseView {
    
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    
    lazy var titleLabel = UILabel(text: "Welcome", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Create account", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var userProfileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
        i.constrainWidth(constant: 100)
        i.constrainHeight(constant: 100)
        i.layer.cornerRadius = 50
        i.clipsToBounds = true
        return i
    }()
    lazy var userEditProfileImageView: UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142"))
        i.constrainWidth(constant: 28)
        i.constrainHeight(constant: 28)
        i.layer.cornerRadius = 8
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.isUserInteractionEnabled = true
        return i
    }()
    
    lazy var fullNameTextField = createMainTextFields(place: "Full name")
    lazy var mobileNumberTextField = createMainTextFields(place: "enter Mobile",type: .numberPad)
    lazy var emailTextField = createMainTextFields(place: "enter email",type: .emailAddress)
    lazy var passwordTextField:UITextField = {
        let s = createMainTextFields(place: "Password", type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASD), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
    lazy var confirmPasswordTextField:UITextField = {
        let s = createMainTextFields(place: "confirm Password", type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASDs), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
    
    lazy var boyButton:UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Male", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.clipsToBounds = true
        button.leftImage(image: #imageLiteral(resourceName: "toilet"), renderMode: .alwaysOriginal)
        button.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
        
        return button
    }()
    lazy var girlButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Female", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.leftImage(image: #imageLiteral(resourceName: "toile11t"), renderMode: .alwaysOriginal)
        button.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        button.constrainHeight(constant: 60)
        return button
    }()
    
    lazy var nextButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    let doctorRegisterViewModel = DoctorRegisterViewModel()
    var index = 0
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if boyButton.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: boyButton)
            boyButton.setTitleColor(.white, for: .normal)
        }
    }
    
    
    override func setupViews() {
        
        [ mobileNumberTextField,  passwordTextField,  emailTextField,fullNameTextField, confirmPasswordTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: userProfileImage,userEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        userEditProfileImageView.anchor(top: nil, leading: nil, bottom: userProfileImage.bottomAnchor, trailing: userProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
        
        let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let textStack = getStack(views: fullNameTextField,mobileNumberTextField,emailTextField,passwordTextField,confirmPasswordTextField,genderStack, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,subView,textStack,nextButton)
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        subView.anchor(top: LogoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        textStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        //        genderStack.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        doctorRegisterViewModel.index = index
        doctorRegisterViewModel.male = true
        //        registerViewModel.insurance = "asd"
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == mobileNumberTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    doctorRegisterViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorRegisterViewModel.phone = texts
                }
                
            }else if text == fullNameTextField {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid name".localized
                    doctorRegisterViewModel.name = nil
                }
                else {
                    
                    doctorRegisterViewModel.name = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }  else if text == emailTextField {
                if  !texts.isValidEmail    {
                    floatingLabelTextField.errorMessage = "Invalid   Email".localized
                    doctorRegisterViewModel.email = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorRegisterViewModel.email = texts
                }
                
            }else   if text == confirmPasswordTextField {
                if text.text != passwordTextField.text {
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
    
    @objc func handleGirl(sender:UIButton)  {
        if sender.backgroundColor == nil {
            doctorRegisterViewModel.male = false;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: boyButton)
        doctorRegisterViewModel.male = false
    }
    
    @objc func handleBoy(sender:UIButton)  {
        if sender.backgroundColor == nil {
            doctorRegisterViewModel.male = true;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: girlButton)
        doctorRegisterViewModel.male = true
    }
    
    @objc func handleASD()  {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func handleASDs()  {
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
    }
}
