//
//  ClinicWorkingHoursVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

protocol MainClinicWorkingHoursProtocol {
    //    func getHoursChoosed(hours:[String])
    func getHoursChoosed(hours:[Any])
    func getDays(indexs:[Int],days:[String])
    
    
}

class DoctorClinicWorkingHoursVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 900)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customClinicWorkingHoursView:CustomDoctorClinicWorkingHoursView = {
        let v = CustomDoctorClinicWorkingHoursView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        v.shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
        v.shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        [v.sunButton,v.monButton,v.tuesButton,v.wedButton,v.thuButton,v.friButton,v.satButton].forEach({$0
            .addTarget(self, action:#selector(handleOpen), for: .touchUpInside)})
        
        v.handleShowPickers = {[unowned self] sender in
            self.handleShowPicker(sender: sender)
        }
        return v
    }()
    let timeSelector = TimeSelector()
    var delgate:MainClinicWorkingHoursProtocol?
    var choosedHours = [String]()
    var shiftOne = true
    var shiftTwo = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupViewModelObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(9999999)
        //        userDefaults.set(false, forKey: UserDefaultsConstants.isWorkingHoursSaved)
        //        userDefaults.synchronize()
        if userDefaults.bool(forKey: UserDefaultsConstants.isWorkingHoursSaved) {
            //            customClinicWorkingHoursView.getSavedData()
            getSavedData()
            //            DispatchQueue.main.async {
            //                self.view.layoutIfNeeded()
            //            }
            
        }else{
            //        chooseWorkingHoursViewModel.day2 = true
        }
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
            customClinicWorkingHoursView.putDataForVariables(f1,f11,f12,f112,f2,f21,f221,f222,f3,f31,f23,f231,f4,f41,f24,f241,f5,f51,f25,f251,f6,f61,f26,f261,f7,f71,f27,f271)
            
            customClinicWorkingHoursView.first1TextField.setTitle(changeTimeForButtonTitle(values: f1), for: .normal)
            customClinicWorkingHoursView.first2TextField.setTitle(changeTimeForButtonTitle(values: f11) , for: .normal)
            customClinicWorkingHoursView.mainSecondStack.first1TextField.setTitle(changeTimeForButtonTitle(values: f12), for: .normal)
            customClinicWorkingHoursView.mainSecondStack.first1TextField.setTitle(changeTimeForButtonTitle(values: f112), for: .normal)
            
            customClinicWorkingHoursView.second1TextField.setTitle(changeTimeForButtonTitle(values: f2), for: .normal)
            customClinicWorkingHoursView.second2TextField.setTitle(changeTimeForButtonTitle(values: f21), for: .normal)
            customClinicWorkingHoursView.mainSecondStack.second1TextField.setTitle(changeTimeForButtonTitle(values: f221), for: .normal)
            customClinicWorkingHoursView.mainSecondStack.second2TextField.setTitle(changeTimeForButtonTitle(values: f222), for: .normal)
            
            customClinicWorkingHoursView.third1TextField.setTitle(f3, for: .normal)
            customClinicWorkingHoursView.third2TextField.setTitle(f31, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.third1TextField.setTitle(f23, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.third2TextField.setTitle(f231, for: .normal)
            
            customClinicWorkingHoursView.forth1TextField.setTitle(f4, for: .normal)
            customClinicWorkingHoursView.forth2TextField.setTitle(f41, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.forth1TextField.setTitle(f24, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.forth2TextField.setTitle(f241, for: .normal)
            
            customClinicWorkingHoursView.fifth1TextField.setTitle(f5, for: .normal)
            customClinicWorkingHoursView.fifth2TextField.setTitle(f51, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.fifth1TextField.setTitle(f25, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.fifth2TextField.setTitle(f251, for: .normal)
            
            customClinicWorkingHoursView.sexth1TextField.setTitle(f6, for: .normal)
            customClinicWorkingHoursView.sexth2TextField.setTitle(f61, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.sexth1TextField.setTitle(f26, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.sexth2TextField.setTitle(f261, for: .normal)
            
            customClinicWorkingHoursView.seventh1TextField.setTitle(f7, for: .normal)
            customClinicWorkingHoursView.seventh2TextField.setTitle(f71, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.seventh1TextField.setTitle(f27, for: .normal)
            customClinicWorkingHoursView.mainSecondStack.seventh2TextField.setTitle(f271, for: .normal)
                customClinicWorkingHoursView.putOtherData()
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
            }
            //
            //        }
        }
    }
    
//    func putDataForVariables(_ ff:String...)  {
//        d1TXT1 = ff[0];     d12TXT1=ff[2]
//        d1TXT2=ff[1];       d12TXT2=ff[3]
//        d2TXT1=ff[4];       d22TXT1=ff[6]
//        d2TXT2=ff[5];   d22TXT2=ff[7]
//        d3TXT1=ff[8];       d32TXT1=ff[10]
//        d3TXT2=ff[9];       d32TXT2=ff[11]
//        d4TXT1=ff[12];      d42TXT1=ff[14]
//        d4TXT2=ff[13];      d42TXT2=ff[15]
//        d5TXT1=ff[16];      d52TXT1=ff[18]
//        d5TXT2=ff[17];      d52TXT2=ff[19]
//        d6TXT1=ff[20];      d62TXT1=ff[22]
//        d6TXT2=ff[21];      d62TXT2=ff[23]
//        d7TXT1=ff[24];      d72TXT1=ff[26]
//        d7TXT2=ff[25];       d72TXT2=ff[27]
//    }
    
//    func putOtherData()  {
//        let d1 = userDefaults.bool(forKey: UserDefaultsConstants.day1);let d5 = userDefaults.bool(forKey: UserDefaultsConstants.day5)
//        let d2 = userDefaults.bool(forKey: UserDefaultsConstants.day2);let d6 = userDefaults.bool(forKey: UserDefaultsConstants.day6)
//        let d3 = userDefaults.bool(forKey: UserDefaultsConstants.day3);let d7 = userDefaults.bool(forKey: UserDefaultsConstants.day7)
//        let d4 = userDefaults.bool(forKey: UserDefaultsConstants.day4)
//
//        day1 = d1;  day2=d2;    day3=d3;    day4=d4;    day5=d5;    day6=d6;    day7=d7
//        checkIfButtonsEnabled(enable: day1, vv: customClinicWorkingHoursView.satButton)
//        checkIfButtonsEnabled(enable: day2, vv: customClinicWorkingHoursView.sunButton)
//        checkIfButtonsEnabled(enable: day3, vv: customClinicWorkingHoursView.monButton)
//        checkIfButtonsEnabled(enable: day4, vv: customClinicWorkingHoursView.tuesButton)
//        checkIfButtonsEnabled(enable: day5, vv: customClinicWorkingHoursView.wedButton)
//        checkIfButtonsEnabled(enable: day6, vv: customClinicWorkingHoursView.thuButton)
//        checkIfButtonsEnabled(enable: day7, vv: customClinicWorkingHoursView.friButton)
//    }
    
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customClinicWorkingHoursView)
        customClinicWorkingHoursView.fillSuperview()
        
        
        
    }
    
    
    
    
    fileprivate func setupTimeSelector(_ timeSelector: TimeSelector) {
        timeSelector.overlayAlpha = 0.8
        timeSelector.clockTint = timeSelector_rgb(0, 230, 0)
        timeSelector.minutes = 30
        timeSelector.hours = 5
        timeSelector.isAm = false
        timeSelector.presentOnView(view: self.view)
    }
    
    func titleForButton(_ isShift1:Bool,fbt:UIButton,sbt:UIButton,txt:String)  {
        isShift1 ?    fbt.setTitle(txt, for: .normal) :  sbt.setTitle(txt, for: .normal)
    }
    
    
    
//    func updateTextField(isShift1:Bool,tag:Int,texts:String,hours:Int,mintue:Int,ppp:String)  {
//        var hs = 0
//
//        hs  = ppp ==  "pm" ? hours+12 : hours
//
//        let ss = "\(hs):\(mintue)"
//        switch tag{
//        case 1:
//            if isShift1 {
//                d1TXT1 = ss
//                //                chooseWorkingHoursViewModel.d1TXT1 = ss
//            }else {
//                d12TXT1 = ss
//                //                chooseWorkingHoursViewModel.d12TXT1 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.first1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.first1TextField, txt: texts)
//        case 11:
//            if isShift1 {
//                d1TXT2 = ss
//            }else {
//                d12TXT2 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.first2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.first2TextField, txt: texts)
//
//        case 2:
//            if isShift1 {
//                d2TXT1 = ss
//            }else {
//                d22TXT1 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.second1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.second1TextField, txt: texts)
//
//
//        case 22:
//            if isShift1 {
//                d2TXT2 = ss
//            }else {
//                d22TXT2 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.second2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.second2TextField, txt: texts)
//
//
//        case 3:
//            if isShift1 {
//                d3TXT1 = ss
//            }else {
//                d32TXT1 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.third1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.third1TextField, txt: texts)
//
//
//        case 33:
//            if isShift1 {
//                d3TXT2 = ss
//            }else {
//                d32TXT2 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.third2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.third2TextField, txt: texts)
//
//
//        case 4:
//            if isShift1 {
//                d4TXT1 = ss
//            }else {
//                d42TXT1 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.forth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.forth1TextField, txt: texts)
//
//        case 44:
//            if isShift1 {
//                d4TXT2 = ss
//            }else {
//                d42TXT2 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.forth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.forth2TextField, txt: texts)
//
//
//        case 5:
//            if isShift1 {
//                d5TXT1 = ss
//            }else {
//                d52TXT1 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.fifth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.fifth1TextField, txt: texts)
//
//
//        case 55:
//            if isShift1 {
//                d5TXT2 = ss
//            }else {
//                d52TXT2 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.fifth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.fifth2TextField, txt: texts)
//
//        case 6:
//            if isShift1 {
//                d6TXT1 = ss
//            }else {
//                d62TXT1 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.sexth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.sexth2TextField, txt: texts)
//
//
//        case 66:
//            if isShift1 {
//                d6TXT2 = ss
//            }else {
//                d62TXT2 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.sexth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.sexth1TextField, txt: texts)
//
//
//        case 7:
//            if isShift1 {
//                d7TXT1 = ss
//            }else {
//                d72TXT1 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.seventh1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.seventh1TextField, txt: texts)
//        default:
//            if isShift1 {
//                d7TXT2 = ss
//            }else {
//                d72TXT2 = ss
//            }
//            titleForButton(isShift1, fbt: customClinicWorkingHoursView.seventh2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.seventh2TextField, txt: texts)
//        }
//
//        choosedHours.append(texts)
//    }
    
    
    
    func changeTimeForButtonTitle(values:String)->String  {
        var ppp = "am"
        guard let minute = values.strstr(needle: ":", beforeNeedle: false)?.toInt()  else { return "" }
        guard var hours = values.strstr(needle: ":", beforeNeedle: true)?.toInt()  else { return "" }
        ppp = hours > 12 ? "pm" : "am"
        hours =   hours > 12 ? hours - 12 : hours
        return "\(hours):\(minute) \(ppp)"
    }
    
    @objc func handleShowPicker(sender:UIButton) {
        var texts = ""
        let cc = Calendar.current
        var ppp = "am"
        
        setupTimeSelector(timeSelector)
        timeSelector.timeSelected = {[unowned self] (timeSelector) in
            print(timeSelector.date)
            let dd = timeSelector.date
            
            var hour = cc.component(.hour, from: dd)
            ppp = hour > 12 ? "pm" : "am"
            hour =   hour > 12 ? hour - 12 : hour
            
            let minute = cc.component(.minute, from: dd)
            texts = "\(hour):\(minute) \(ppp)"
            DispatchQueue.main.async {
                self.customClinicWorkingHoursView.updateTextField(isShift1: self.shiftOne , tag: sender.tag, texts: texts,hours:hour,mintue:minute,ppp:ppp)
            }
        }
    }
    
    func showAndHide(fv:UIView,sv:UIView)  {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            fv.isHide(true)
            sv.isHide(false)
        })
    }
    
    @objc func handle1Shift(sender:UIButton)  {
        if sender.backgroundColor == nil {
            
            return
            //               ClinicDataViewModel.male = false;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: customClinicWorkingHoursView.shift2Button)
        shiftTwo = false
        shiftOne = true
        showAndHide(fv: customClinicWorkingHoursView.mainSecondStack, sv: customClinicWorkingHoursView.mainFirstSecondStack)
        //           doctorRegisterViewModel.male = false
    }
    
    @objc func handle2Shift(sender:UIButton)  {
        if sender.backgroundColor == nil {
            return
            //               doctorRegisterViewModel.male = true;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: customClinicWorkingHoursView.shift1Button)
        shiftTwo = true
        shiftOne = false
        showAndHide(fv: customClinicWorkingHoursView.mainFirstSecondStack, sv: customClinicWorkingHoursView.mainSecondStack)
        
        //           doctorRegisterViewModel.male = true
    }
    
    func enalbes(t:UIButton...,enable:Bool? = true)   {
        t.forEach({$0.isEnabled = enable ?? true})
    }
    
    @objc  func handleOpen(sender:UIButton)  {
        if sender.backgroundColor == nil {
            //disable button
            removeGradientInSender(sender:sender)
                customClinicWorkingHoursView.enableTextFields(enable: false, tag: sender.tag)
            return
        }
        //enable button
        customClinicWorkingHoursView.enableTextFields(enable: true, tag: sender.tag)
        addGradientInSenderAndRemoveOtherss(sender: sender)
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
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
    
    fileprivate func checkValidateDoneButton() {
           
           
        if checkDayActive( customClinicWorkingHoursView.day1 ){
            if checkValidteShifting(bol: checkDayActive( customClinicWorkingHoursView.day1), ftf: customClinicWorkingHoursView.d1TXT1, stf: customClinicWorkingHoursView.d1TXT2, title: "Saturday ",ftf2: customClinicWorkingHoursView.d12TXT1,stf2: customClinicWorkingHoursView.d12TXT2){}else {return}
           }
        if checkDayActive(customClinicWorkingHoursView.day2) {
            if  checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day2), ftf: customClinicWorkingHoursView.d2TXT1, stf: customClinicWorkingHoursView.d2TXT2, title: "Sunday",ftf2: customClinicWorkingHoursView.d22TXT1,stf2: customClinicWorkingHoursView.d22TXT2) {}else {return}
               
           }
        if checkDayActive(customClinicWorkingHoursView.day3) {
            if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day3), ftf: customClinicWorkingHoursView.d3TXT1, stf: customClinicWorkingHoursView.d3TXT2, title: "Monday",ftf2: customClinicWorkingHoursView.d32TXT1,stf2: customClinicWorkingHoursView.d32TXT2){}else {return}
           }
        if checkDayActive(customClinicWorkingHoursView.day4) {
            if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day4), ftf: customClinicWorkingHoursView.d4TXT1, stf: customClinicWorkingHoursView.d4TXT2, title: "Tuesday",ftf2: customClinicWorkingHoursView.d42TXT1,stf2: customClinicWorkingHoursView.d42TXT2){}else {return}
           }
        if checkDayActive(customClinicWorkingHoursView.day5) {
            if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day5), ftf: customClinicWorkingHoursView.d5TXT1, stf: customClinicWorkingHoursView.d5TXT2, title: "Wednsday",ftf2: customClinicWorkingHoursView.d52TXT1,stf2: customClinicWorkingHoursView.d52TXT2){}else {return}
           }
        if checkDayActive(customClinicWorkingHoursView.day6) {
            if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day6), ftf: customClinicWorkingHoursView.d6TXT1, stf: customClinicWorkingHoursView.d6TXT2, title: "Thrusday ",ftf2: customClinicWorkingHoursView.d62TXT1,stf2: customClinicWorkingHoursView.d62TXT2){}else {return}
           }
        if checkDayActive(customClinicWorkingHoursView.day7) {
               
            if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day7), ftf: customClinicWorkingHoursView.d7TXT1, stf: customClinicWorkingHoursView.d7TXT2, title: "Friday",ftf2: customClinicWorkingHoursView.d72TXT1,stf2: customClinicWorkingHoursView.d72TXT2) {}else {return}
           }
           
           
           
        delgate?.getHoursChoosed(hours: customClinicWorkingHoursView.getChoosenHours())
        delgate?.getDays(indexs: customClinicWorkingHoursView.getDaysIndex(), days: customClinicWorkingHoursView.getDays())
        customClinicWorkingHoursView.savedData()
           navigationController?.popViewController(animated: true)
       }
    
    @objc func handleDone()  {
        checkValidateDoneButton()
        
    }
}
