//
//  CustomMainsClinicWorkingHoursView.swift
//  Doctoraak
//
//  Created by hosam on 4/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomMainClinicWorkingHoursView: CustomBaseView {
    
    var workingHoursCachedLAB:[PharamacyWorkModel]?{
          didSet{
              guard let work = workingHoursCachedLAB else { return  }
              work.forEach { (w) in
                  putThesesCached(w: w)
              }
          }
      }
      
      var workingHoursCachedRAD:[PharamacyWorkModel]?{
          didSet{
              guard let work = workingHoursCachedRAD else { return  }
              work.forEach { (w) in
                  putThesesCached(w: w)
              }
          }
      }
      
      var workingHoursCachedPHY:[PharamacyWorkModel]?{
          didSet{
              guard let work = workingHoursCachedPHY else { return  }
              work.forEach { (w) in
                  putThesesCached(w: w)
              }
          }
      }
    
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
    
    lazy var titleLabel = UILabel(text: "Clinic".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Fill your data".localized, font: .systemFont(ofSize: 18), textColor: .white)
    
    
    
    lazy var sunButton = createButtons(title: "Sun".localized,color: .black,tags: 2)
    lazy var first1TextField = createHoursButtons(tags: 1)
    lazy var first2TextField = createHoursButtons(tags: 11)
    
    lazy var monButton = createButtons(title: "Mon".localized,color: .black,tags: 3)
    lazy var second1TextField = createHoursButtons(tags: 2)
    lazy var second2TextField = createHoursButtons(tags: 22)
    
    lazy var tuesButton = createButtons(title: "Tue".localized,color: .black,tags: 4)
    lazy var third1TextField = createHoursButtons(tags: 3)
    lazy var third2TextField = createHoursButtons(tags: 33)
    
    lazy var wedButton = createButtons(title: "Wed".localized,color: .black,tags: 5)
    lazy var forth1TextField = createHoursButtons(tags: 4)
    lazy var forth2TextField = createHoursButtons(tags: 44)
    
    lazy var thuButton = createButtons(title: "Thu".localized,color: .black,tags: 6)
    lazy var fifth1TextField = createHoursButtons(tags: 5)
    lazy var fifth2TextField = createHoursButtons(tags: 55)
    
    lazy var friButton = createButtons(title: "Fri".localized,color: .black,tags: 7)
    lazy var sexth1TextField = createHoursButtons(tags: 6)
    lazy var sexth2TextField = createHoursButtons(tags: 66)
    
    lazy var satButton = createButtons(title: "Sat".localized,color: .black,tags: 1)
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
        let v = getStack(views: buttonDaysStack,mainFirstSecondStack, spacing: 48, distribution: .fillProportionally, axis: .horizontal )
        return v
    }()
    
    
    lazy var doneButton:UIButton = {
        let button = CustomSiftButton(type: .system)
        button.setTitle("Done".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        //                button.backgroundColor = ColorConstants.disabledButtonsGray
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
        //                button.isEnabled = false
        return button
    }()
    
    var handleShowPickers:((UIButton)->Void)?
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
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if sunButton.backgroundColor != nil && userDefaults.bool(forKey: UserDefaultsConstants.isWorkingHoursSaved){
            addGradientInSenderAndRemoveOther(sender: sunButton)
            sunButton.setTitleColor(.white, for: .normal)
        }
        
    }
    
    
    
    func savedData()  {
        userDefaults.set(d1TXT1 , forKey: UserDefaultsConstants.mainfirst1)
        userDefaults.set(d1TXT2  , forKey: UserDefaultsConstants.mainfirst11)
        
        userDefaults.set(d2TXT1 , forKey: UserDefaultsConstants.mainfirst2)
        userDefaults.set(d2TXT2 , forKey: UserDefaultsConstants.mainfirst21)
        
        userDefaults.set(d3TXT1 , forKey: UserDefaultsConstants.mainfirst3)
        userDefaults.set(d3TXT2 , forKey: UserDefaultsConstants.mainfirst31)
        
        userDefaults.set(d4TXT1 , forKey: UserDefaultsConstants.mainfirst4)
        userDefaults.set(d4TXT2 , forKey: UserDefaultsConstants.mainfirst41)
        
        userDefaults.set(d5TXT1 , forKey: UserDefaultsConstants.mainfirst5)
        userDefaults.set(d5TXT2 , forKey: UserDefaultsConstants.mainfirst51)
        
        userDefaults.set(d6TXT1 , forKey: UserDefaultsConstants.mainfirst6)
        userDefaults.set(d6TXT2 , forKey: UserDefaultsConstants.mainfirst61)
        
        userDefaults.set(d7TXT1 , forKey: UserDefaultsConstants.mainfirst7)
        userDefaults.set(d7TXT2 , forKey: UserDefaultsConstants.mainfirst71)
        
        userDefaults.set(day1  , forKey: UserDefaultsConstants.mainday1)
        userDefaults.set(day2  , forKey: UserDefaultsConstants.mainday2)
        userDefaults.set(day3  , forKey: UserDefaultsConstants.mainday3)
        userDefaults.set(day4  , forKey: UserDefaultsConstants.mainday4)
        userDefaults.set(day5  , forKey: UserDefaultsConstants.mainday5)
        userDefaults.set(day6  , forKey: UserDefaultsConstants.mainday6)
        userDefaults.set(day7  , forKey: UserDefaultsConstants.mainday7)
        
        userDefaults.set(true, forKey: UserDefaultsConstants.isWorkingHoursSaved)
        userDefaults.synchronize()
        print(9999)
        
    }
    
    func putDataForVariables(_ ff:String...)  {
        d1TXT1 = ff[0]
        d1TXT2=ff[1]
        d2TXT1=ff[2]
        d2TXT2=ff[3]
        d3TXT1=ff[4]
        d3TXT2=ff[5]
        d4TXT1=ff[6]
        d4TXT2=ff[7]
        d5TXT1=ff[8]
        d5TXT2=ff[9]
        d6TXT1=ff[10]
        d6TXT2=ff[11]
        d7TXT1=ff[12]
        d7TXT2=ff[13]
    }
    
    func changeTimeForButtonTitle(_ values:String)->String  {
        var ppp = "am"
        guard let minute = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: false)?.toInt()  else { return "" }
        guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        return "\(hours):\(minute) \(ppp)"
    }
    
    func getSavedData()  {
        
        //        if !userDefaults.bool(forKey: UserDefaultsConstants.isWorkingHoursSaved) { }else {
        
        if let f1 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst1),let f11 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst11),
            let f2 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst2),let f21 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst21),
            let f3 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst3),let f31 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst31),
            let f4 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst4),let f41 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst41),
            let f5 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst5),let f51 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst51),
            let f6 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst6),let f61 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst61),
            
            let f7 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst7),let f71 = userDefaults.string(forKey: UserDefaultsConstants.mainfirst71)
            
            
            
            
        {
            putDataForVariables(f1,f11,f2,f21,f3,f31,f4,f41,f5,f51,f6,f61,f7,f71)
            
            first1TextField.setTitle(changeTimeForButtonTitle(f1), for: .normal)
            first2TextField.setTitle(changeTimeForButtonTitle(f11), for: .normal)
            
            second1TextField.setTitle(changeTimeForButtonTitle(f2), for: .normal)
            second2TextField.setTitle(changeTimeForButtonTitle(f21), for: .normal)
            
            third1TextField.setTitle(changeTimeForButtonTitle(f3), for: .normal)
            third2TextField.setTitle(changeTimeForButtonTitle(f31), for: .normal)
            
            forth1TextField.setTitle(changeTimeForButtonTitle(f4), for: .normal)
            forth2TextField.setTitle(changeTimeForButtonTitle(f41), for: .normal)
            
            fifth1TextField.setTitle(changeTimeForButtonTitle(f5), for: .normal)
            fifth2TextField.setTitle(changeTimeForButtonTitle(f51), for: .normal)
            
            
            sexth1TextField.setTitle(changeTimeForButtonTitle(f6), for: .normal)
            sexth2TextField.setTitle(changeTimeForButtonTitle(f61), for: .normal)
            
            
            seventh1TextField.setTitle(changeTimeForButtonTitle(f7), for: .normal)
            seventh2TextField.setTitle(changeTimeForButtonTitle(f71), for: .normal)
            putDefualValues()
        }
        //        }
    }
    
    func putDefualValues()  {
        let d1 = userDefaults.integer(forKey: UserDefaultsConstants.mainday1);let d2 = userDefaults.integer(forKey: UserDefaultsConstants.mainday2)
        let d3 = userDefaults.integer(forKey: UserDefaultsConstants.mainday3);let d4 = userDefaults.integer(forKey: UserDefaultsConstants.mainday4)
        let d5 = userDefaults.integer(forKey: UserDefaultsConstants.mainday5);let d6 = userDefaults.integer(forKey: UserDefaultsConstants.mainday6)
        let d7 = userDefaults.integer(forKey: UserDefaultsConstants.mainday7)
        
        day1=d1;    day2=d2;    day3=d3;    day4=d4;    day5=d5;    day6=d6;day7=d7
        
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
            addGradientInSenderAndRemoveOtherss(sender: vv)
        }else { }
        enableTextFields(enable: true, tag: vv.tag)
        
        
    }
    
    override func setupViews() {
        
        [first2TextField,first1TextField,second1TextField,second2TextField,third1TextField,third2TextField,forth1TextField,forth2TextField,fifth1TextField,fifth2TextField,sexth1TextField,sexth2TextField,seventh2TextField,seventh1TextField].forEach({$0
            .addTarget(self, action:#selector(handleShowPicker), for: .touchUpInside)})
        [second1TextField,second2TextField].forEach({$0.isEnabled = true})
        
        [satButton,sunButton,monButton,tuesButton,thuButton,wedButton,friButton].forEach({$0.constrainWidth(constant: 50)})
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,totalStack,doneButton)
        
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        totalStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 0, right: 32))
        
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
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
    
    func enalbes(t:UIButton...,enable:Bool )   {
        
        t.forEach({$0.isEnabled = enable })
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
        button.addTarget(self, action:#selector(handleOpen), for: .touchUpInside)
        //        button.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        return button
    }
    
    
    func titleForButton(fbt:UIButton,txt:String)  {
        fbt.setTitle(txt, for: .normal)
    }
    
    
    
    func checkIfButtonsEnabled(enable:Bool,vv:UIButton)  {
        if enable {
            enableTextFields(enable: true, tag: vv.tag)
            addGradientInSenderAndRemoveOtherss(sender: vv)
        }else {}
        
        
    }
    
    func updateTextField(tag:Int,texts:String,hours:Int,mintue:Int,ppp:String)  {
        var hs = 0
        
        hs  = ppp ==  "pm" ? hours+12 : hours
        
        let ss = "\(hs):\(mintue)"
        switch tag{
        case 1:
            d1TXT1 = ss
            
            titleForButton( fbt: first1TextField, txt: texts)
        case 11:
            d1TXT2 = ss
            
            titleForButton( fbt: first2TextField, txt: texts)
            
        case 2:
            d2TXT1 = ss
            titleForButton( fbt: second1TextField, txt: texts)
            
            
        case 22:
            d2TXT2 = ss
            
            titleForButton( fbt: second2TextField,  txt: texts)
            
            
        case 3:
            d3TXT1 = ss
            
            titleForButton( fbt: third1TextField, txt: texts)
            
            
        case 33:
            d3TXT2 = ss
            
            titleForButton( fbt: third2TextField, txt: texts)
            
            
        case 4:
            d4TXT1 = ss
            
            titleForButton( fbt: forth1TextField, txt: texts)
            
        case 44:
            d4TXT2 = ss
            
            titleForButton(fbt: forth2TextField, txt: texts)
            
            
        case 5:
            d5TXT1 = ss
            
            titleForButton( fbt: fifth1TextField,  txt: texts)
            
            
        case 55:
            d5TXT2 = ss
            
            titleForButton( fbt: fifth2TextField, txt: texts)
            
        case 6:
            d6TXT1 = ss
            
            titleForButton(fbt: sexth1TextField, txt: texts)
            
            
        case 66:
            d6TXT2 = ss
            
            titleForButton( fbt: sexth2TextField,txt: texts)
            
            
        case 7:
            d7TXT1 = ss
            
            titleForButton( fbt: seventh1TextField,  txt: texts)
        default:
            d7TXT2 = ss
            
            titleForButton(fbt: seventh2TextField,  txt: texts)
        }
        
    }
    
    func titleForButton(fbt:UIButton,sbt:UIButton,txt:String)  {
        fbt.setTitle(txt, for: .normal)
    }
    
    func enableTextFields(enable:Bool,tag:Int)  {
        switch tag {
        case 1:
            enalbes(t: first1TextField,first2TextField, enable: enable)
            day1 =  enable ? 1 : 0
        case 2:
            enalbes(t: second1TextField,second2TextField,enable:enable)
            day2 = enable ? 1 : 0
        case 3:
            enalbes(t: third1TextField,third2TextField, enable: enable)
            day3 = enable ? 1 : 0
        case 4:
            enalbes(t: forth1TextField,forth2TextField, enable: enable)
            day4 = enable ? 1 : 0
        case 5:
            enalbes(t: fifth1TextField,fifth2TextField, enable: enable)
            day5 = enable ? 1 : 0
        case 6:
            enalbes(t: sexth1TextField,sexth2TextField, enable: enable)
            day6 = enable ? 1 : 0
        default:
            enalbes(t: seventh1TextField,seventh2TextField, enable: enable)
            day7 = enable ? 1 : 0
        }
    }
    
    
    func checkActiveDay(_ d:Int) -> Bool {
        return d == 1 ? true : false
    }
    
    func checkValidteShifting(bol:Bool,ftf:String?,stf:String?,title:String) -> Bool {
        let ss = ftf !=  "00:00" && stf != "00:00"
        
        if ss   {
            return true
        }else {
            creatMainSnackBar(message: "\(title) range should be choosen"); return  false
        }
    }
    
    func checkDayActive(_ d:Int) -> Bool {
        return d == 1 ? true : false
    }
    
    func checkDoneEnabled() -> Bool {
        if checkDayActive( day1 ){
            if checkValidteShifting(bol: checkDayActive( day1), ftf: d1TXT1, stf: d1TXT2, title: "Saturday "){}else {return false}
        }
        if checkDayActive(day2) {
            if  checkValidteShifting(bol: checkDayActive(day2), ftf: d2TXT1, stf: d2TXT2, title: "Sunday") {}else {return false}
            
        }
        if checkDayActive(day3) {
            if checkValidteShifting(bol: checkDayActive(day3), ftf: d3TXT1, stf: d3TXT2, title: "Monday"){}else {return false}
        }
        if checkDayActive(day4) {
            if checkValidteShifting(bol: checkDayActive(day4), ftf: d4TXT1, stf: d4TXT2, title: "Tuesday"){}else {return false}
        }
        if checkDayActive(day5) {
            if checkValidteShifting(bol: checkDayActive(day5), ftf: d5TXT1, stf: d5TXT2, title: "Wednsday"){}else {return false}
        }
        if checkDayActive(day6) {
            if checkValidteShifting(bol: checkDayActive(day6), ftf: d6TXT1, stf: d6TXT2, title: "Thrusday "){}else {return false}
        }
        if checkDayActive(day7) {
            
            if checkValidteShifting(bol: checkDayActive(day7), ftf: d7TXT1, stf: d7TXT2, title: "Friday") {}else {return false}
        }
        return true
    }
    
    
    func getDays() -> [String] {
        var ss = [String]()
        if checkActiveDay(day1) {
            ss.append("Sat")
        }
        if checkActiveDay(day2) {
            ss.append("Sun")
        }
        if checkActiveDay(day3) {
            ss.append("Mon")
        }
        if checkActiveDay(day4) {
            ss.append("Tue")
        }
        if checkActiveDay(day5) {
            ss.append("Wed")
        }
        if checkActiveDay(day6) {
            ss.append("Thr")
        }
        if checkActiveDay(day7) {
            ss.append("Fri")
        }
        return ss
    }
    
    func getDaysIndex() -> [Int] {
        var ss = [Int]()
        ss.append(checkActiveDay(day1) ? 1 : checkActiveDay(day2) ? 2 : checkActiveDay(day3) ? 3 : checkActiveDay(day4) ? 4 : checkActiveDay(day5) ? 5 : checkActiveDay(day6) ? 6 : 7)
        
        return ss
    }
    
    func getChoosenHours() -> [PharamacyWorkModel] {
        
        let v:[PharamacyWorkModel] =   [
            
            .init(partFrom: d1TXT1!,partTo: d1TXT2!, day: 1, active: day1),
            .init(partFrom: d2TXT1!,partTo: d2TXT2!, day: 2, active: day2),
            .init(partFrom: d3TXT1!,partTo: d3TXT2!, day: 3, active: day3),
            .init(partFrom: d4TXT1!,partTo: d4TXT2!, day: 4, active: day4),
            .init(partFrom: d5TXT1!,partTo: d5TXT2!, day: 5, active: day5),
            .init(partFrom: d6TXT1! ,partTo: d6TXT2!, day: 6, active: day6),
            .init(partFrom: d7TXT1! ,partTo: d7TXT2!, day: 7, active: day7)
            
        ]
        return v
    }
    
    func putTitleForButtons(bt:UIButton,text:String)  {
           bt.setTitle(changeTimeForButtonTitle(values: text), for: .normal)
       }
    
    func changeTimeForButtonTitle(values:String)->String  {
        if values == "00:00" {
            return "00:00"
        }
           var ppp = "am"
           guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
           guard let minute = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: false)  else { return "" }
           
           ppp = hours > 12 ? "pm" : "am"
           hours =   hours > 12 ? hours - 12 : hours
           return "\(hours):\(minute) \(ppp)"
           
       }
    
    func activeOrNot(v:UIButton,d:Int)  {
                   v.isEnabled = checkActiveDay(d)
           if v.isEnabled {
               addGradientInSenderAndRemoveOther(sender: v)
           }else {}
       }
    
    func putThesesCached(w:PharamacyWorkModel)  {
           switch w.day {
           case 1:
               putTitleForButtons(bt: first1TextField, text: w.partFrom)
               putTitleForButtons(bt: first2TextField, text: w.partTo)
               activeOrNot(v: satButton, d: w.active)
           //            checkButtonsTextx(w.active, vv: [first1TextField,first1TextField])
           case 2:
               putTitleForButtons(bt: second1TextField, text: w.partFrom)
               putTitleForButtons(bt: second2TextField, text: w.partTo)
               activeOrNot(v: sunButton, d: w.active)
               //            checkButtonsTextx(w.active, vv: [second1TextField,second2TextField])
               
           case 3:
               putTitleForButtons(bt: third1TextField, text: w.partFrom)
               putTitleForButtons(bt: third2TextField, text: w.partTo)
               activeOrNot(v: monButton, d: w.active)
               //            checkButtonsTextx(w.active, vv: [third1TextField,third2TextField])
               
           case 4:
               putTitleForButtons(bt: forth1TextField, text: w.partFrom)
               putTitleForButtons(bt: forth2TextField, text: w.partTo)
               activeOrNot(v: tuesButton, d: w.active)
               //            checkButtonsTextx(w.active, vv: [forth1TextField,forth2TextField])
               
           case 5:
               putTitleForButtons(bt: fifth1TextField, text: w.partFrom)
               putTitleForButtons(bt: fifth2TextField, text: w.partTo)
               activeOrNot(v: wedButton, d: w.active)
               //            checkButtonsTextx(w.active, vv: [fifth1TextField,fifth2TextField])
               
           case 6:
               putTitleForButtons(bt: sexth1TextField, text: w.partFrom)
               putTitleForButtons(bt: sexth2TextField, text: w.partTo)
               activeOrNot(v: thuButton, d: w.active)
               //            checkButtonsTextx(w.active, vv: [sexth1TextField,sexth2TextField])
               
           default:
               putTitleForButtons(bt: seventh1TextField, text: w.partFrom)
               putTitleForButtons(bt: seventh2TextField, text: w.partTo)
               activeOrNot(v: friButton, d: w.active)
               //            checkButtonsTextx(w.active, vv: [seventh1TextField,seventh2TextField])
               
           }
       }
    
    @objc func handleShowPicker(sender:UIButton) {
        handleShowPickers?(sender)
    }
    
    @objc func tapDone()  {
        print(969)
    }
    
    @objc  func handleOpen(sender:UIButton)  {
        if sender.backgroundColor == nil {
            //disable button
            removeGradientInSender(sender:sender)
            enableTextFields(enable: false, tag: sender.tag)
            return
        }
        //enable button
        enableTextFields(enable: true, tag: sender.tag)
        addGradientInSenderAndRemoveOtherss(sender: sender)
    }
    
}

