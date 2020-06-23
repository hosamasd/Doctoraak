//
//  CustomClinicWorkingHoursView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomDoctorClinicWorkingHoursView: CustomBaseView {
    
    
    //    var workingHours:[RadiologyWorkingHourModel]?{
    //           didSet{
    //               guard let work = workingHoursRAD else { return  }
    //               work.forEach { (w) in
    //                   putThesesRAD(w: w)
    //                   putDefaultRAD(l:w)
    //
    //               }
    //           }
    //       }
    
    var workingHoursCachedDoc:[WorkModel]?{
        didSet{
            guard let work = workingHoursCachedDoc else { return  }
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
    
    
    lazy var shift1Button = creatShiftBTN(title: "Shift1".localized, selector: #selector(handle1Shift))
    lazy var shift2Button = creatShiftBTN(title: "Shift2".localized, selector: #selector(handle2Shift(sender:)))
    
    
    lazy var sunButton = createButtons(title: "Sun".localized,color: .white,tags: 2)
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
    
    func creatShiftBTN(title:String,selector:Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 60)
        button.clipsToBounds = true
        
        button.addTarget(self, action: selector, for: .touchUpInside)
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
        button.addTarget(self, action:#selector(handleOpen), for: .touchUpInside)
        return button
    }
    
    func titleForButton(_ isShift1:Bool,fbt:UIButton,sbt:UIButton,txt:String)  {
        isShift1 ?    fbt.setTitle(txt, for: .normal) :  sbt.setTitle(txt, for: .normal)
    }
    
    func changeTimeForButtonTitle(values:String)->String  {
        var ppp = "am"
        guard let minute = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: false)?.toInt()  else { return "" }
        guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        return "\(hours):\(minute) \(ppp)"
        
    }
    
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
            titleForButton(isShift1, fbt: sexth1TextField, sbt: mainSecondStack.sexth1TextField, txt: texts)
            
            
        case 66:
            if isShift1 {
                d6TXT2 = ss
            }else {
                d62TXT2 = ss
            }
            titleForButton(isShift1, fbt: sexth2TextField, sbt: mainSecondStack.sexth2TextField, txt: texts)
            
            
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
            
            .init(part1From: d1TXT1!, part1To: d1TXT2!, part2From: d12TXT1!, part2To: d12TXT2!, day: 1, active: day1),
            .init(part1From: d2TXT1!, part1To: d2TXT2!, part2From: d22TXT1!, part2To: d22TXT2!, day: 2, active: day2),
            .init(part1From: d3TXT1!, part1To: d3TXT2!, part2From: d32TXT1!, part2To: d32TXT2!, day: 3, active: day3),
            .init(part1From: d4TXT1!, part1To: d4TXT2!, part2From: d42TXT1!, part2To: d42TXT2!, day: 4, active: day4),
            .init(part1From: d5TXT1!, part1To: d5TXT2!, part2From: d52TXT1!, part2To: d52TXT2!, day: 5, active: day5),
            .init(part1From: d6TXT1!, part1To: d6TXT2!, part2From: d62TXT1!, part2To: d62TXT2!, day: 6, active: day6),
            .init(part1From: d7TXT1!, part1To: d7TXT2!, part2From: d72TXT1!, part2To: d72TXT2!, day: 7, active: day7)
            
        ]
        return v
    }
    
    func showAndHide(fv:UIView,sv:UIView)  {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            fv.isHide(true)
            sv.isHide(false)
        })
    }
    
    func changeShiftStates(sender:UIButton,second:UIButton,enable1:Bool,enable2:Bool,vv:UIView...)  {
        if sender.backgroundColor == nil {
            
            return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: second)
        shiftTwo = enable2
        shiftOne = enable1
        showAndHide(fv: vv[0], sv: vv[1])
    }
    
    func checkValidteShifting(bol:Bool,ftf:String?,stf:String?,title:String,ftf2:String?,stf2:String?) -> Bool {
        let ss = ftf !=  "00:00" && stf != "00:00"
        let dd = stf == "00:00" && ftf == "00:00"
        
        let sss = ftf2 == "00:00" && stf2 == "00:00"
        let ddd = stf2 != "00:00" && ftf2 != "00:00"
        
        if ss && ddd || (ss && sss)  ||  (ddd && dd  ) {
            return true
        }else {
            creatMainSnackBar(message: "\(title) range should be choosen"); return  false
            
        }
        
    }
    func checkDayActive(_ d:Int) -> Bool {
        return d == 1 ? true : false
    }
    
    func checkButtonDone() -> Bool {
        if checkDayActive( day1 ){
            if checkValidteShifting(bol: checkDayActive( day1), ftf: d1TXT1, stf: d1TXT2, title: "Saturday ",ftf2: d12TXT1,stf2: d12TXT2){}else {return false}
        }
        if checkDayActive(day2) {
            if  checkValidteShifting(bol: checkDayActive(day2), ftf: d2TXT1, stf: d2TXT2, title: "Sunday",ftf2: d22TXT1,stf2: d22TXT2) {}else {return false}
            
        }
        if checkDayActive(day3) {
            if checkValidteShifting(bol: checkDayActive(day3), ftf: d3TXT1, stf: d3TXT2, title: "Monday",ftf2: d32TXT1,stf2: d32TXT2){}else {return false}
        }
        if checkDayActive(day4) {
            if checkValidteShifting(bol: checkDayActive(day4), ftf: d4TXT1, stf: d4TXT2, title: "Tuesday",ftf2: d42TXT1,stf2: d42TXT2){}else {return false}
        }
        if checkDayActive(day5) {
            if checkValidteShifting(bol: checkDayActive(day5), ftf: d5TXT1, stf: d5TXT2, title: "Wednsday",ftf2: d52TXT1,stf2: d52TXT2){}else {return false}
        }
        if checkDayActive(day6) {
            if checkValidteShifting(bol: checkDayActive(day6), ftf: d6TXT1, stf: d6TXT2, title: "Thrusday ",ftf2: d62TXT1,stf2: d62TXT2){}else {return false}
        }
        if checkDayActive(day7) {
            
            if checkValidteShifting(bol: checkDayActive(day7), ftf: d7TXT1, stf: d7TXT2, title: "Friday",ftf2: d72TXT1,stf2: d72TXT2) {}else {return false}
        }
        return true
        
    }
    
    func putTitleForButtons(b:Bool,bt:UIButton,text:String)  {
        bt.setTitle(b == false ? changeTimeForButtonTitles(values: text): changeTimeForButtonTitless(values: text), for: .normal)
        print(999)
    }
    
    func changeTimeForButtonTitles(values:String)->String  {
        var ppp = "am"
        guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        guard let minutes = values.removeSubstringAfterOrBefore(needle: "\(hours):", beforeNeedle: false)  else { return "" }
        guard let minute = minutes.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        return "\(hours):\(minute) \(ppp)"
        
    }
    
    func changeTimeForButtonTitless(values:String)->String  {
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
        //        if isFromUpdateProfile {
        //             v.isEnabled = checkActiveDay(d)
        //        }
        //                   v.isEnabled = checkActiveDay(d)
        if checkActiveDay(d) {
            addGradientInSenderAndRemoveOther(sender: v)
        }else {}
    }
    
    func putThesesCached(w:WorkModel)  {
        switch w.day {
        case 1:
            putTitleForButtons(b: true, bt: first1TextField, text: w.part1From)
            putTitleForButtons(b: true,bt: first2TextField, text: w.part1To)
            putTitleForButtons(b: true, bt:mainSecondStack.first1TextField , text: w.part2From)
            putTitleForButtons(b: true,bt: mainSecondStack.first2TextField, text: w.part2To)
            activeOrNot(v: satButton, d: w.active)
        //            checkButtonsTextx(w.active, vv: [first1TextField,first1TextField])
        case 2:
            putTitleForButtons(b: true,bt: second1TextField, text: w.part1From)
            putTitleForButtons(b: true,bt: second2TextField, text: w.part1To)
            putTitleForButtons(b: true,bt: mainSecondStack.second1TextField, text: w.part2From)
            putTitleForButtons(b: true,bt: mainSecondStack.second2TextField, text: w.part2To)
            activeOrNot(v: sunButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [second1TextField,second2TextField])
            
        case 3:
            putTitleForButtons(b: true,bt: third1TextField, text: w.part1From)
            putTitleForButtons(b: true,bt: third2TextField, text: w.part1To)
            putTitleForButtons(b: true,bt: mainSecondStack.third1TextField, text: w.part2From)
            putTitleForButtons(b: true,bt: mainSecondStack.third2TextField, text: w.part2To)
            activeOrNot(v: monButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [third1TextField,third2TextField])
            
        case 4:
            putTitleForButtons(b: true,bt: forth1TextField, text: w.part1From)
            putTitleForButtons(b: true,bt: forth2TextField, text: w.part1To)
            putTitleForButtons(b: true,bt: mainSecondStack.forth1TextField, text: w.part2From)
            putTitleForButtons(b: true,bt: mainSecondStack.forth2TextField, text: w.part2To)
            activeOrNot(v: tuesButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [forth1TextField,forth2TextField])
            
        case 5:
            putTitleForButtons(b: true,bt: fifth1TextField, text: w.part1From)
            putTitleForButtons(b: true,bt: fifth2TextField, text: w.part1To)
            putTitleForButtons(b: true,bt: mainSecondStack.fifth1TextField, text: w.part2From)
            putTitleForButtons(b: true,bt: mainSecondStack.fifth2TextField, text: w.part2To)
            activeOrNot(v: wedButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [fifth1TextField,fifth2TextField])
            
        case 6:
            putTitleForButtons(b: true,bt: sexth1TextField, text: w.part1From)
            putTitleForButtons(b: true,bt: sexth2TextField, text: w.part1To)
            putTitleForButtons(b: true,bt: mainSecondStack.sexth1TextField, text: w.part2From)
            putTitleForButtons(b: true,bt: mainSecondStack.sexth2TextField, text: w.part2To)
            activeOrNot(v: thuButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [sexth1TextField,sexth2TextField])
            
        default:
            putTitleForButtons(b: true,bt: seventh1TextField, text: w.part1From)
            putTitleForButtons(b: true,bt: seventh2TextField, text: w.part1To)
            putTitleForButtons(b: true,bt: mainSecondStack.seventh1TextField, text: w.part2From)
            putTitleForButtons(b: true,bt: mainSecondStack.seventh2TextField, text: w.part2To)
            activeOrNot(v: friButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [seventh1TextField,seventh2TextField])
            
        }
    }
    
    @objc func handle1Shift(sender:UIButton)  {
        
        changeShiftStates(sender: sender, second: shift2Button, enable1: true, enable2: false, vv: mainSecondStack,mainFirstSecondStack)
        
        if sender.backgroundColor == nil {
            
            return
            //               ClinicDataViewModel.male = false;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: shift2Button)
        shiftTwo = false
        shiftOne = true
        showAndHide(fv: mainSecondStack, sv: mainFirstSecondStack)
        //           doctorRegisterViewModel.male = false
    }
    
    @objc func handle2Shift(sender:UIButton)  {
        if sender.backgroundColor == nil {
            return
            //               doctorRegisterViewModel.male = true;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: shift1Button)
        shiftTwo = true
        shiftOne = false
        showAndHide(fv: mainFirstSecondStack, sv: mainSecondStack)
        
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
