//
//  CustomWelcomeMainSecondView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomWelcomeMainSecondView: CustomBaseView {
    
    lazy var mainImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "iPhone X-XS – 28"))
        return i
    }()
    lazy var drImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 3795"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        return i
    }()
    lazy var docotrLabel = UILabel(text: "Doctoraak ".localized, font: .systemFont(ofSize: 20), textColor: .white,textAlignment: .center)

    lazy var mainFirstView:UIView = {
      let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
//        v.constrainHeight(constant: 80)
         v.addSubViews(views: Image1,label1)
        return v
    }()
    lazy var main2View:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
        v.addSubViews(views: Image2,label2)
        return v
    }()
    lazy var main3View:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
        v.addSubViews(views: Image3,label3)
        return v
    }()
    lazy var main4View:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
        v.constrainHeight(constant: 80)
        v.addSubViews(views: Image4,label4)
        return v
    }()
    lazy var main5View:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.clipsToBounds = true
//        v.constrainHeight(constant: 80)
        v.addSubViews(views: Image5,label5)
        return v
    }()
  
    lazy var label1 =  makeAttributedText(fir: "Register as".localized, sec: "Medical Center".localized)
    lazy var label2 =  makeAttributedText(fir: "Register as".localized, sec: "a Doctor".localized)
    lazy var label3 =  makeAttributedText(fir: "Register as".localized, sec: "Medical Lab".localized)
    lazy var label4 =  makeAttributedText(fir: "Register as".localized, sec: "Radiology Center".localized)
    lazy var label5 =  makeAttributedText(fir: "Register as".localized, sec: "a Pharmacy".localized)
    
    lazy var Image1:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-4"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
       
        return i
    }()
    
    lazy var Image2:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143-2"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        return i
    }()
    
    lazy var Image3:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4144"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        return i
    }()
    
    lazy var Image4:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4145"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        return i
    }()
    
    lazy var Image5:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4146"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        return i
    }()
    
    override func setupViews() {
        
        
       
        main5View.hstack(Image5,label5)
         main4View.hstack(Image4,label4)
         main3View.hstack(Image3,label3)
         main2View.hstack(Image2,label2)
         mainFirstView.hstack(Image1,label1)
        let ss = getStack(views: main2View,mainFirstView,main3View,main4View,main5View, spacing: 8, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: mainImage,docotrLabel,drImage,ss)
         mainImage.fillSuperview()
//        drImage.centerInSuperview()
        NSLayoutConstraint.activate([
            drImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            drImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200)
            ])
        docotrLabel.anchor(top: drImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 16, right: 0))

        ss.anchor(top: docotrLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 32, right: 32))

        
    }
    
    func makeAttributedText(fir:String,sec:String) -> UILabel {
        let l = UILabel()
       let attrString = NSMutableAttributedString()
        .appendWith(color: #colorLiteral(red: 0.246225208, green: 0.2462718487, blue: 0.2462153137, alpha: 1), weight: .regular, ofSize: 16, fir+"\n")
        .appendWith(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), weight: .bold, ofSize: 16, sec)
        l.attributedText = attrString
        l.numberOfLines = 2
        l.textAlignment = .center
        return l
    }
    
   
    
}
