////
////  CustomMainClinicWorkingHoursVCWithoutEditingVC.swift
////  Doctoraak
////
////  Created by hosam on 6/15/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//
//class CustomMainClinicWorkingHoursVCWithoutEditingVC: CustomBaseView {
//    
//    var workingHours:[PharamacyWorkingHourModel]?{
//        didSet{
//            guard let work = workingHours else { return  }
//            work.forEach { (w) in
//                putTheses(w: w)
//            }
//        }
//    }
//    
//    var workingHoursLAB:[LabWorkingHoursModel]?{
//        didSet{
//            guard let work = workingHoursLAB else { return  }
//            work.forEach { (w) in
//                putThesesLAB(w: w)
//            }
//        }
//    }
//    
//    var workingHoursRAD:[RadiologyWorkingHourModel]?{
//        didSet{
//            guard let work = workingHoursRAD else { return  }
//            work.forEach { (w) in
//                putThesesRAD(w: w)
//            }
//        }
//    }
//    
//  
//    
//    
//    
//    lazy var LogoImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
//        i.contentMode = .scaleAspectFill
//        return i
//    }()
//    lazy var backImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
//        i.constrainWidth(constant: 30)
//        i.constrainHeight(constant: 30)
//        i.isUserInteractionEnabled = true
//        return i
//    }()
//    
//    lazy var titleLabel = UILabel(text: "Working Hours", font: .systemFont(ofSize: 30), textColor: .white)
//    lazy var soonLabel = UILabel(text: "Deterimine Working Times", font: .systemFont(ofSize: 18), textColor: .white)
//    
//    
//    lazy var sunButton = createButtons(title: "Sun",color: .black,tags: 2)
//    lazy var first1TextField = createHoursButtons(tags: 1)
//    lazy var first2TextField = createHoursButtons(tags: 11)
//    
//    lazy var monButton = createButtons(title: "Mon",color: .black,tags: 3)
//    lazy var second1TextField = createHoursButtons(tags: 2)
//    lazy var second2TextField = createHoursButtons(tags: 22)
//    
//    lazy var tuesButton = createButtons(title: "Tue",color: .black,tags: 4)
//    lazy var third1TextField = createHoursButtons(tags: 3)
//    lazy var third2TextField = createHoursButtons(tags: 33)
//    
//    lazy var wedButton = createButtons(title: "Wed",color: .black,tags: 5)
//    lazy var forth1TextField = createHoursButtons(tags: 4)
//    lazy var forth2TextField = createHoursButtons(tags: 44)
//    
//    lazy var thuButton = createButtons(title: "Thu",color: .black,tags: 6)
//    lazy var fifth1TextField = createHoursButtons(tags: 5)
//    lazy var fifth2TextField = createHoursButtons(tags: 55)
//    
//    lazy var friButton = createButtons(title: "Fri",color: .black,tags: 7)
//    lazy var sexth1TextField = createHoursButtons(tags: 6)
//    lazy var sexth2TextField = createHoursButtons(tags: 66)
//    
//    lazy var satButton = createButtons(title: "Sat",color: .black,tags: 1)
//    lazy var seventh1TextField = createHoursButtons(tags: 7)
//    lazy var seventh2TextField = createHoursButtons(tags: 77)
//    
//    lazy var mainFirstSecondStack:UIStackView = {
//        let text1Stack = getStack(views: first1TextField,first2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        let text2Stack = getStack(views: second1TextField,second2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        let text3Stack = getStack(views: third1TextField,third2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        
//        let text4Stack = getStack(views: forth1TextField,forth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        
//        let text5Stack = getStack(views: fifth1TextField,fifth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        
//        let text6Stack = getStack(views: sexth1TextField,sexth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        
//        let text7Stack = getStack(views: seventh1TextField,seventh2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
//        let v = getStack(views: text2Stack,text3Stack,text4Stack,text5Stack,text6Stack,text7Stack,text1Stack, spacing: 16, distribution: .fillEqually, axis: .vertical)
//        return v
//    }()
//    lazy var buttonDaysStack:UIStackView = {
//        let v = getStack(views: sunButton,monButton,tuesButton,wedButton,thuButton,friButton,satButton, spacing: 16, distribution: .fillEqually, axis: .vertical)
//        return v
//    }()
//    lazy var totalStack:UIStackView = {
//        let v = getStack(views: buttonDaysStack,mainFirstSecondStack, spacing: 48, distribution: .fillProportionally, axis: .horizontal )
//        return v
//    }()
//    
//    
//    
//    override func setupViews() {
//        
//        [second1TextField,second2TextField].forEach({$0.isEnabled = true})
//        
//        [satButton,sunButton,monButton,tuesButton,thuButton,wedButton,friButton].forEach({$0.constrainWidth(constant: 50)})
//        
//        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,totalStack)
//        
//        
//        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
//        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
//        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
//        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
//        
//        totalStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 90, left: 32, bottom: 0, right: 32))
//        
//    }
//    
//    func creatShiftBTN(title:String,selector:Selector) -> UIButton {
//        let button = UIButton(type: .system)
//        button.backgroundColor = ColorConstants.disabledButtonsGray
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 16
//        button.constrainHeight(constant: 60)
//        button.clipsToBounds = true
//        
//        button.addTarget(self, action: selector, for: .touchUpInside)
//        return button
//        
//    }
//    
//   
//    
//    func putTheses(w:PharamacyWorkingHourModel)  {
//        switch w.day {
//        case 1:
//            putTitleForButtons(bt: first1TextField, text: w.partFrom)
//            putTitleForButtons(bt: first2TextField, text: w.partTo)
//            activeOrNot(v: satButton, d: w.active)
//        //            checkButtonsTextx(w.active, vv: [first1TextField,first1TextField])
//        case 2:
//            putTitleForButtons(bt: second1TextField, text: w.partFrom)
//            putTitleForButtons(bt: second2TextField, text: w.partTo)
//            activeOrNot(v: sunButton, d: w.active)
//            //            checkButtonsTextx(w.active, vv: [second1TextField,second2TextField])
//            
//        case 3:
//            putTitleForButtons(bt: third1TextField, text: w.partFrom)
//            putTitleForButtons(bt: third2TextField, text: w.partTo)
//            activeOrNot(v: monButton, d: w.active)
//            //            checkButtonsTextx(w.active, vv: [third1TextField,third2TextField])
//            
//        case 4:
//            putTitleForButtons(bt: forth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: forth2TextField, text: w.partTo)
//            activeOrNot(v: tuesButton, d: w.active)
//            //            checkButtonsTextx(w.active, vv: [forth1TextField,forth2TextField])
//            
//        case 5:
//            putTitleForButtons(bt: fifth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: fifth2TextField, text: w.partTo)
//            activeOrNot(v: wedButton, d: w.active)
//            //            checkButtonsTextx(w.active, vv: [fifth1TextField,fifth2TextField])
//            
//        case 6:
//            putTitleForButtons(bt: sexth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: sexth2TextField, text: w.partTo)
//            activeOrNot(v: thuButton, d: w.active)
//            //            checkButtonsTextx(w.active, vv: [sexth1TextField,sexth2TextField])
//            
//        default:
//            putTitleForButtons(bt: seventh1TextField, text: w.partFrom)
//            putTitleForButtons(bt: seventh2TextField, text: w.partTo)
//            activeOrNot(v: friButton, d: w.active)
//            //            checkButtonsTextx(w.active, vv: [seventh1TextField,seventh2TextField])
//            
//        }
//    }
//    
//    func putThesesRAD(w:RadiologyWorkingHourModel)  {
//        switch w.day {
//        case 1:
//            putTitleForButtons(bt: first1TextField, text: w.partFrom)
//            putTitleForButtons(bt: first2TextField, text: w.partTo)
//            activeOrNot(v: satButton, d: w.active)
//        case 2:
//            putTitleForButtons(bt: second1TextField, text: w.partFrom)
//            putTitleForButtons(bt: second2TextField, text: w.partTo)
//            activeOrNot(v: sunButton, d: w.active)
//        case 3:
//            putTitleForButtons(bt: third1TextField, text: w.partFrom)
//            putTitleForButtons(bt: third2TextField, text: w.partTo)
//            activeOrNot(v: monButton, d: w.active)
//        case 4:
//            putTitleForButtons(bt: forth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: forth2TextField, text: w.partTo)
//            activeOrNot(v: tuesButton, d: w.active)
//        case 5:
//            putTitleForButtons(bt: fifth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: fifth2TextField, text: w.partTo)
//            activeOrNot(v: wedButton, d: w.active)
//        case 6:
//            putTitleForButtons(bt: sexth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: sexth2TextField, text: w.partTo)
//            activeOrNot(v: thuButton, d: w.active)
//        default:
//            putTitleForButtons(bt: seventh1TextField, text: w.partFrom)
//            putTitleForButtons(bt: seventh2TextField, text: w.partTo)
//            activeOrNot(v: friButton, d: w.active)
//        }
//    }
//    
//    func putThesesLAB(w:LabWorkingHoursModel)  {
//        switch w.day {
//        case 1:
//            putTitleForButtons(bt: first1TextField, text: w.partFrom)
//            putTitleForButtons(bt: first2TextField, text: w.partTo)
//            activeOrNot(v: satButton, d: w.active)
//        case 2:
//            putTitleForButtons(bt: second1TextField, text: w.partFrom)
//            putTitleForButtons(bt: second2TextField, text: w.partTo)
//            activeOrNot(v: sunButton, d: w.active)
//        case 3:
//            putTitleForButtons(bt: third1TextField, text: w.partFrom)
//            putTitleForButtons(bt: third2TextField, text: w.partTo)
//            activeOrNot(v: monButton, d: w.active)
//        case 4:
//            putTitleForButtons(bt: forth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: forth2TextField, text: w.partTo)
//            activeOrNot(v: tuesButton, d: w.active)
//        case 5:
//            putTitleForButtons(bt: fifth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: fifth2TextField, text: w.partTo)
//            activeOrNot(v: wedButton, d: w.active)
//        case 6:
//            putTitleForButtons(bt: sexth1TextField, text: w.partFrom)
//            putTitleForButtons(bt: sexth2TextField, text: w.partTo)
//            activeOrNot(v: thuButton, d: w.active)
//        default:
//            putTitleForButtons(bt: seventh1TextField, text: w.partFrom)
//            putTitleForButtons(bt: seventh2TextField, text: w.partTo)
//            activeOrNot(v: friButton, d: w.active)
//        }
//    }
//    
//    func createHoursButtons(tags:Int) -> UIButton {
//        let t = UIButton()
//        t.layer.borderWidth = 1
//        t.layer.backgroundColor = UIColor.gray.cgColor
//        t.layer.cornerRadius = 16
//        t.clipsToBounds = true
//        t.setTitleColor(.black, for: .normal)
//        t.backgroundColor = .white
//        t.setTitle("00:00", for: .normal)
//        t.constrainHeight(constant: 50)
//        t.tag = tags
//        t.isEnabled = false
//        
//        return t
//    }
//    
//    func enalbes(t:UIButton...,enable:Bool? = true)   {
//        t.forEach({$0.isEnabled = enable ?? true})
//    }
//    
//    func createButtons(title:String,color:UIColor,tags : Int? = 0) -> UIButton {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 8
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.gray.cgColor
//        button.backgroundColor = ColorConstants.disabledButtonsGray
//        button.clipsToBounds = true
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(color, for: .normal)
//        button.constrainHeight(constant: 50)
//        button.tag = tags ?? 0
//        button.layer.cornerRadius = 25
//        
//        return button
//    }
//    
//    
//    func putTitleForButtons(bt:UIButton,text:String)  {
//        bt.setTitle(changeTimeForButtonTitle(values: text), for: .normal)
//    }
//    
//    
//    func changeTimeForButtonTitle(values:String)->String  {
//        var ppp = "am"
//        guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
//        guard let minutes = values.removeSubstringAfterOrBefore(needle: "\(hours):", beforeNeedle: false)  else { return "" }
//        guard let minute = minutes.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
//        
//        ppp = hours > 12 ? "pm" : "am"
//        hours =   hours > 12 ? hours - 12 : hours
//        return "\(hours):\(minute) \(ppp)"
//        
//    }
//    
//    
//    
//    
//    func checkActiveDay(_ d:Int) -> Bool {
//        return d == 1 ? true : false
//    }
//    
//    func checkButtonsTextx(_ d:Int,vv:[UIButton])  {
//        vv.forEach({$0.isEnabled = d == 0 ? false : true})
//    }
//    
//    func activeOrNot(v:UIButton,d:Int)  {
//        //        v.isEnabled = checkActiveDay(d)
//        if v.isEnabled {
//            addGradientInSenderAndRemoveOther(sender: v)
//        }else {}
//    }
//    
//    
//    
//    
//    func checkValidteShifting(bol:Bool,ftf:String?,stf:String?,title:String,ftf2:String?,stf2:String?) -> Bool {
//        let ss = ftf !=  "00:00" && stf != "00:00"
//        let dd = stf == "00:00" && ftf == "00:00"
//        
//        let sss = ftf2 == "00:00" && stf2 == "00:00"
//        let ddd = stf2 != "00:00" && ftf2 != "00:00"
//        
//        if ss && ddd || (ss && sss)  ||  (ddd && dd  ) {
//            return true
//        }else {
//            creatMainSnackBar(message: "\(title) range should be choosen"); return  false
//            
//        }
//        
//    }
//    func checkDayActive(_ d:Int) -> Bool {
//        return d == 1 ? true : false
//    }
//    
//    
//}
//
