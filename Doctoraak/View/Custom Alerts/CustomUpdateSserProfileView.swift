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
import SwiftUI

class CustomUpdateSserProfileView: CustomBaseView {
    
    
    
    let mainView = UIView(backgroundColor: .white)
    let subView:UIView = {
        let v =  UIView(backgroundColor: .white)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.layer.cornerRadius = 16
        v.clipsToBounds=true
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
    lazy var aboutLabel = UILabel(text: "\nWarring\n".localized, font: .systemFont(ofSize: 20), textColor: .red,textAlignment: .center,numberOfLines: 2)
    
    let discriptionInfoLabel = UILabel(text: "Are You Sure You Want To Log Out?\n".localized, font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .center,numberOfLines: 1)
    let lineSeperatorView:UIView = {
        let v = UIView(backgroundColor: #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1))
        //        let v = UIView(backgroundColor: .red)
        v.constrainHeight(constant: 1)
        return v
    }()
    
    
    lazy var okButton = createButtons(title: "Logout".localized, bgColor: #colorLiteral(red: 0.6040871143, green: 0.4510732889, blue: 0.997523725, alpha: 1), tColor: .white, selector: #selector(handleLogin), cornerMakst: .layerMaxXMaxYCorner)
    lazy var cancelButton = createButtons(title: "Cancel".localized, bgColor: #colorLiteral(red: 0.3182445467, green: 0.3212628365, blue: 0.3214718103, alpha: 1), tColor: .white, selector: #selector(handleSignup), cornerMakst: .layerMinXMaxYCorner)
    
    
    var handleLogoutTap:(()->())?
    var handleCancelTap:(()->Void)?
    
    
    // MARK: -user methods
    
    override func setupViews()  {
        backgroundColor = .white
        let buttonStack = getStack(views: cancelButton,okButton, spacing: 0, distribution: .fillEqually, axis: .horizontal)
        
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
        buttonStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        
    }
    
    func getStack(view:UIView...) -> UIStackView {
        let s = UIStackView(arrangedSubviews: view)
        s.axis = .horizontal
        s.spacing = 8
        s.distribution = .fillProportionally
        return s
    }
    
    
    func createButtons(title:String,bgColor:UIColor,tColor:UIColor,selector:Selector,cornerMakst:CACornerMask) -> UIButton {
        let bt  = UIButton()
        //          bt.constrainHeight(constant: 40)
        //        bt.constrainWidth(constant: 120)
        //        bt.layer.cornerRadius = 16
        bt.clipsToBounds = true
        bt.setTitle(title, for: .normal)
        bt.backgroundColor = bgColor
        //        bt.layer.borderWidth = 2
        bt.setTitleColor(tColor, for: .normal)
        bt.addTarget(self, action: selector, for: .touchUpInside)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.constrainHeight(constant: 60)
        
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 16
        bt.layer.maskedCorners = cornerMakst//[.layerMaxXMaxYCorner]
        
        return bt
    }
    
    // TODO: -handle methods

    
    @objc func handleLogin()  {
        handleLogoutTap?()
    }
    
    @objc func handleSignup()  {
        handleCancelTap?()
    }
    
}
