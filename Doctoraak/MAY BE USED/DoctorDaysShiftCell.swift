////
////  DoctorDaysShiftCell.swift
////  Doctoraak
////
////  Created by hosam on 3/21/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//class DoctorDaysShiftCell: BaseCollectionCell {
//    
//    lazy var logoImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1751"))
//        return i
//    }()
//    lazy var doctorDateLabel = UILabel(text: "22/3/2020", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .center)
//
//    lazy var subView:UIView = {
//       let i = UIView(backgroundColor: .lightGray)
//        i.constrainHeight(constant: 100)
//        i.layer.cornerRadius = 8
//        i.clipsToBounds = true
//        return i
//    }()
//    lazy var shift1Button: UIButton = {
//        let button = CustomSiftButton(type: .system)
//        button.setTitle("Shift 1", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        button.clipsToBounds = true
//        return button
//    }()
//    lazy var shift2Button:UIButton = {
//       let b = UIButton(title: "Shift 2", titleColor: .black, font: .systemFont(ofSize: 16), backgroundColor: .lightGray, target: self, action: nil)
//        b.constrainHeight(constant: 50)
//        b.layer.cornerRadius = 8
//        b.clipsToBounds = true
//        b.isHide(false)
//        return b
//    }()
//    
//    override func setupViews() {
//        backgroundColor = .white
//        layer.cornerRadius = 16
//        clipsToBounds = true
//        let ss = stack(shift1Button,shift2Button)
//        subView.addSubview(ss)
//        stack(logoImage,doctorDateLabel,subView,spacing:8).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
//        ss.fillSuperview()
//    }
//}
