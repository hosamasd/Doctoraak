//
//  CustomSecondWelcomeView.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH

class CustomSecondWelcomeView: CustomBaseView {
    
    lazy var mainImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "iPhone X-XS – 28"))
        return i
    }()
    lazy var drImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "2367415"))
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
    lazy var loginButton = createButtons(texzt: "LOGIN".localized)
    lazy var registerButton = createButtons(texzt: "SIGN UP".localized)
    
    override func setupViews() {
        let ss = getStack(views: loginButton,registerButton, spacing: 8, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: mainImage,backImage,drImage,ss)
        
        mainImage.fillSuperview()
        drImage.centerInSuperview()
        ss.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 16, bottom: 48, right: 16))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 16, left: 16, bottom: 0, right: 0))
    }
    
    func createButtons(texzt:String) -> UIButton {
        let b = UIButton()
        b.setTitle(texzt, for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .white
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 8
        b.clipsToBounds = true
        return b
    }
    
}
