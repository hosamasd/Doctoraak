////
////  CusomBookView.swift
////  Doctoraak
////
////  Created by hosam on 3/22/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//import iOSDropDown
//import SkyFloatingLabelTextField
//import MOLH
//
//
//class CusomBookView: CustomBaseView {
//    
//    lazy var LogoImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
//        i.contentMode = .scaleAspectFill
//        return i
//    }()
//    lazy var backImage:UIImageView = {
//        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
//        i.constrainWidth(constant: 30)
//        i.constrainHeight(constant: 30)
//        i.isUserInteractionEnabled = true
//        return i
//    }()
//    
//    lazy var titleLabel = UILabel(text: "Book", font: .systemFont(ofSize: 30), textColor: .white)
//    lazy var soonLabel = UILabel(text: "Select Your Location", font: .systemFont(ofSize: 18), textColor: .white)
//    
//    lazy var bookForMeButon = createButtons(title: "Book for me")
//    lazy var bookforAnotherPersonButton:UIButton = {
//        let b = UIButton()//createButtons(title: "Book for another person")
//        b.setTitle("Book for another person", for: .normal)
//        b.backgroundColor = .lightGray
//        return b
//    }()
//    
//    lazy var seg:CustomSegmentedControl = {
//        let ss = ["one","two"]
//        let s = CustomSegmentedControl(items: ss)
//        s.selectedSegmentIndex = 0
//        return s
//    }()
//    
//    lazy var mainDateView:UIView = {
//        let l = UIView(backgroundColor: .white)
//        l.layer.cornerRadius = 8
//        l.layer.borderWidth = 1
//        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
//        l.addSubview(dateTextField)
//        l.constrainHeight(constant: 50)
//        return l
//    }()
//    lazy var dateTextField:UITextField = {
//        let t = UITextField()
//        t.placeholder = "enter date".localized
//        t.textAlignment = .left
//        t.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
//        
//        return t
//    }()
//    
//    lazy var mainDropView:UIView = {
//        let l = UIView(backgroundColor: .white)
//        l.layer.cornerRadius = 8
//        l.layer.borderWidth = 1
//        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
//        l.addSubview(typeDrop)
//        return l
//    }()
//    lazy var typeDrop:DropDown = {
//        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
//        i.optionArray = ["one","two","three"]
//        i.arrowSize = 20
//        i.placeholder = "Type".localized
//        
//        return i
//    }()
//    lazy var shift1Button = secondButtons(title: "Shift 1")
//    lazy var shift2Button = secondButtons(title: "Shift 2")
//    
//    lazy var fullNameTextField = createMainTextFields(place: "Full name")
//    lazy var mobileNumberTextField = createMainTextFields(place: "enter Mobile",type: .numberPad)
//    
//    lazy var dayTextField = createMainTextFields(place: "   DD")
//    lazy var monthTextField = createMainTextFields(place: " MM")
//    lazy var yearTextField = createMainTextFields(place: "  YYYY")
//    
//    lazy var bookButton:UIButton = {
//        let button = CustomSiftButton(type: .system)
//        button.setTitle("Book", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        button.constrainHeight(constant: 50)
//        button.clipsToBounds = true
//        return button
//    }()
//    
//    override func setupViews() {
//        let ss = getStack(views: bookForMeButon,bookforAnotherPersonButton, spacing: 0, distribution: .fill, axis: .horizontal)
//        let sV = getStack(views: mainDateView,mainDropView, spacing: 16, distribution: .fillEqually, axis: .vertical)
//        let sssd = getStack(views: shift1Button,shift2Button, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        let ww = getStack(views: fullNameTextField,mobileNumberTextField, spacing: 16, distribution: .fillEqually, axis: .vertical)
//        
//        let tx = getStack(views: dayTextField,monthTextField,yearTextField, spacing: 8, distribution: .fillEqually, axis: .horizontal)
//        
//        //        let mainStack = getStack(views: sV,sssd,fullNameTextField,mobileNumberTextField,tx, spacing: 8, distribution: .fillEqually, axis: .vertical)
//        
//        
//        backgroundColor = .white
//        dateTextField.fillSuperview(padding: .init(top: 16, left: 16, bottom: 0, right: 16))
//        typeDrop.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
//        
//        //        addSubViews(views:LogoImage,backImage,titleLabel,soonLabel,mainStack,bookButton)
//        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,ss,bookButton,sV,sssd,ww,tx)
//        
//        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
//        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
//        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
//        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
//        ss.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 64, left: 32, bottom: 16, right: 32))
//        sV.anchor(top: ss.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
//        sssd.anchor(top: sV.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
//        ww.anchor(top: sssd.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
//        tx.anchor(top: ww.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
//        bookButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 16, bottom: 16, right: 16))
//        
//    }
//    func secondButtons(title:String) ->UIButton {
//        let b  = UIButton()
//        b.setTitle(title, for: .normal)
//        b.setTitleColor(.black, for: .normal)
//        b.constrainHeight(constant: 50)
//        b.layer.cornerRadius = 8
//        b.clipsToBounds = true
//        b.layer.borderWidth = 1
//        b.layer.borderColor = UIColor.lightGray.cgColor
//        return b
//    }
//    
//    func createButtons(title:String) ->UIButton {
//        let b  = CustomSiftButton()
//        b.setTitle(title, for: .normal)
//        b.setTitleColor(.black, for: .selected)
//        b.setTitleColor(.white, for: .normal)
//        b.layer.cornerRadius = 16
//        b.clipsToBounds = true
//        b.constrainHeight(constant: 50)
//        return b
//    }
//    
//    func colorBackgroundSelectedButton(sender:UIButton,views:[UIButton])  {
//        views.forEach { (bt) in
//            bt.setTitleColor(.black, for: .normal)
//            bt.backgroundColor = .gray
//        }
//    }
//    
//    @objc func tapDone(sender: Any, datePicker1: UIDatePicker) {
//        if let datePicker = self.dateTextField.inputView as? UIDatePicker { // 2.1
//            datePicker.datePickerMode = UIDatePicker.Mode.date
//            let dateformatter = DateFormatter() // 2.2
//            dateformatter.setLocalizedDateFormatFromTemplate("yyyy")// 2.3
//            self.dateTextField.text = dateformatter.string(from: datePicker.date) //2.4
//            //            self.handleTextContents?(dateTextField.text ?? "",true)
//        }
//        self.dateTextField.resignFirstResponder() // 2.5
//    }
//    
//    @objc func textFieldDidChange(text: UITextField)  {
//    }
//}
