//
//  CustomClinicWorkingHoursView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomMainClinicWorkingHoursView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    
    lazy var titleLabel = UILabel(text: "Clinic", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Fill your data", font: .systemFont(ofSize: 18), textColor: .white)
    
    
    lazy var shift1Button = createButtons(title: "Shift 1",color: .white)
     lazy var shift2Button = createButtons(title: "Shift 2",color: .black)
    
    func createButtons(title:String,color:UIColor,tags : Int? = 0) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.constrainHeight(constant: 50)
       button.tag = tags ?? 0
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        return button
    }
    
    lazy var sunButton = createButtons(title: "Sun",color: .white,tags: 1)
    lazy var first1TextField = createHoursTextFields(tags: 1)
    lazy var first2TextField = createHoursTextFields(tags: 11)
    
     lazy var monButton = createButtons(title: "Mon",color: .black,tags: 2)
    lazy var second1TextField = createHoursTextFields(tags: 2)
    lazy var second2TextField = createHoursTextFields(tags: 22)
    
     lazy var tuesButton = createButtons(title: "Tue",color: .black,tags: 3)
    lazy var third1TextField = createHoursTextFields(tags: 3)
    lazy var third2TextField = createHoursTextFields(tags: 33)
    
    lazy var wedButton = createButtons(title: "Wed",color: .black,tags: 4)
    lazy var forth1TextField = createHoursTextFields(tags: 4)
    lazy var forth2TextField = createHoursTextFields(tags: 44)
    
    lazy var thuButton = createButtons(title: "Thu",color: .black,tags: 5)
    lazy var fifth1TextField = createHoursTextFields(tags: 5)
    lazy var fifth2TextField = createHoursTextFields(tags: 55)
    
    lazy var friButton = createButtons(title: "Fri",color: .black,tags: 6)
    lazy var sexth1TextField = createHoursTextFields(tags: 6)
    lazy var sexth2TextField = createHoursTextFields(tags: 66)
    
    lazy var satButton = createButtons(title: "Sat",color: .black,tags: 7)
    lazy var seventh1TextField = createHoursTextFields(tags: 7)
    lazy var seventh2TextField = createHoursTextFields(tags: 77)
    
    lazy var doneButton:UIButton = {
        let button = CustomSiftButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
        return button
    }()
  

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let leftColor = #colorLiteral(red: 0.6555111408, green: 0.5125037432, blue: 0.9976704717, alpha: 1)
        let rightColor = #colorLiteral(red: 0.7503471971, green: 0.6148311496, blue: 0.9988300204, alpha: 1)
        [shift1Button,sunButton].forEach({$0.applyGradient(colors: [leftColor.cgColor, rightColor.cgColor], index: 0)})
    }
    
    override func setupViews() {
       [first2TextField,first1TextField].forEach({$0.isUserInteractionEnabled = true})
//        [second1TextField,second2TextField,third1TextField,third2TextField,forth1TextField,forth2TextField,fifth1TextField,fifth2TextField,sexth1TextField,sexth2TextField].forEach({$0.isUserInteractionEnabled = false})
        [satButton,sunButton,monButton,tuesButton,thuButton,wedButton,friButton].forEach({$0.constrainWidth(constant: 50)})
        let ss = getStack(views: shift1Button,shift2Button, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let text1Stack = getStack(views: first1TextField,first2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let firstStack = getStack(views: sunButton,text1Stack, spacing: 32, distribution: .fill, axis: .horizontal)
        
        let text2Stack = getStack(views: second1TextField,second2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first2Stack = getStack(views: monButton,text2Stack, spacing: 32, distribution: .fill, axis: .horizontal)
       
        let text3Stack = getStack(views: third1TextField,third2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first3Stack = getStack(views: tuesButton,text3Stack, spacing: 32, distribution: .fill, axis: .horizontal)
       
        let text4Stack = getStack(views: forth1TextField,forth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first4Stack = getStack(views: wedButton,text4Stack, spacing: 32, distribution: .fill, axis: .horizontal)
        
        let text5Stack = getStack(views: fifth1TextField,fifth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first5Stack = getStack(views: thuButton,text5Stack, spacing: 32, distribution: .fill, axis: .horizontal)
       
        let text6Stack = getStack(views: sexth1TextField,sexth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first6Stack = getStack(views: friButton,text6Stack, spacing: 32, distribution: .fill, axis: .horizontal)
        
        let text7Stack = getStack(views: seventh1TextField,seventh2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first7Stack = getStack(views: satButton,text7Stack, spacing: 32, distribution: .fill, axis: .horizontal)
        
        let mainStack = getStack(views: firstStack,first2Stack,first3Stack,first4Stack,first5Stack,first6Stack,first7Stack, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
      
            addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,ss,mainStack,doneButton)
            
           
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
            backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
            titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
            soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        ss.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 76, left: 32, bottom: 0, right: 32))

            mainStack.anchor(top: ss.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
            
            //
            doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
            
        }
    
    func createHoursTextFields(tags:Int) -> UITextField {
        let t = UITextField()
        t.textAlignment = .center
        t.layer.borderWidth = 1
        t.layer.backgroundColor = UIColor.gray.cgColor
        t.layer.cornerRadius = 16
        t.clipsToBounds = true
        t.textColor = .black
        t.backgroundColor = .white
        t.text = "00:00"
        t.constrainHeight(constant: 50)
        t.isUserInteractionEnabled = false
        t.tag = tags
        return t
    }
    
    func enalbes(t:UITextField...,enable:Bool? = true)   {
        t.forEach({$0.isUserInteractionEnabled = enable ?? true})
    }
    
    func enableTextFields(tag:Int)  {
        switch tag {
        case 1:
            enalbes(t: first1TextField,first2TextField)
        case 2:
            enalbes(t: second1TextField,second2TextField)
        case 3:
            enalbes(t: third1TextField,third2TextField)
        case 4:
            enalbes(t: forth1TextField,forth2TextField)
        case 5:
            enalbes(t: fifth1TextField,fifth2TextField)
        case 6:
            enalbes(t: sexth1TextField,sexth2TextField)
        default:
            enalbes(t: seventh1TextField,seventh2TextField)
            
        }
    }
    
  @objc  func handleOpen(sender:UIButton)  {
        enableTextFields(tag: sender.tag)
    addGradientInSenderAndRemoveOther(sender: sender)
    }
    
    
   @objc func tapDone()  {
        print(969)
    }

}
//    @objc func handleShowPicker() {
//        let timeSelector = TimeSelector()
//        timeSelector.timeSelected = {
//            (timeSelector) in
//            self.setLabelFromDate(timeSelector.date)
//        }
//        timeSelector.overlayAlpha = 0.8
//        timeSelector.clockTint = timeSelector_rgb(0, 230, 0)
//        timeSelector.minutes = 30
//        timeSelector.hours = 5
//        timeSelector.isAm = false
//        timeSelector.presentOnView(view: self.view)
//    }}
