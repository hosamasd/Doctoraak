//
//  CustomUpdateSserProfileView.swift
//  Doctoraak
//
//  Created by hosam on 6/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
import Lottie
import MOLH

class CustomUpdateSserProfileView: CustomBaseView {
    
    let mainView = UIView(backgroundColor: .white)
    let subView:UIView = {
        let v =  UIView(backgroundColor: .white)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        return v
    }()
    
    let imageView:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "Group 3928-1"))
        im.constrainHeight(constant: 120)
        im.constrainWidth(constant: 120)
        im.layer.cornerRadius = 60
        im.clipsToBounds = true
        im.translatesAutoresizingMaskIntoConstraints = false
        return im
    }()
    lazy var aboutLabel = UILabel(text: "Warring\n".localized, font: .systemFont(ofSize: 20), textColor: .red,textAlignment: .center,numberOfLines: 1)
    
    let discriptionInfoLabel = UILabel(text: "Are You Sure You Want To Log Out?\n".localized, font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .center,numberOfLines: 0)
    let lineSeperatorView:UIView = {
        let v = UIView(backgroundColor: #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1))
        //        let v = UIView(backgroundColor: .red)
        v.constrainHeight(constant: 1)
        return v
    }()
    
    
    lazy var okButton = createButtons(title: "Ok".localized, bgColor: #colorLiteral(red: 0.2100089788, green: 0.8682586551, blue: 0.7271742225, alpha: 1), bColor: #colorLiteral(red: 0.2100089788, green: 0.8682586551, blue: 0.7271742225, alpha: 1), tColor: .white, selector: #selector(handleLogin))
    lazy var cancelButton = createButtons(title: "Cancel".localized, bgColor: .white, bColor: #colorLiteral(red: 0.2100089788, green: 0.8682586551, blue: 0.7271742225, alpha: 1), tColor: .black, selector: #selector(handleSignup))
    
    
    var handleOkTap:(()->())?
    var handleLoginState:(()->Void)?
    var handleSignupState:(()->Void)?
    
    
    // MARK: -user methods
    
    override func setupViews()  {
        backgroundColor = .white
        let buttonStack = getStack(views: okButton,cancelButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        addSubview(mainView)
        mainView.fillSuperview()
        mainView.addSubViews(views: subView,imageView,buttonStack)
        
        subView.anchor(top: mainView.topAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor,padding: .init(top: 30, left: 0, bottom: 20, right: 0))
        subView.addSubViews(views: aboutLabel,discriptionInfoLabel,lineSeperatorView)
        imageView.anchor(top: subView.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
        aboutLabel.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        discriptionInfoLabel.anchor(top: aboutLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        //           lineSeperatorView.anchor(top: discriptionInfoLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        buttonStack.anchor(top: discriptionInfoLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        
    }
    
    func getStack(view:UIView...) -> UIStackView {
        let s = UIStackView(arrangedSubviews: view)
        s.axis = .horizontal
        s.spacing = 8
        s.distribution = .fillProportionally
        return s
    }
    
    // TODO: -handle methods
    
    @objc  func handleOk()  {
        handleOkTap?()
    }
    
    func createButtons(title:String,bgColor:UIColor,bColor:UIColor,tColor:UIColor,selector:Selector) -> UIButton {
        let bt  = UIButton()
        //          bt.constrainHeight(constant: 40)
        //        bt.constrainWidth(constant: 120)
        bt.layer.cornerRadius = 16
        bt.clipsToBounds = true
        bt.setTitle(title, for: .normal)
        bt.backgroundColor = bgColor
        bt.layer.borderWidth = 2
        bt.layer.borderColor = bColor.cgColor
        bt.setTitleColor(tColor, for: .normal)
        bt.addTarget(self, action: selector, for: .touchUpInside)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }
    
    @objc func handleLogin()  {
        handleLoginState?()
    }
    
    @objc func handleSignup()  {
        handleLoginState?()
    }
    
}


