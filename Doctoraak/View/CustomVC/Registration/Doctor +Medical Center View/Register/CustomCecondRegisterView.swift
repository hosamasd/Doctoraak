//
//  CustomCecondRegisterView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import iOSDropDown
import UIMultiPicker

class CustomCecondRegisterView: CustomBaseView {
    
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
    
    lazy var descriptionTextField = createMainTextFields(place: "Description",type: .default)
    lazy var cvTextField:UITextField = {
        let s = createMainTextFields(place: "CV")
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "Group 4142-2"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(55))
        button.addTarget(self, action: #selector(handleUpload), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
     lazy var discriptionTextField = createMainTextFields(place: "Description")
    lazy var mainDropView:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.addSubview(specializationDrop)
        return l
    }()
    lazy var specializationDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Specialization".localized
        return i
    }()
    lazy var mainDrop2View:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.addSubview(degreeDrop)
        return l
    }()
    lazy var degreeDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "Degree".localized
        return i
    }()
    
    lazy var mainDrop3View:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseInsurance)))
//        l.addSubview(insuranceDrop)
        return l
    }()
    lazy var doenImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-6"))
        i.constrainWidth(constant: 50)
        i.constrainHeight(constant: 50)
        return i
    }()
    lazy var insuracneText = UILabel(text: "choose insurance", font: .systemFont(ofSize: 18), textColor: .black, textAlignment: .left)
    lazy var insuranceDrop:UIMultiPicker = {
        let v = UIMultiPicker(backgroundColor: .white)
        v.options = insuracneArray
        v.color = .gray
        v.tintColor = .green
        v.font = .systemFont(ofSize: 30, weight: .bold)
        v.highlight(2, animated: true) // centering "Bitter"
        v.constrainHeight(constant: 150)
        v.isHide(true)
        v.addTarget(self, action: #selector(handleHidePicker), for: .valueChanged)
        return v
    }()
    
//    lazy var mainDrop3View:UIView = {
//        let l = UIView(backgroundColor: .white)
//        l.layer.cornerRadius = 8
//        l.layer.borderWidth = 1
//        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
//        l.addSubview(insuranceDrop)
//        return l
//    }()
//    lazy var insuranceDrop:DropDown = {
//        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
//        i.optionArray = ["one","two","three"]
//        i.arrowSize = 20
//        i.placeholder = "insurance".localized
//        return i
//    }()
    
    lazy var acceptButton:UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "Rectangle 1712"), for: .normal)
        b.setImage(#imageLiteral(resourceName: "DropDown_Checked"), for: .selected)
        b.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        return b
    }()
    
    lazy var acceptLabel = UILabel(text: " Accept ".localized, font: .systemFont(ofSize: 16), textColor: .black)
    lazy var createAccountButton:UIButton = {
        let b = UIButton()
        b.setTitle("Terms and Conditions".localized, for: .normal)
        b.setTitleColor(#colorLiteral(red: 0.5999417901, green: 0.821531117, blue: 0.8872718215, alpha: 1), for: .normal)
        b.underline()
        b.constrainHeight(constant: 50)
        return b
    }()
    
   

    lazy var signUpButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        return button
    }()
    
    var insuracneArray = ["one","two","three","sdfdsfsd"]
    
    
    override func setupViews() {
        let bottomStack = getStack(views: UIView(),acceptButton,acceptLabel,createAccountButton,UIView(), spacing: 0, distribution: .fillProportionally, axis: .horizontal)
        let textStack = getStack(views: mainDropView,mainDrop2View,discriptionTextField,cvTextField,mainDrop3View, spacing: 16, distribution: .fillEqually, axis: .vertical)

        mainDrop3View.addSubViews(views: doenImage,insuracneText)
        mainDrop3View.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,textStack,bottomStack,insuranceDrop,signUpButton)
        [specializationDrop,degreeDrop].forEach({$0.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))})

//       [specializationDrop,degreeDrop,insuranceDrop].forEach({$0.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))})
        
        NSLayoutConstraint.activate([
            bottomStack.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        textStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        insuranceDrop.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
//        bottomStack.anchor(top: textStack.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        bottomStack.anchor(top: textStack.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 16, left: 0, bottom: 0, right: 0))

        signUpButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
    }
    
   @objc func handleUpload()  {
        print(965)
    }
    var iiii = ""
    var de = ""
    
    @objc func handleHidePicker(sender:UIMultiPicker)  {
        sender.selectedIndexes.forEach { (i) in
            
            de += insuracneArray[i] + ","
        }
        iiii = de
        insuracneText.text = iiii
        de = ""
    }
    
    @objc func handleOpenCloseInsurance()  {
        insuranceDrop.isHidden = !insuranceDrop.isHidden
    }
    
   @objc func handleAgree(sender:UIButton)  {
        sender.isSelected = !sender.isSelected
    }
}
