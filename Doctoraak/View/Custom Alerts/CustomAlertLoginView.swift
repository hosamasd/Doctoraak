//
//  CustomAlertLoginView.swift
//  Doctoraak
//
//  Created by hosam on 6/13/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
import Lottie

class CustomAlertLoginView: CustomBaseView {
    
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.layer.cornerRadius = 16
        v.clipsToBounds = true
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.gray.cgColor
        return v
    }()
    lazy var subView:UIView = {
        let v =  UIView(backgroundColor: .clear)
        return v
    }()
    
    lazy var problemsView:AnimationView = {
        let i = AnimationView()
//        i.constrainWidth(constant: 30)
//        i.constrainHeight(constant: 30)
        return i
    }()
    
    
    
    lazy var imageView:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "Ellipse 119-1"))
        im.constrainHeight(constant: 180)
        im.constrainWidth(constant: 180)
        im.layer.cornerRadius = 90
        im.clipsToBounds = true
        im.translatesAutoresizingMaskIntoConstraints = false
        im.addSubview(problemsView)
        return im
    }()
    lazy var discriptionInfoLabel = UILabel(text: "Please login first".localized, font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .center)
    
    
    
    lazy var okButton:UIButton = {
        let bt = UIButton(title: "OK".localized, titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.7090973854, green: 0.5211717486, blue: 0.9973145127, alpha: 1), target: self, action: #selector(handleOk))
        bt.constrainHeight(constant: 50)
        return bt
    }()
    
    
    var handleOkTap:(()->())?
    
    
    
    
    // MARK: -user methods
    
    override func setupViews()  {
        backgroundColor = .white
        addSubViews(views: mainView,imageView)
        mainView.fillSuperview()
        mainView.addSubViews(views: subView)
        problemsView.centerInSuperview()
        subView.anchor(top: mainView.topAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor,padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        subView.addSubViews(views: discriptionInfoLabel,okButton)
        imageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
        discriptionInfoLabel.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        okButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        
    }
    
    func setupAnimation(name:String)  {
        problemsView.animation = Animation.named(name)
        problemsView.play()
        problemsView.loopMode = .loop
    }
    
    // TODO: -handle methods
    
    @objc  func handleOk()  {
        handleOkTap?()
    }
}
