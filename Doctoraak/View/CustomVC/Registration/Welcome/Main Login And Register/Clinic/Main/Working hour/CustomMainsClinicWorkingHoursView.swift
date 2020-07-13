//
//  CustomMainsClinicWorkingHoursView.swift
//  Doctoraak
//
//  Created by hosam on 4/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH

class CustomMainClinicWorkingHoursView: CustomBaseView {
    
    var isFromUpdateProfile:Bool!{
        didSet {
            [sunButton,satButton,monButton,tuesButton,thuButton,wedButton,friButton,fifth1TextField,fifth2TextField,second1TextField,second2TextField,third1TextField,third2TextField,forth1TextField,forth2TextField,fifth2TextField,fifth1TextField,sexth1TextField,sexth2TextField,seventh1TextField,seventh2TextField].forEach({$0.isUserInteractionEnabled = isFromUpdateProfile})
            doneButton.isHidden = isFromUpdateProfile ? false : true
        }
    }
    
    var workingHours:[PharamacyWorkingHourModel]?{
        didSet{
            guard let work = workingHours else { return  }
            work.forEach { (w) in
                putDefaultPHY(l:w)
                putTheses(w: w)
                
            }
        }
    }
    
    var workingHoursLAB:[LabWorkingHoursModel]?{
        didSet{
            guard let work = workingHoursLAB else { return  }
            work.forEach { (w) in
                putDefaultLab(l:w)
                putThesesLAB(w: w)
            }
        }
    }
    
    var workingHoursRAD:[RadiologyWorkingHourModel]?{
        didSet{
            guard let work = workingHoursRAD else { return  }
            work.forEach { (w) in
                putDefaultRAD(l:w)
                putThesesRAD(w: w)
            }
        }
    }
    
    var workingHoursCachedLAB:[PharamacyWorkModel]?{
        didSet{
            guard let work = workingHoursCachedLAB else { return  }
            work.forEach { (w) in
                putThesesCached(w: w)
                putDefaultCachedMain(l: w)
            }
        }
    }
    
    var workingHoursCachedRAD:[PharamacyWorkModel]?{
        didSet{
            guard let work = workingHoursCachedRAD else { return  }
            work.forEach { (w) in
                putDefaultCachedMain(l: w)
                putThesesCached(w: w)
            }
        }
    }
    
