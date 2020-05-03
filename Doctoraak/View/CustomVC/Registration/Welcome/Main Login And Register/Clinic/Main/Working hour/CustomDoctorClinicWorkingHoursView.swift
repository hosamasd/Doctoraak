//
//  CustomClinicWorkingHoursView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomDoctorClinicWorkingHoursView: CustomBaseView {
    
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
    
    lazy var titleLabel = UILabel(text: "Clinic", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Fill your data", font: .systemFont(ofSize: 18), textColor: .white)
    
    
    lazy var shift1Button = creatShiftBTN(title: "Shift1")
    lazy var shift2Button = creatShiftBTN(title: "Shift2")
    
    
    lazy var sunButton = createButtons(title: "Sun",color: .white,tags: 2)
    lazy var first1TextField = createHoursButtons(tags: 1)
    lazy var first2TextField = createHoursButtons(tags: 11)
    
    lazy var monButton = createButtons(title: "Mon",color: .black,tags: 3)
    lazy var second1TextField = createHoursButtons(tags: 2)
    lazy var second2TextField = createHoursButtons(tags: 22)
    
    lazy var tuesButton = createButtons(title: "Tue",color: .black,tags: 4)
    lazy var third1TextField = createHoursButtons(tags: 3)
    lazy var third2TextField = createHoursButtons(tags: 33)
    
    lazy var wedButton = createButtons(title: "Wed",color: .black,tags: 5)
    lazy var forth1TextField = createHoursButtons(tags: 4)
    lazy var forth2TextField = createHoursButtons(tags: 44)
    
    lazy var thuButton = createButtons(title: "Thu",color: .black,tags: 6)
    lazy var fifth1TextField = createHoursButtons(tags: 5)
    lazy var fifth2TextField = createHoursButtons(tags: 55)
    
    lazy var friButton = createButtons(title: "Fri",color: .black,tags: 7)
    lazy var sexth1TextField = createHoursButtons(tags: 6)
    lazy var sexth2TextField = createHoursButtons(tags: 66)
    
    lazy var satButton = createButtons(title: "Sat",color: .black,tags: 1)
    lazy var seventh1TextField = createHoursButtons(tags: 7)
    lazy var seventh2TextField = createHoursButtons(tags: 77)
    
    lazy var mainFirstSecondStack:UIStackView = {
        let text1Stack = getStack(views: first1TextField,first2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let text2Stack = getStack(views: second1TextField,second2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let text3Stack = getStack(views: third1TextField,third2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text4Stack = getStack(views: forth1TextField,forth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text5Stack = getStack(views: fifth1TextField,fifth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text6Stack = getStack(views: sexth1TextField,sexth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text7Stack = getStack(views: seventh1TextField,seventh2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let v = getStack(views: text2Stack,text3Stack,text4Stack,text5Stack,text6Stack,text7Stack,text1Stack, spacing: 16, distribution: .fillEqually, axis: .vertical)
        return v
    }()
    lazy var buttonDaysStack:UIStackView = {
        let v = getStack(views: sunButton,monButton,tuesButton,wedButton,thuButton,friButton,satButton, spacing: 16, distribution: .fillEqually, axis: .vertical)
        return v
    }()
    lazy var totalStack:UIStackView = {
        let v = getStack(views: buttonDaysStack,mainFirstSecondStack,mainSecondStack, spacing: 48, distribution: .fillProportionally, axis: .horizontal )
        return v
    }()
    lazy var mainSecondStack:CustomMainCliView = {
        let v = CustomMainCliView()
        v.isHide(true)
        return v
    }()
    
    lazy var doneButton:UIButton = {
        let button = CustomSiftButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //                button.backgroundColor = ColorConstants.disabledButtonsGray
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
        //                button.isEnabled = false
        return button
    }()
    
    var handleShowPickers:((UIButton)->Void)?
    var shiftOne = true
    var shiftTwo = false
    
    var day1:Int = 0
    var day2:Int = 1
    var day3:Int = 0
    var day4:Int = 0
    var day5:Int = 0
    var day6:Int = 0
    var day7:Int = 0
    
    var d1TXT1:String?  = "00:00"
    var d1TXT2:String?  = "00:00"
    var d2TXT1:String?  = "00:00"
    var d2TXT2:String?  = "00:00"
    var d3TXT1:String?  = "00:00"
    var d3TXT2:String?  = "00:00"
    var d4TXT1:String?  = "00:00"
    var d4TXT2:String?  = "00:00"
    var d5TXT1:String?  = "00:00"
    var d5TXT2:String?  = "00:00"
    var d6TXT1:String?  = "00:00"
    var d6TXT2:String?  = "00:00"
    var d7TXT1:String?  = "00:00"
    var d7TXT2:String?  = "00:00"
    
    var d12TXT1:String? = "00:00"
    var d12TXT2:String? = "00:00"
    var d22TXT1:String? = "00:00"
    var d22TXT2:String? = "00:00"
    var d32TXT1:String? = "00:00"
    var d32TXT2:String? = "00:00"
    var d42TXT1:String? = "00:00"
    var d42TXT2:String? = "00:00"
    var d52TXT1:String? = "00:00"
    var d52TXT2:String? = "00:00"
    var d62TXT1:String? = "00:00"
    var d62TXT2:String? = "00:00"
    var d72TXT1:String? = "00:00"
    var d72TXT2:String? = "00:00"
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shift1Button.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: shift1Button)
            shift1Button.setTitleColor(.white, for: .normal)
        }
        if sunButton.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: sunButton)
            sunButton.setTitleColor(.white, for: .normal)
        }
        
        //        putDefualValues()
    }
    
    func getSavedData()  {
        if let f1 = userDefaults.string(forKey: UserDefaultsConstants.first1),let f11 = userDefaults.string(forKey: UserDefaultsConstants.first11),let f12 = userDefaults.string(forKey: UserDefaultsConstants.first211),let f112 = userDefaults.string(forKey: UserDefaultsConstants.first2111),
            let f2 = userDefaults.string(forKey: UserDefaultsConstants.first2),let f21 = userDefaults.string(forKey: UserDefaultsConstants.first21),let f221 = userDefaults.string(forKey: UserDefaultsConstants.first22),let f222 = userDefaults.string(forKey: UserDefaultsConstants.first221),
            let f3 = userDefaults.string(forKey: UserDefaultsConstants.first3),let f31 = userDefaults.string(forKey: UserDefaultsConstants.first31),let f23 = userDefaults.string(forKey: UserDefaultsConstants.first23),let f231 = userDefaults.string(forKey: UserDefaultsConstants.first231),
            let f4 = userDefaults.string(forKey: UserDefaultsConstants.first4),let f41 = userDefaults.string(forKey: UserDefaultsConstants.first41),let f24 = userDefaults.string(forKey: UserDefaultsConstants.first24),let f241 = userDefaults.string(forKey: UserDefaultsConstants.first241),
            let f5 = userDefaults.string(forKey: UserDefaultsConstants.first5),let f51 = userDefaults.string(forKey: UserDefaultsConstants.first51),let f25 = userDefaults.string(forKey: UserDefaultsConstants.first25),let f251 = userDefaults.string(forKey: UserDefaultsConstants.first251),
            let f6 = userDefaults.string(forKey: UserDefaultsConstants.first6),let f61 = userDefaults.string(forKey: UserDefaultsConstants.first61),let f26 = userDefaults.string(forKey: UserDefaultsConstants.first26),let f261 = userDefaults.string(forKey: UserDefaultsConstants.first261),
            
            let f7 = userDefaults.string(forKey: UserDefaultsConstants.first7),let f71 = userDefaults.string(forKey: UserDefaultsConstants.first71),let f27 = userDefaults.string(forKey: UserDefaultsConstants.first27),let f271 = userDefaults.string(forKey: UserDefaultsConstants.first271)
            
            
            
        {
            first1TextField.setTitle(f1, for: .normal)
            first2TextField.setTitle(f11, for: .normal)
            mainSecondStack.first1TextField.setTitle(f12, for: .normal)
            mainSecondStack.first1TextField.setTitle(f112, for: .normal)
            
            second1TextField.setTitle(f2, for: .normal)
            second2TextField.setTitle(f21, for: .normal)
            mainSecondStack.second1TextField.setTitle(f221, for: .normal)
            mainSecondStack.second2TextField.setTitle(f222, for: .normal)
            
            third1TextField.setTitle(f3, for: .normal)
            third2TextField.setTitle(f31, for: .normal)
            mainSecondStack.third1TextField.setTitle(f23, for: .normal)
            mainSecondStack.third2TextField.setTitle(f231, for: .normal)
            
            forth1TextField.setTitle(f4, for: .normal)
            forth2TextField.setTitle(f41, for: .normal)
            mainSecondStack.forth1TextField.setTitle(f24, for: .normal)
            mainSecondStack.forth2TextField.setTitle(f241, for: .normal)
            
            fifth1TextField.setTitle(f5, for: .normal)
            fifth2TextField.setTitle(f51, for: .normal)
            mainSecondStack.fifth1TextField.setTitle(f25, for: .normal)
            mainSecondStack.fifth2TextField.setTitle(f251, for: .normal)
            
            sexth1TextField.setTitle(f6, for: .normal)
            sexth2TextField.setTitle(f61, for: .normal)
            mainSecondStack.sexth1TextField.setTitle(f26, for: .normal)
            mainSecondStack.sexth2TextField.setTitle(f261, for: .normal)
            
            seventh1TextField.setTitle(f7, for: .normal)
            seventh2TextField.setTitle(f71, for: .normal)
            mainSecondStack.seventh1TextField.setTitle(f27, for: .normal)
            mainSecondStack.seventh2TextField.setTitle(f271, for: .normal)
            
            
        }
    }
    
    func putDefualValues()  {
    }
    
    override func setupViews() {
        //        shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
        //               shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        [first2TextField,first1TextField,second1TextField,second2TextField,third1TextField,third2TextField,forth1TextField,forth2TextField,fifth1TextField,fifth2TextField,sexth1TextField,sexth2TextField,seventh2TextField,seventh1TextField,
         mainSecondStack.first1TextField,mainSecondStack.first2TextField,mainSecondStack.second1TextField,mainSecondStack.second2TextField,mainSecondStack.third1TextField,mainSecondStack.third2TextField,mainSecondStack.forth1TextField,mainSecondStack.forth2TextField,mainSecondStack.fifth1TextField,mainSecondStack.fifth2TextField,mainSecondStack.sexth1TextField,mainSecondStack.sexth2TextField,mainSecondStack.seventh2TextField,mainSecondStack.seventh1TextField].forEach({$0
            .addTarget(self, action:#selector(handleShowPicker), for: .touchUpInside)})
        [second1TextField,second2TextField].forEach({$0.isEnabled = true})
        
        [satButton,sunButton,monButton,tuesButton,thuButton,wedButton,friButton].forEach({$0.constrainWidth(constant: 50)})
        
        let ss = getStack(views: shift1Button,shift2Button, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,ss,totalStack,doneButton)
        
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        ss.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 76, left: 32, bottom: 0, right: 32))
        
        totalStack.anchor(top: ss.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    func creatShiftBTN(title:String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 60)
        button.clipsToBounds = true
        return button
        
    }
    
    
    
    func createHoursButtons(tags:Int) -> UIButton {
        let t = UIButton()
        t.layer.borderWidth = 1
        t.layer.backgroundColor = UIColor.gray.cgColor
        t.layer.cornerRadius = 16
        t.clipsToBounds = true
        t.setTitleColor(.black, for: .normal)
        t.backgroundColor = .white
        t.setTitle("00:00", for: .normal)
        t.constrainHeight(constant: 50)
        t.tag = tags
        t.isEnabled = false
        
        return t
    }
    
    func enalbes(t:UIButton...,enable:Bool? = true)   {
        t.forEach({$0.isEnabled = enable ?? true})
    }
    
    func createButtons(title:String,color:UIColor,tags : Int? = 0) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.constrainHeight(constant: 50)
        button.tag = tags ?? 0
        button.layer.cornerRadius = 25
        //        button.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        return button
    }
    
    func titleForButton(_ isShift1:Bool,fbt:UIButton,sbt:UIButton,txt:String)  {
        isShift1 ?    fbt.setTitle(txt, for: .normal) :  sbt.setTitle(txt, for: .normal)
    }
    
    func changeTimeForButtonTitle(values:String)->String  {
        var ppp = "am"
        guard let minute = values.strstr(needle: ":", beforeNeedle: false)?.toInt()  else { return "" }
        guard var hours = values.strstr(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        return "\(hours):\(minute) \(ppp)"
        
    }
    
    func savedData()  {
        userDefaults.set(d1TXT1 , forKey: UserDefaultsConstants.first1)
        userDefaults.set(d1TXT2  , forKey: UserDefaultsConstants.first11)
        userDefaults.set(d12TXT1 , forKey: UserDefaultsConstants.first211)
        userDefaults.set(d12TXT2 , forKey: UserDefaultsConstants.first2111)
        
        userDefaults.set(d2TXT1 , forKey: UserDefaultsConstants.first2)
        userDefaults.set(d2TXT2 , forKey: UserDefaultsConstants.first21)
        userDefaults.set(d22TXT1 , forKey: UserDefaultsConstants.first22)
        userDefaults.set(d22TXT2 , forKey: UserDefaultsConstants.first221)
        
        userDefaults.set(d3TXT1 , forKey: UserDefaultsConstants.first3)
        userDefaults.set(d3TXT2 , forKey: UserDefaultsConstants.first31)
        userDefaults.set(d32TXT1 , forKey: UserDefaultsConstants.first23)
        userDefaults.set(d32TXT2 , forKey: UserDefaultsConstants.first231)
        
        userDefaults.set(d4TXT1 , forKey: UserDefaultsConstants.first4)
        userDefaults.set(d4TXT2 , forKey: UserDefaultsConstants.first41)
        userDefaults.set(d42TXT1  , forKey: UserDefaultsConstants.first24)
        userDefaults.set(d42TXT2 , forKey: UserDefaultsConstants.first241)
        
        userDefaults.set(d5TXT1 , forKey: UserDefaultsConstants.first5)
        userDefaults.set(d5TXT2 , forKey: UserDefaultsConstants.first51)
        userDefaults.set(d52TXT1 , forKey: UserDefaultsConstants.first25)
        userDefaults.set(d52TXT2 , forKey: UserDefaultsConstants.first251)
        
        userDefaults.set(d6TXT1 , forKey: UserDefaultsConstants.first6)
        userDefaults.set(d6TXT2 , forKey: UserDefaultsConstants.first61)
        userDefaults.set(d62TXT1 , forKey: UserDefaultsConstants.first26)
        userDefaults.set(d62TXT2 , forKey: UserDefaultsConstants.first261)
        
        userDefaults.set(d7TXT1 , forKey: UserDefaultsConstants.first7)
        userDefaults.set(d7TXT2 , forKey: UserDefaultsConstants.first71)
        userDefaults.set(d72TXT1 , forKey: UserDefaultsConstants.first27)
        userDefaults.set(d72TXT2 , forKey: UserDefaultsConstants.first271)
        
        userDefaults.set(day1  , forKey: UserDefaultsConstants.day1)
        userDefaults.set(day2  , forKey: UserDefaultsConstants.day2)
        userDefaults.set(day3  , forKey: UserDefaultsConstants.day3)
        userDefaults.set(day4  , forKey: UserDefaultsConstants.day4)
        userDefaults.set(day5  , forKey: UserDefaultsConstants.day5)
        userDefaults.set(day6  , forKey: UserDefaultsConstants.day6)
        userDefaults.set(day7  , forKey: UserDefaultsConstants.day7)
        
        userDefaults.set(true, forKey: UserDefaultsConstants.isClinicWorkingHoursSaved)
        userDefaults.synchronize()
        print(9999)
        
    }
    
    
    //    @objc func handleShowPicker(sender:UIButton) {
    //        var texts = ""
    //        let cc = Calendar.current
    //        var ppp = "am"
    //
    //        setupTimeSelector(timeSelector)
    //        timeSelector.timeSelected = {[unowned self] (timeSelector) in
    //            print(timeSelector.date)
    //            let dd = timeSelector.date
    //
    //            var hour = cc.component(.hour, from: dd)
    //            ppp = hour > 12 ? "pm" : "am"
    //            hour =   hour > 12 ? hour - 12 : hour
    //
    //            let minute = cc.component(.minute, from: dd)
    //            texts = "\(hour):\(minute) \(ppp)"
    //            DispatchQueue.main.async {
    //                self.updateTextField(isShift1: self.shiftOne , tag: sender.tag, texts: texts,hours:hour,mintue:minute,ppp:ppp)
    //            }
    //        }
    //    }
    
    func updateTextField(isShift1:Bool,tag:Int,texts:String,hours:Int,mintue:Int,ppp:String)  {
        var hs = 0
        
        hs  = ppp ==  "pm" ? hours+12 : hours
        
        let ss = "\(hs):\(mintue)"
        switch tag{
        case 1:
            if isShift1 {
                d1TXT1 = ss
                //                chooseWorkingHoursViewModel.d1TXT1 = ss
            }else {
                d12TXT1 = ss
                //                chooseWorkingHoursViewModel.d12TXT1 = ss
            }
            titleForButton(isShift1, fbt: first1TextField, sbt: mainSecondStack.first1TextField, txt: texts)
        case 11:
            if isShift1 {
                d1TXT2 = ss
            }else {
                d12TXT2 = ss
            }
            titleForButton(isShift1, fbt: first2TextField, sbt: mainSecondStack.first2TextField, txt: texts)
            
        case 2:
            if isShift1 {
                d2TXT1 = ss
            }else {
                d22TXT1 = ss
            }
            titleForButton(isShift1, fbt: second1TextField, sbt: mainSecondStack.second1TextField, txt: texts)
            
            
        case 22:
            if isShift1 {
                d2TXT2 = ss
            }else {
                d22TXT2 = ss
            }
            titleForButton(isShift1, fbt: second2TextField, sbt: mainSecondStack.second2TextField, txt: texts)
            
            
        case 3:
            if isShift1 {
                d3TXT1 = ss
            }else {
                d32TXT1 = ss
            }
            titleForButton(isShift1, fbt: third1TextField, sbt: mainSecondStack.third1TextField, txt: texts)
            
            
        case 33:
            if isShift1 {
                d3TXT2 = ss
            }else {
                d32TXT2 = ss
            }
            titleForButton(isShift1, fbt: third2TextField, sbt: mainSecondStack.third2TextField, txt: texts)
            
            
        case 4:
            if isShift1 {
                d4TXT1 = ss
            }else {
                d42TXT1 = ss
            }
            titleForButton(isShift1, fbt: forth1TextField, sbt: mainSecondStack.forth1TextField, txt: texts)
            
        case 44:
            if isShift1 {
                d4TXT2 = ss
            }else {
                d42TXT2 = ss
            }
            titleForButton(isShift1, fbt: forth2TextField, sbt: mainSecondStack.forth2TextField, txt: texts)
            
            
        case 5:
            if isShift1 {
                d5TXT1 = ss
            }else {
                d52TXT1 = ss
            }
            titleForButton(isShift1, fbt: fifth1TextField, sbt: mainSecondStack.fifth1TextField, txt: texts)
            
            
        case 55:
            if isShift1 {
                d5TXT2 = ss
            }else {
                d52TXT2 = ss
            }
            titleForButton(isShift1, fbt: fifth2TextField, sbt: mainSecondStack.fifth2TextField, txt: texts)
            
        case 6:
            if isShift1 {
                d6TXT1 = ss
            }else {
                d62TXT1 = ss
            }
            titleForButton(isShift1, fbt: sexth2TextField, sbt: mainSecondStack.sexth2TextField, txt: texts)
            
            
        case 66:
            if isShift1 {
                d6TXT2 = ss
            }else {
                d62TXT2 = ss
            }
            titleForButton(isShift1, fbt: sexth1TextField, sbt: mainSecondStack.sexth1TextField, txt: texts)
            
            
        case 7:
            if isShift1 {
                d7TXT1 = ss
            }else {
                d72TXT1 = ss
            }
            titleForButton(isShift1, fbt: seventh1TextField, sbt: mainSecondStack.seventh1TextField, txt: texts)
        default:
            if isShift1 {
                d7TXT2 = ss
            }else {
                d72TXT2 = ss
            }
            titleForButton(isShift1, fbt: seventh2TextField, sbt: mainSecondStack.seventh2TextField, txt: texts)
        }
        
        //        choosedHours.append(texts)
    }
    
    
    
    func putDataForVariables(_ ff:String...)  {
        d1TXT1 = ff[0];     d12TXT1=ff[2]
        d1TXT2=ff[1];       d12TXT2=ff[3]
        d2TXT1=ff[4];       d22TXT1=ff[6]
        d2TXT2=ff[5];   d22TXT2=ff[7]
        d3TXT1=ff[8];       d32TXT1=ff[10]
        d3TXT2=ff[9];       d32TXT2=ff[11]
        d4TXT1=ff[12];      d42TXT1=ff[14]
        d4TXT2=ff[13];      d42TXT2=ff[15]
        d5TXT1=ff[16];      d52TXT1=ff[18]
        d5TXT2=ff[17];      d52TXT2=ff[19]
        d6TXT1=ff[20];      d62TXT1=ff[22]
        d6TXT2=ff[21];      d62TXT2=ff[23]
        d7TXT1=ff[24];      d72TXT1=ff[26]
        d7TXT2=ff[25];       d72TXT2=ff[27]
    }
    
    func putOtherData()  {
        let d1 = userDefaults.integer(forKey: UserDefaultsConstants.day1);let d5 = userDefaults.integer(forKey: UserDefaultsConstants.day5)
        let d2 = userDefaults.integer(forKey: UserDefaultsConstants.day2);let d6 = userDefaults.integer(forKey: UserDefaultsConstants.day6)
        let d3 = userDefaults.integer(forKey: UserDefaultsConstants.day3);let d7 = userDefaults.integer(forKey: UserDefaultsConstants.day7)
        let d4 = userDefaults.integer(forKey: UserDefaultsConstants.day4)
        
                   day1 = d1;  day2=d2;    day3=d3;    day4=d4;    day5=d5;    day6=d6;    day7=d7
                   checkIfButtonsEnabled(enable: day1, vv: satButton)
                   checkIfButtonsEnabled(enable: day2, vv: sunButton)
                   checkIfButtonsEnabled(enable: day3, vv: monButton)
                   checkIfButtonsEnabled(enable: day4, vv: tuesButton)
                   checkIfButtonsEnabled(enable: day5, vv: wedButton)
                   checkIfButtonsEnabled(enable: day6, vv: thuButton)
                   checkIfButtonsEnabled(enable: day7, vv: friButton)
    }
    
    func checkIfButtonsEnabled(enable:Int,vv:UIButton)  {
        if enable == 1 {
            enableTextFields(enable: true, tag: vv.tag)
            addGradientInSenderAndRemoveOtherss(sender: vv)
        }else {}
        
        
    }
    
    func enableTextFields(enable:Bool,tag:Int)  {
        switch tag {
        case 1:
            enalbes(t: first1TextField,first2TextField,mainSecondStack.first1TextField,mainSecondStack.first2TextField,enable:enable)
            day1 =  enable ? 1 : 0
        case 2:
            enalbes(t: second1TextField,second2TextField,mainSecondStack.second1TextField,mainSecondStack.second2TextField,enable:enable)
            day2 = enable ? 1 : 0
        case 3:
            enalbes(t: third1TextField,third2TextField,mainSecondStack.third1TextField,mainSecondStack.third2TextField,enable:enable)
            day3 = enable ? 1 : 0
        case 4:
            enalbes(t: forth1TextField,forth2TextField,mainSecondStack.forth1TextField,mainSecondStack.forth2TextField,enable:enable)
            day4 = enable ? 1 : 0
        case 5:
            enalbes(t: fifth1TextField,fifth2TextField,mainSecondStack.fifth1TextField,mainSecondStack.fifth2TextField,enable:enable)
            day5 = enable ? 1 : 0
        case 6:
            enalbes(t: sexth1TextField,sexth2TextField,mainSecondStack.sexth1TextField,mainSecondStack.sexth2TextField,enable:enable)
            day6 = enable ? 1 : 0
        default:
            enalbes(t: seventh1TextField,seventh2TextField,mainSecondStack.seventh1TextField,mainSecondStack.seventh2TextField,enable:enable)
            day7 = enable ? 1 : 0
        }
    }
    //    func enableTextFields(tag:Int)  {
    //        switch tag {
    //        case 1:
    //            enalbes(t: first1TextField,first2TextField)
    //        case 2:
    //            enalbes(t: second1TextField,second2TextField)
    //        case 3:
    //            enalbes(t: third1TextField,third2TextField)
    //        case 4:
    //            enalbes(t: forth1TextField,forth2TextField)
    //        case 5:
    //            enalbes(t: fifth1TextField,fifth2TextField)
    //        case 6:
    //            enalbes(t: sexth1TextField,sexth2TextField)
    //        default:
    //            enalbes(t: seventh1TextField,seventh2TextField)
    //
    //        }
    //    }
    //
    //  @objc  func handleOpen(sender:UIButton)  {
    //        enableTextFields(tag: sender.tag)
    //    addGradientInSenderAndRemoveOther(sender: sender)
    //    }
    
    @objc func handleShowPicker(sender:UIButton) {
        handleShowPickers?(sender)
    }
    
    @objc func tapDone()  {
        print(969)
    }
    
    func checkActiveDay(_ d:Int) -> Bool {
        return d == 1 ? true : false
    }
    
    func getDays() -> [String] {
        var ss = [String]()
        ss.append(checkActiveDay(day1) ? "Sat" : checkActiveDay(day2) ? "Sun" : checkActiveDay(day3) ? "Mon" : checkActiveDay(day4) ? "Tue" : checkActiveDay(day5) ? "Wed" : checkActiveDay(day6) ? "Thr" : "Fri" )
        return ss
    }
    
    func getDaysIndex() -> [Int] {
        var ss = [Int]()
        ss.append(checkActiveDay(day1) ? 1 : checkActiveDay(day2) ? 2 : checkActiveDay(day3) ? 3 : checkActiveDay(day4) ? 4 : checkActiveDay(day5) ? 5 : checkActiveDay(day6) ? 6 : 7)
        
        return ss
    }
    
    func getChoosenHours() -> [WorkModel] {
        
        let v:[WorkModel] =   [
            .init(part1From: d1TXT2!, part1To: d1TXT2!, part2From: d12TXT1!, part2To: d12TXT2!, day: 1, active: day1),
            .init(part1From: d1TXT2!, part1To: d1TXT2!, part2From: d12TXT1!, part2To: d12TXT2!, day: 2, active: day2),
            .init(part1From: d1TXT2!, part1To: d1TXT2!, part2From: d12TXT1!, part2To: d12TXT2!, day: 1, active: day3),
            .init(part1From: d1TXT2!, part1To: d1TXT2!, part2From: d12TXT1!, part2To: d12TXT2!, day: 1, active: day4),
            .init(part1From: d1TXT2!, part1To: d1TXT2!, part2From: d12TXT1!, part2To: d12TXT2!, day: 1, active: day5),
            .init(part1From: d1TXT2!, part1To: d1TXT2!, part2From: d12TXT1!, part2To: d12TXT2!, day: 1, active: day6),
            .init(part1From: d1TXT2!, part1To: d1TXT2!, part2From: d12TXT1!, part2To: d12TXT2!, day: 1, active: day7)
            
        ]
        return v
    }
    
}
