//
//  CustomLoginsView.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CustomLoginsView: CustomBaseView {
    
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
    
    lazy var titleLabel = UILabel(text: "Hello", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Sign in to your account", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var phoneNumberTextField = createMainTextFields(place: "Phone Number", type: .numberPad)
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
    lazy var forgetPasswordButton:UIButton = {
        let b = UIButton()
        b.setTitle("Forget Password ?".localized, for: .normal)
        b.setTitleColor(#colorLiteral(red: 0.8333545327, green: 0.74265939, blue: 0.9777938724, alpha: 1), for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        b.backgroundColor = .clear
        b.constrainWidth(constant: 150)
        return b
        
    }()
    
    lazy var loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
         button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
       
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        return button
    }()
    lazy var createAccountLabel = UILabel(text: "Don't have an account ? ".localized, font: .systemFont(ofSize: 16), textColor: .black)
    lazy var createAccountButton:UIButton = {
        let b = UIButton()
        b.setTitle("Sign up".localized, for: .normal)
        b.setTitleColor(#colorLiteral(red: 0.4852292538, green: 0.7782793641, blue: 0.8675006032, alpha: 1), for: .normal)
        b.constrainHeight(constant: 50)
//        b.isEnabled = false
        return b
    }()
    
      var index:Int? = 0
    
    
    override func setupViews() {
          let forgetStack = getStack(views: UIView(),forgetPasswordButton, spacing: 8, distribution: .fill, axis: .horizontal)
        let createStack = getStack(views: createAccountLabel,createAccountButton, spacing: 0, distribution: .fill, axis: .horizontal)
        let subStack = getStack(views: phoneNumberTextField,passwordTextField,forgetStack, spacing: 16, distribution: .fillEqually, axis: .vertical)

        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,subStack,loginButton,createStack)

        NSLayoutConstraint.activate([
            subStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            subStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 0),
            createStack.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
            
            ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        subStack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 32, bottom: 0, right: 32))

        loginButton.anchor(top: createStack.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: -60, left: 16, bottom: 0, right: 16))

        createStack.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 16, right: 0))

    }
    
   @objc func handleASD()  {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
}