    var workingHoursCachedPHY:[PharamacyWorkModel]?{
        didSet{
            guard let work = workingHoursCachedPHY else { return  }
            work.forEach { (w) in
                putDefaultCachedMain(l: w)
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
        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
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
    var day2:Int = 0//1
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
        
        //        if sunButton.backgroundColor != nil && userDefaults.bool(forKey: UserDefaultsConstants.isWorkingHoursSaved){
        //            addGradientInSenderAndRemoveOther(sender: sunButton)
        //            sunButton.setTitleColor(.white, for: .normal)
        //        }
        
    }
    
    
    fileprivate func changeTimeForButtonTitle(_ values:String)->String  {
        var ppp = "am"
        guard let minute = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: false)?.toInt()  else { return "" }
        guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        return "\(hours):\(minute) \(ppp)"
    }
    
    fileprivate func checkIfButtonsEnabled(enable:Int,vv:UIButton)  {
        if enable == 1 {
            addGradientInSenderAndRemoveOtherss(sender: vv)
        }else { }
        enableTextFields(enable: true, tag: vv.tag)
        
        
    }
    
    override func setupViews() {
        [titleLabel,soonLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        [first2TextField,first1TextField,second1TextField,second2TextField,third1TextField,third2TextField,forth1TextField,forth2TextField,fifth1TextField,fifth2TextField,sexth1TextField,sexth2TextField,seventh2TextField,seventh1TextField].forEach({$0
            .addTarget(self, action:#selector(handleShowPicker), for: .touchUpInside)})
        [second1TextField,second2TextField].forEach({$0.isEnabled = true})
        
        [satButton,sunButton,monButton,tuesButton,thuButton,wedButton,friButton].forEach({$0.constrainWidth(constant: 60)})
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,totalStack,doneButton)
        
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        totalStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 0, right: 32))
        
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    
    fileprivate func createHoursButtons(tags:Int) -> UIButton {
        let t = UIButton()
        t.layer.borderWidth = 1
        t.layer.backgroundColor = UIColor.gray.cgColor
        t.layer.cornerRadius = 16
        t.clipsToBounds = true
        t.setTitleColor(.black, for: .normal)
        t.backgroundColor = .white
        t.setTitle("00:00", for: .normal)
        //        t.constrainHeight(constant: 50)
        t.tag = tags
        t.isEnabled = false
        
        return t
    }
    
    fileprivate func enalbes(t:UIButton...,enable:Bool )   {
        
        t.forEach({$0.isEnabled = enable })
    }
    
    fileprivate func createButtons(title:String,color:UIColor,tags : Int? = 0) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.constrainHeight(constant: 60)
        button.tag = tags ?? 0
        button.layer.cornerRadius = 30
        button.addTarget(self, action:#selector(handleOpen), for: .touchUpInside)
        //        button.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        return button
    }
    
    
    fileprivate func titleForButton(fbt:UIButton,txt:String)  {
        fbt.setTitle(txt, for: .normal)
    }
    
    
    
    fileprivate func checkIfButtonsEnabled(enable:Bool,vv:UIButton)  {
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
    
    fileprivate func titleForButton(fbt:UIButton,sbt:UIButton,txt:String)  {
        fbt.setTitle(txt, for: .normal)
    }
    
    fileprivate func enableTextFields(enable:Bool,tag:Int)  {
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
    
    
    fileprivate  func checkActiveDay(_ d:Int) -> Bool {
        return d == 1 ? true : false
    }
    
    fileprivate func checkValidteShifting(bol:Bool,ftf:String?,stf:String?,title:String) -> Bool {
        let ss = ftf !=  "00:00" && stf != "00:00"
        
        if ss   {
            return true
        }else {
            creatMainSnackBar(message: "\(title) range should be choosen"); return  false
        }
    }
    
    fileprivate func checkDayActive(_ d:Int) -> Bool {
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
    
    
    
    fileprivate func putTheses(w:PharamacyWorkingHourModel)  {
        switch w.day {
        case 1:
            putTitleForButtons(b: true, bt: first1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: first2TextField, text: w.partTo)
            activeOrNot(v: satButton, d: w.active)
        //            checkButtonsTextx(w.active, vv: [first1TextField,first1TextField])
        case 2:
            putTitleForButtons(b: true,bt: second1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: second2TextField, text: w.partTo)
            activeOrNot(v: sunButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [second1TextField,second2TextField])
            
        case 3:
            putTitleForButtons(b: true,bt: third1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: third2TextField, text: w.partTo)
            activeOrNot(v: monButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [third1TextField,third2TextField])
            
        case 4:
            putTitleForButtons(b: true,bt: forth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: forth2TextField, text: w.partTo)
            activeOrNot(v: tuesButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [forth1TextField,forth2TextField])
            
        case 5:
            putTitleForButtons(b: true,bt: fifth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: fifth2TextField, text: w.partTo)
            activeOrNot(v: wedButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [fifth1TextField,fifth2TextField])
            
        case 6:
            putTitleForButtons(b: true,bt: sexth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: sexth2TextField, text: w.partTo)
            activeOrNot(v: thuButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [sexth1TextField,sexth2TextField])
            
        default:
            putTitleForButtons(b: true,bt: seventh1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: seventh2TextField, text: w.partTo)
            activeOrNot(v: friButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [seventh1TextField,seventh2TextField])
            
        }
    }
    
    fileprivate  func putThesesRAD(w:RadiologyWorkingHourModel)  {
        switch w.day {
        case 1:
            putTitleForButtons(b: true,bt: first1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: first2TextField, text: w.partTo)
            activeOrNot(v: satButton, d: w.active)
        case 2:
            putTitleForButtons(b: true,bt: second1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: second2TextField, text: w.partTo)
            activeOrNot(v: sunButton, d: w.active)
        case 3:
            putTitleForButtons(b: true,bt: third1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: third2TextField, text: w.partTo)
            activeOrNot(v: monButton, d: w.active)
        case 4:
            putTitleForButtons(b: true,bt: forth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: forth2TextField, text: w.partTo)
            activeOrNot(v: tuesButton, d: w.active)
        case 5:
            putTitleForButtons(b: true,bt: fifth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: fifth2TextField, text: w.partTo)
            activeOrNot(v: wedButton, d: w.active)
        case 6:
            putTitleForButtons(b: true,bt: sexth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: sexth2TextField, text: w.partTo)
            activeOrNot(v: thuButton, d: w.active)
        default:
            putTitleForButtons(b: true,bt: seventh1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: seventh2TextField, text: w.partTo)
            activeOrNot(v: friButton, d: w.active)
        }
    }
    
    fileprivate func putThesesLAB(w:LabWorkingHoursModel)  {
        switch w.day {
        case 1:
            putTitleForButtons(b: true,bt: first1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: first2TextField, text: w.partTo)
            activeOrNot(v: satButton, d: w.active)
        case 2:
            putTitleForButtons(b: true,bt: second1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: second2TextField, text: w.partTo)
            activeOrNot(v: sunButton, d: w.active)
        case 3:
            putTitleForButtons(b: true,bt: third1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: third2TextField, text: w.partTo)
            activeOrNot(v: monButton, d: w.active)
        case 4:
            putTitleForButtons(b: true,bt: forth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: forth2TextField, text: w.partTo)
            activeOrNot(v: tuesButton, d: w.active)
        case 5:
            putTitleForButtons(b: true,bt: fifth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: fifth2TextField, text: w.partTo)
            activeOrNot(v: wedButton, d: w.active)
        case 6:
            putTitleForButtons(b: true,bt: sexth1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: sexth2TextField, text: w.partTo)
            activeOrNot(v: thuButton, d: w.active)
        default:
            putTitleForButtons(b: true,bt: seventh1TextField, text: w.partFrom)
            putTitleForButtons(b: true,bt: seventh2TextField, text: w.partTo)
            activeOrNot(v: friButton, d: w.active)
        }
    }
    
    func getDays() -> [String] {
        
        
        
        var ss = [String]()
        if checkActiveDay(day1) {
            ss.append("Sat".localized)
        }
        if checkActiveDay(day2) {
            ss.append("Sun".localized)
        }
        if checkActiveDay(day3) {
            ss.append("Mon".localized)
        }
        if checkActiveDay(day4) {
            ss.append("Tue".localized)
        }
        if checkActiveDay(day5) {
            ss.append("Wed".localized)
        }
        if checkActiveDay(day6) {
            ss.append("Thr".localized)
        }
        if checkActiveDay(day7) {
            ss.append("Fri".localized)
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
    
    fileprivate func  putDefaultCachedMain(l:PharamacyWorkModel)  {
        switch l.day {
        case 1:
            d1TXT1 = l.partFrom ; d1TXT2=l.partTo;day1=l.active
            enableTextFields(enable: checkActiveDay(day1), tag: 1)
        case 2:
            d2TXT1 = l.partFrom ; d2TXT2=l.partTo;day2=l.active
            enableTextFields(enable: checkActiveDay(day2), tag: 2)
            
        case 3:
            d3TXT1 = l.partFrom ; d3TXT2=l.partTo;day3=l.active
            enableTextFields(enable: checkActiveDay(day3), tag: 3)
            
        case 4:
            d4TXT1 = l.partFrom ; d4TXT2=l.partTo;day4=l.active
            enableTextFields(enable: checkActiveDay(day4), tag: 4)
            
        case 5:
            d5TXT1 = l.partFrom ; d5TXT2=l.partTo;day5=l.active
            enableTextFields(enable: checkActiveDay(day5), tag: 5)
            
        case 6:
            d6TXT1 = l.partFrom ; d6TXT2=l.partTo;day6=l.active
            enableTextFields(enable: checkActiveDay(day6), tag: 6)
            
        default:
            d7TXT1 = l.partFrom ; d7TXT2=l.partTo;day7=l.active
            enableTextFields(enable: checkActiveDay(day7), tag: 7)
            
        }
    }
    
    fileprivate func putDefaultLab(l:LabWorkingHoursModel)  {
        switch l.day {
        case 1:
            d1TXT1 = l.partFrom ; d1TXT2=l.partTo;day1=l.active
            enableTextFields(enable: checkActiveDay(day1), tag: 1)
        case 2:
            d2TXT1 = l.partFrom ; d2TXT2=l.partTo;day2=l.active
            enableTextFields(enable: checkActiveDay(day2), tag: 2)
            
        case 3:
            d3TXT1 = l.partFrom ; d3TXT2=l.partTo;day3=l.active
            enableTextFields(enable: checkActiveDay(day3), tag: 3)
            
        case 4:
            d4TXT1 = l.partFrom ; d4TXT2=l.partTo;day4=l.active
            enableTextFields(enable: checkActiveDay(day4), tag: 4)
            
        case 5:
            d5TXT1 = l.partFrom ; d5TXT2=l.partTo;day5=l.active
            enableTextFields(enable: checkActiveDay(day5), tag: 5)
            
        case 6:
            d6TXT1 = l.partFrom ; d6TXT2=l.partTo;day6=l.active
            enableTextFields(enable: checkActiveDay(day6), tag: 6)
            
        default:
            d7TXT1 = l.partFrom ; d7TXT2=l.partTo;day7=l.active
            enableTextFields(enable: checkActiveDay(day7), tag: 7)
            
        }
    }
    
    fileprivate func putDefaultRAD(l:RadiologyWorkingHourModel)  {
        switch l.day {
        case 1:
            d1TXT1 = l.partFrom ; d1TXT2=l.partTo;day1=l.active
            enableTextFields(enable: checkActiveDay(day1), tag: 1)
        case 2:
            d2TXT1 = l.partFrom ; d2TXT2=l.partTo;day2=l.active
            enableTextFields(enable: checkActiveDay(day2), tag: 2)
            
        case 3:
            d3TXT1 = l.partFrom ; d3TXT2=l.partTo;day3=l.active
            enableTextFields(enable: checkActiveDay(day3), tag: 3)
            
        case 4:
            d4TXT1 = l.partFrom ; d4TXT2=l.partTo;day4=l.active
            enableTextFields(enable: checkActiveDay(day4), tag: 4)
            
        case 5:
            d5TXT1 = l.partFrom ; d5TXT2=l.partTo;day5=l.active
            enableTextFields(enable: checkActiveDay(day5), tag: 5)
            
        case 6:
            d6TXT1 = l.partFrom ; d6TXT2=l.partTo;day6=l.active
            enableTextFields(enable: checkActiveDay(day6), tag: 6)
            
        default:
            d7TXT1 = l.partFrom ; d7TXT2=l.partTo;day7=l.active
            enableTextFields(enable: checkActiveDay(day7), tag: 7)
            
        }
    }
    
    fileprivate func putDefaultPHY(l:PharamacyWorkingHourModel)  {
        switch l.day {
        case 1:
            d1TXT1 = l.partFrom ; d1TXT2=l.partTo;day1=l.active
            enableTextFields(enable: checkActiveDay(day1), tag: 1)
        case 2:
            d2TXT1 = l.partFrom ; d2TXT2=l.partTo;day2=l.active
            enableTextFields(enable: checkActiveDay(day2), tag: 2)
            
        case 3:
            d3TXT1 = l.partFrom ; d3TXT2=l.partTo;day3=l.active
            enableTextFields(enable: checkActiveDay(day3), tag: 3)
            
        case 4:
            d4TXT1 = l.partFrom ; d4TXT2=l.partTo;day4=l.active
            enableTextFields(enable: checkActiveDay(day4), tag: 4)
            
        case 5:
            d5TXT1 = l.partFrom ; d5TXT2=l.partTo;day5=l.active
            enableTextFields(enable: checkActiveDay(day5), tag: 5)
            
        case 6:
            d6TXT1 = l.partFrom ; d6TXT2=l.partTo;day6=l.active
            enableTextFields(enable: checkActiveDay(day6), tag: 6)
            
        default:
            d7TXT1 = l.partFrom ; d7TXT2=l.partTo;day7=l.active
            enableTextFields(enable: checkActiveDay(day7), tag: 7)
            
        }
    }
    
    fileprivate func putTitleForButtons(b:Bool,bt:UIButton,text:String)  {
        bt.setTitle(b == true ? changeTimeForButtonTitle(values: text): changeTimeForButtonTitless(values: text), for: .normal)
    }
    
    fileprivate func changeTimeForButtonTitle(values:String)->String  {
        var ppp = "am"
        guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        guard let minutes = values.removeSubstringAfterOrBefore(needle: "\(hours):", beforeNeedle: false)  else { return "" }
        guard let minute = minutes.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        return "\(hours):\(minute) \(ppp)"
        
    }
    
    fileprivate func changeTimeForButtonTitless(values:String)->String  {
        if values == "00:00" {
            return "00:00"
        }
        var ppp = "am"
        guard var hours = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        guard let minutes = values.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: false)  else { return "" }
        guard let minute = minutes.removeSubstringAfterOrBefore(needle: ":", beforeNeedle: false)  else { return getValues(ppp: &ppp, hours: &hours, minute: minutes) }
        
        return getValues(ppp: &ppp, hours: &hours, minute: minute)
        
    }
    
    func getValues(ppp: inout String,hours : inout Int,minute:String) -> String {
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        return "\(hours):\(minute) \(ppp)"
    }
    
    fileprivate func activeOrNot(v:UIButton,d:Int)  {
        if checkActiveDay(d) {
            addGradientInSenderAndRemoveOther(sender: v)
        }else {}
    }
    
    fileprivate func putThesesCached(w:PharamacyWorkModel)  {
        switch w.day {
        case 1:
            putTitleForButtons(b: false,bt: first1TextField, text: w.partFrom)
            putTitleForButtons(b: false,bt: first2TextField, text: w.partTo)
            activeOrNot(v: satButton, d: w.active)
        //            checkButtonsTextx(w.active, vv: [first1TextField,first1TextField])
        case 2:
            putTitleForButtons(b: false,bt: second1TextField, text: w.partFrom)
            putTitleForButtons(b: false,bt: second2TextField, text: w.partTo)
            activeOrNot(v: sunButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [second1TextField,second2TextField])
            
        case 3:
            putTitleForButtons(b: false,bt: third1TextField, text: w.partFrom)
            putTitleForButtons(b: false,bt: third2TextField, text: w.partTo)
            activeOrNot(v: monButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [third1TextField,third2TextField])
            
        case 4:
            putTitleForButtons(b: false,bt: forth1TextField, text: w.partFrom)
            putTitleForButtons(b: false,bt: forth2TextField, text: w.partTo)
            activeOrNot(v: tuesButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [forth1TextField,forth2TextField])
            
        case 5:
            putTitleForButtons(b: false,bt: fifth1TextField, text: w.partFrom)
            putTitleForButtons(b: false,bt: fifth2TextField, text: w.partTo)
            activeOrNot(v: wedButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [fifth1TextField,fifth2TextField])
            
        case 6:
            putTitleForButtons(b: false,bt: sexth1TextField, text: w.partFrom)
            putTitleForButtons(b: false,bt: sexth2TextField, text: w.partTo)
            activeOrNot(v: thuButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [sexth1TextField,sexth2TextField])
            
        default:
            putTitleForButtons(b: false,bt: seventh1TextField, text: w.partFrom)
            putTitleForButtons(b: false,bt: seventh2TextField, text: w.partTo)
            activeOrNot(v: friButton, d: w.active)
            //            checkButtonsTextx(w.active, vv: [seventh1TextField,seventh2TextField])
            
        }
    }
    
    @objc func handleShowPicker(sender:UIButton) {
        handleShowPickers?(sender)
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

