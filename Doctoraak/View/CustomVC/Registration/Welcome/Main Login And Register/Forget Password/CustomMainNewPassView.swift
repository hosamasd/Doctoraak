//
//  CustomMainNewPassView.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CustomMainNewPassView: CustomBaseView {
    
    
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
    
    lazy var titleLabel = UILabel(text: "New".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Password".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var choosePayLabel = UILabel(text: "Please Enter your code and  new password".localized, font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)
    lazy var codeTextField = createMainTextFields(place: " code".localized,type: .numberPad)
    
    lazy var passwordTextField:UITextField = {
        let s = createMainTextFields(place: "New Password".localized, type: .default,secre: true)
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
        let s = createMainTextFields(place: "confirm Password".localized, type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASDs), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        s.constrainHeight(constant: 60)
        return s
    }()
    lazy var resendLabel = UILabel(text: "Don't receive an sms code ? ".localized, font: .systemFont(ofSize: 16), textColor: .black)
    lazy var resendSMSButton:UIButton = {
        let b = UIButton()
        b.setTitle("Resend".localized, for: .normal)
        b.setTitleColor(#colorLiteral(red: 0.7871699929, green: 0.09486690909, blue: 0, alpha: 1), for: .normal)
        b.constrainHeight(constant: 50)
        return b
    }()
    lazy var doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done".localized, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    var index = 0
    
    let newPassViewModel = NewPassViewModel()
    
    
    override func setupViews() {
        let resendStack = getStack(views: resendLabel,resendSMSButton, spacing: 0, distribution: .fill, axis: .horizontal)
        
        [ codeTextField,passwordTextField,confirmPasswordTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        let textStack = getStack(views: codeTextField,passwordTextField,confirmPasswordTextField,resendStack, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        choosePayLabel.constrainHeight(constant: 40)
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,doneButton,choosePayLabel,textStack)
        
        NSLayoutConstraint.activate([
            choosePayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            choosePayLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        textStack.anchor(top: choosePayLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 32, bottom: 16, right: 32))
        
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    @objc func handleASD()  {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func handleASDs()  {
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        newPassViewModel.index = index
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == codeTextField {
                if texts.count < 5 {
                    floatingLabelTextField.errorMessage = "Invalid code entered".localized
                    newPassViewModel.password = nil
                }
                else {
                    newPassViewModel.password = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }else if text == confirmPasswordTextField {
                if text.text != passwordTextField.text {
                    floatingLabelTextField.errorMessage = "Passowrd should be same".localized
                    newPassViewModel.confirms2Password=nil
                }
                else {
                    newPassViewModel.confirms2Password=texts
                    floatingLabelTextField.errorMessage = ""
                    
                }
            }else
            {
                if(texts.count < 8 ) {
                    floatingLabelTextField.errorMessage = "password must have 8 character".localized
                    newPassViewModel.confirmPassword = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    newPassViewModel.confirmPassword = texts
                }
            }
            
            
        }
    }
}
