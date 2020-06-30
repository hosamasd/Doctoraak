//
//  CustomAnaylticsView.swift
//  Doctoraak
//
//  Created by hosam on 6/17/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
import WebKit
import MOLH

class CustomAnaylticsView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116").withRenderingMode(.alwaysOriginal))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var drImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 3795"))
        i.contentMode = .scaleToFill
        i.clipsToBounds = true
        i.constrainWidth(constant: 80)
        //           i.constrainHeight(constant: 400)
        return i
    }()
    lazy var docotrLabel = UILabel(text: "Doctoraak ".localized, font: .systemFont(ofSize: 20), textColor: .white,textAlignment: .center)
    lazy var titleLabel = UILabel(text: "Anaylicts".localized, font: .systemFont(ofSize: 35), textColor: .white)
    
    lazy var mainWebView:WKWebView = {
        let v = WKWebView()
        v.uiDelegate = self
        return v
    }()
    
    override func setupViews() {
        titleLabel.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left

        addSubViews(views: LogoImage,backImage,titleLabel,drImage,docotrLabel,mainWebView)
        
        
        if MOLHLanguage.isRTLLanguage() {
             LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
         }else {
             
             LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        drImage.anchor(top: topAnchor, leading: backImage.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 24, bottom: 0, right: 0))
        docotrLabel.anchor(top: topAnchor, leading: drImage.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 65, left: 16, bottom: 0, right: 0))
        mainWebView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 86, left: 16, bottom: 0, right: 0))
    }
}




extension CustomAnaylticsView: WKUIDelegate {
    
}
