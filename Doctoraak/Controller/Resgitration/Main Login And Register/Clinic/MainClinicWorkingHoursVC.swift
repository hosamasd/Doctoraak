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
    func getHoursChoosed(hours:[[String:Any]])
    func getDays(indexs:[Int],days:[String])
    
    
}

class MainClinicWorkingHoursVC: CustomBaseViewVC {
    
    
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
    lazy var customClinicWorkingHoursView:CustomMainClinicWorkingHoursView = {
        let v = CustomMainClinicWorkingHoursView()
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
    let chooseWorkingHoursViewModel = ChooseWorkingHoursViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                if userDefaults.bool(forKey: UserDefaultsConstants.isWorkingHoursSaved) {
                    customClinicWorkingHoursView.getSavedData()
                    DispatchQueue.main.async {
                        self.view.layoutIfNeeded()
                    }

                }else{
        chooseWorkingHoursViewModel.day2 = true
                }
    }
    
//    func getSavedData()  {
//        if let f1 = userDefaults.string(forKey: UserDefaultsConstants.first1),let f11 = userDefaults.string(forKey: UserDefaultsConstants.first11),let f12 = userDefaults.string(forKey: UserDefaultsConstants.first211),let f112 = userDefaults.string(forKey: UserDefaultsConstants.first2111),
//            let f2 = userDefaults.string(forKey: UserDefaultsConstants.first2),let f21 = userDefaults.string(forKey: UserDefaultsConstants.first21),let f221 = userDefaults.string(forKey: UserDefaultsConstants.first22),let f222 = userDefaults.string(forKey: UserDefaultsConstants.first221),
//            let f3 = userDefaults.string(forKey: UserDefaultsConstants.first3),let f31 = userDefaults.string(forKey: UserDefaultsConstants.first31),let f23 = userDefaults.string(forKey: UserDefaultsConstants.first23),let f231 = userDefaults.string(forKey: UserDefaultsConstants.first231),
//            let f4 = userDefaults.string(forKey: UserDefaultsConstants.first4),let f41 = userDefaults.string(forKey: UserDefaultsConstants.first41),let f24 = userDefaults.string(forKey: UserDefaultsConstants.first24),let f241 = userDefaults.string(forKey: UserDefaultsConstants.first241),
//            let f5 = userDefaults.string(forKey: UserDefaultsConstants.first5),let f51 = userDefaults.string(forKey: UserDefaultsConstants.first51),let f25 = userDefaults.string(forKey: UserDefaultsConstants.first25),let f251 = userDefaults.string(forKey: UserDefaultsConstants.first251),
//            let f6 = userDefaults.string(forKey: UserDefaultsConstants.first6),let f61 = userDefaults.string(forKey: UserDefaultsConstants.first61),let f26 = userDefaults.string(forKey: UserDefaultsConstants.first26),let f261 = userDefaults.string(forKey: UserDefaultsConstants.first261),
//
//            let f7 = userDefaults.string(forKey: UserDefaultsConstants.first7),let f71 = userDefaults.string(forKey: UserDefaultsConstants.first71),let f27 = userDefaults.string(forKey: UserDefaultsConstants.first27),let f271 = userDefaults.string(forKey: UserDefaultsConstants.first271)
//
//
//
//        {
//            customClinicWorkingHoursView.first1TextField.setTitle(f1, for: .normal)
//            customClinicWorkingHoursView.first2TextField.setTitle(f11, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.first1TextField.setTitle(f12, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.first1TextField.setTitle(f112, for: .normal)
//
//            customClinicWorkingHoursView.second1TextField.setTitle(f2, for: .normal)
//            customClinicWorkingHoursView.second2TextField.setTitle(f21, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.second1TextField.setTitle(f221, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.second2TextField.setTitle(f222, for: .normal)
//
//            customClinicWorkingHoursView.third1TextField.setTitle(f3, for: .normal)
//            customClinicWorkingHoursView.third2TextField.setTitle(f31, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.third1TextField.setTitle(f23, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.third2TextField.setTitle(f231, for: .normal)
//
//            customClinicWorkingHoursView.forth1TextField.setTitle(f4, for: .normal)
//            customClinicWorkingHoursView.forth2TextField.setTitle(f41, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.forth1TextField.setTitle(f24, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.forth2TextField.setTitle(f241, for: .normal)
//
//            customClinicWorkingHoursView.fifth1TextField.setTitle(f5, for: .normal)
//            customClinicWorkingHoursView.fifth2TextField.setTitle(f51, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.fifth1TextField.setTitle(f25, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.fifth2TextField.setTitle(f251, for: .normal)
//
//            customClinicWorkingHoursView.sexth1TextField.setTitle(f6, for: .normal)
//            customClinicWorkingHoursView.sexth2TextField.setTitle(f61, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.sexth1TextField.setTitle(f26, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.sexth2TextField.setTitle(f261, for: .normal)
//
//            customClinicWorkingHoursView.seventh1TextField.setTitle(f7, for: .normal)
//            customClinicWorkingHoursView.seventh2TextField.setTitle(f71, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.seventh1TextField.setTitle(f27, for: .normal)
//            customClinicWorkingHoursView.mainSecondStack.seventh2TextField.setTitle(f271, for: .normal)
//
//            DispatchQueue.main.async {
//                self.view.layoutIfNeeded()
//            }
//
//        }
//    }
    
    func setupViewModelObserver()  {
        chooseWorkingHoursViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            self.changeButtonState(enable: isValid, vv: self.customClinicWorkingHoursView.doneButton)
        }
        chooseWorkingHoursViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
            }
        })
    }
    
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
    
    
    
    func updateTextField(isShift1:Bool,tag:Int,texts:String,hours:Int,mintue:Int,ppp:String)  {
        var hs = 0
        
        hs  = ppp ==  "pm" ? hours+12 : hours
        
        let ss = "\(hs):\(mintue)"
        switch tag{
        case 1:
            if isShift1 {
                chooseWorkingHoursViewModel.d1TXT1 = ss
            }else {
                chooseWorkingHoursViewModel.d12TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.first1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.first1TextField, txt: texts)
        case 11:
            if isShift1 {
                chooseWorkingHoursViewModel.d1TXT2 = ss
            }else {
                chooseWorkingHoursViewModel.d12TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.first2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.first2TextField, txt: texts)
            
        case 2:
            if isShift1 {
                chooseWorkingHoursViewModel.d2TXT1 = ss
            }else {
                chooseWorkingHoursViewModel.d22TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.second1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.second1TextField, txt: texts)
            
            
        case 22:
            if isShift1 {
                chooseWorkingHoursViewModel.d2TXT2 = ss
            }else {
                chooseWorkingHoursViewModel.d22TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.second2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.second2TextField, txt: texts)
            
            
        case 3:
            if isShift1 {
                chooseWorkingHoursViewModel.d3TXT1 = ss
            }else {
                chooseWorkingHoursViewModel.d32TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.third1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.third1TextField, txt: texts)
            
            
        case 33:
            if isShift1 {
                chooseWorkingHoursViewModel.d3TXT2 = ss
            }else {
                chooseWorkingHoursViewModel.d32TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.third2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.third2TextField, txt: texts)
            
            
        case 4:
            if isShift1 {
                chooseWorkingHoursViewModel.d4TXT1 = ss
            }else {
                chooseWorkingHoursViewModel.d42TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.forth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.forth1TextField, txt: texts)
            
        case 44:
            if isShift1 {
                chooseWorkingHoursViewModel.d4TXT2 = ss
            }else {
                chooseWorkingHoursViewModel.d42TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.forth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.forth2TextField, txt: texts)
            
            
        case 5:
            if isShift1 {
                chooseWorkingHoursViewModel.d5TXT1 = ss
            }else {
                chooseWorkingHoursViewModel.d52TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.fifth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.fifth1TextField, txt: texts)
            
            
        case 55:
            if isShift1 {
                chooseWorkingHoursViewModel.d5TXT2 = ss
            }else {
                chooseWorkingHoursViewModel.d52TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.fifth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.fifth2TextField, txt: texts)
            
        case 6:
            if isShift1 {
                chooseWorkingHoursViewModel.d6TXT1 = ss
            }else {
                chooseWorkingHoursViewModel.d62TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.sexth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.sexth2TextField, txt: texts)
            
            
        case 66:
            if isShift1 {
                chooseWorkingHoursViewModel.d6TXT2 = ss
            }else {
                chooseWorkingHoursViewModel.d62TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.sexth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.sexth1TextField, txt: texts)
            
            
        case 7:
            if isShift1 {
                chooseWorkingHoursViewModel.d7TXT1 = ss
            }else {
                chooseWorkingHoursViewModel.d72TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.seventh1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.seventh1TextField, txt: texts)
        default:
            if isShift1 {
                chooseWorkingHoursViewModel.d7TXT2 = ss
            }else {
                chooseWorkingHoursViewModel.d72TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.seventh2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.seventh2TextField, txt: texts)
        }
        
        choosedHours.append(texts)
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
                self.updateTextField(isShift1: self.chooseWorkingHoursViewModel.isShiftOne ?? true, tag: sender.tag, texts: texts,hours:hour,mintue:minute,ppp:ppp)
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
        chooseWorkingHoursViewModel.isShiftTwo = false
        chooseWorkingHoursViewModel.isShiftOne = true
        showAndHide(fv: customClinicWorkingHoursView.mainSecondStack, sv: customClinicWorkingHoursView.mainFirstSecondStack)
        //           doctorRegisterViewModel.male = false
    }
    
    @objc func handle2Shift(sender:UIButton)  {
        if sender.backgroundColor == nil {
            return
            //               doctorRegisterViewModel.male = true;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: customClinicWorkingHoursView.shift1Button)
        chooseWorkingHoursViewModel.isShiftTwo = true
        chooseWorkingHoursViewModel.isShiftOne = false
        showAndHide(fv: customClinicWorkingHoursView.mainFirstSecondStack, sv: customClinicWorkingHoursView.mainSecondStack)
        
        //           doctorRegisterViewModel.male = true
    }
    
    func enalbes(t:UIButton...,enable:Bool? = true)   {
        t.forEach({$0.isEnabled = enable ?? true})
    }
    
    func enableTextFields(enable:Bool,tag:Int)  {
        switch tag {
        case 1:
            enalbes(t: customClinicWorkingHoursView.first1TextField,customClinicWorkingHoursView.first2TextField,customClinicWorkingHoursView.mainSecondStack.first1TextField,customClinicWorkingHoursView.mainSecondStack.first2TextField,enable:enable)
            chooseWorkingHoursViewModel.day1 =  enable ? true : false
        case 2:
            enalbes(t: customClinicWorkingHoursView.second1TextField,customClinicWorkingHoursView.second2TextField,customClinicWorkingHoursView.mainSecondStack.second1TextField,customClinicWorkingHoursView.mainSecondStack.second2TextField,enable:enable)
            chooseWorkingHoursViewModel.day2 = enable ? true : false
        case 3:
            enalbes(t: customClinicWorkingHoursView.third1TextField,customClinicWorkingHoursView.third2TextField,customClinicWorkingHoursView.mainSecondStack.third1TextField,customClinicWorkingHoursView.mainSecondStack.third2TextField,enable:enable)
            chooseWorkingHoursViewModel.day3 = enable ? true : false
        case 4:
            enalbes(t: customClinicWorkingHoursView.forth1TextField,customClinicWorkingHoursView.forth2TextField,customClinicWorkingHoursView.mainSecondStack.forth1TextField,customClinicWorkingHoursView.mainSecondStack.forth2TextField,enable:enable)
            chooseWorkingHoursViewModel.day4 = enable ? true : false
        case 5:
            enalbes(t: customClinicWorkingHoursView.fifth1TextField,customClinicWorkingHoursView.fifth2TextField,customClinicWorkingHoursView.mainSecondStack.fifth1TextField,customClinicWorkingHoursView.mainSecondStack.fifth2TextField,enable:enable)
            chooseWorkingHoursViewModel.day5 = enable ? true : false
        case 6:
            enalbes(t: customClinicWorkingHoursView.sexth1TextField,customClinicWorkingHoursView.sexth2TextField,customClinicWorkingHoursView.mainSecondStack.sexth1TextField,customClinicWorkingHoursView.mainSecondStack.sexth2TextField,enable:enable)
            chooseWorkingHoursViewModel.day6 = enable ? true : false
        default:
            enalbes(t: customClinicWorkingHoursView.seventh1TextField,customClinicWorkingHoursView.seventh2TextField,customClinicWorkingHoursView.mainSecondStack.seventh1TextField,customClinicWorkingHoursView.mainSecondStack.seventh2TextField,enable:enable)
            chooseWorkingHoursViewModel.day7 = enable ? true : false
        }
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
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    func checkValidteShifting(bol:Bool?,ftf:String?,stf:String?,title:String,ftf2:String?,stf2:String?) ->Bool {
        if bol ?? true  {
            guard let _ = ftf,let _ = stf else {creatMainSnackBar(message: "\(title) range should be choosen"); return false }
            //            guard let _ = ftf,let _ = stf else {creatMainSnackBar(message: "\(title) range should be choosen"); return  }
            
        }
        return true
    }
    
    fileprivate func validateFirstShift() {
        if checkValidteShifting(bol: chooseWorkingHoursViewModel.day2, ftf: chooseWorkingHoursViewModel.d1TXT1, stf: chooseWorkingHoursViewModel.d1TXT2, title: "Sunday",ftf2: chooseWorkingHoursViewModel.d12TXT1,stf2: chooseWorkingHoursViewModel.d12TXT2) && checkValidteShifting(bol: chooseWorkingHoursViewModel.day3, ftf: chooseWorkingHoursViewModel.d2TXT1, stf: chooseWorkingHoursViewModel.d2TXT2, title: "Monday",ftf2: chooseWorkingHoursViewModel.d22TXT1,stf2: chooseWorkingHoursViewModel.d22TXT2) &&  checkValidteShifting(bol: chooseWorkingHoursViewModel.day4, ftf: chooseWorkingHoursViewModel.d3TXT1, stf: chooseWorkingHoursViewModel.d3TXT2, title: "Tuesday",ftf2: chooseWorkingHoursViewModel.d32TXT1,stf2: chooseWorkingHoursViewModel.d32TXT2) &&
            checkValidteShifting(bol: chooseWorkingHoursViewModel.day5, ftf: chooseWorkingHoursViewModel.d4TXT1, stf: chooseWorkingHoursViewModel.d4TXT2, title: "Wednsday",ftf2: chooseWorkingHoursViewModel.d42TXT1,stf2: chooseWorkingHoursViewModel.d42TXT2)
            &&  checkValidteShifting(bol: chooseWorkingHoursViewModel.day6, ftf: chooseWorkingHoursViewModel.d5TXT1, stf: chooseWorkingHoursViewModel.d5TXT2, title: "Thrusday",ftf2: chooseWorkingHoursViewModel.d52TXT1,stf2: chooseWorkingHoursViewModel.d52TXT2) &&
            checkValidteShifting(bol: chooseWorkingHoursViewModel.day7, ftf: chooseWorkingHoursViewModel.d6TXT1, stf: chooseWorkingHoursViewModel.d6TXT2, title: "Friday",ftf2: chooseWorkingHoursViewModel.d62TXT1,stf2: chooseWorkingHoursViewModel.d62TXT2) &&
            checkValidteShifting(bol: chooseWorkingHoursViewModel.day1, ftf: chooseWorkingHoursViewModel.d7TXT1, stf: chooseWorkingHoursViewModel.d7TXT2, title: "Saturday",ftf2: chooseWorkingHoursViewModel.d72TXT1,stf2: chooseWorkingHoursViewModel.d72TXT2) {
            delgate?.getHoursChoosed(hours: getChoosenHours())
            delgate?.getDays(indexs: getDaysIndex(), days: getDays())
            savedData()
            navigationController?.popViewController(animated: true)
            return
        }else {
            print(99999)
            
            return
        }
    }
    
    func savedData()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.isWorkingHoursSaved) {
            return
        }else{
            userDefaults.set(chooseWorkingHoursViewModel.d1TXT1 ?? "00:00", forKey: UserDefaultsConstants.first1)
            userDefaults.set(chooseWorkingHoursViewModel.d1TXT2 ?? "00:00", forKey: UserDefaultsConstants.first11)
            userDefaults.set(chooseWorkingHoursViewModel.d12TXT1 ?? "00:00", forKey: UserDefaultsConstants.first211)
            userDefaults.set(chooseWorkingHoursViewModel.d12TXT2 ?? "00:00", forKey: UserDefaultsConstants.first2111)
            
            userDefaults.set(chooseWorkingHoursViewModel.d2TXT1 ?? "00:00", forKey: UserDefaultsConstants.first2)
            userDefaults.set(chooseWorkingHoursViewModel.d2TXT2 ?? "00:00", forKey: UserDefaultsConstants.first21)
            userDefaults.set(chooseWorkingHoursViewModel.d22TXT1 ?? "00:00", forKey: UserDefaultsConstants.first22)
            userDefaults.set(chooseWorkingHoursViewModel.d22TXT2 ?? "00:00", forKey: UserDefaultsConstants.first221)
            
            userDefaults.set(chooseWorkingHoursViewModel.d3TXT1 ?? "00:00", forKey: UserDefaultsConstants.first3)
            userDefaults.set(chooseWorkingHoursViewModel.d3TXT2 ?? "00:00", forKey: UserDefaultsConstants.first31)
            userDefaults.set(chooseWorkingHoursViewModel.d32TXT1 ?? "00:00", forKey: UserDefaultsConstants.first23)
            userDefaults.set(chooseWorkingHoursViewModel.d32TXT2 ?? "00:00", forKey: UserDefaultsConstants.first231)
            
            userDefaults.set(chooseWorkingHoursViewModel.d4TXT1 ?? "00:00", forKey: UserDefaultsConstants.first4)
            userDefaults.set(chooseWorkingHoursViewModel.d4TXT2 ?? "00:00", forKey: UserDefaultsConstants.first41)
            userDefaults.set(chooseWorkingHoursViewModel.d42TXT1 ?? "00:00", forKey: UserDefaultsConstants.first24)
            userDefaults.set(chooseWorkingHoursViewModel.d42TXT2 ?? "00:00", forKey: UserDefaultsConstants.first241)
            
            userDefaults.set(chooseWorkingHoursViewModel.d5TXT1 ?? "00:00", forKey: UserDefaultsConstants.first5)
            userDefaults.set(chooseWorkingHoursViewModel.d5TXT2 ?? "00:00", forKey: UserDefaultsConstants.first51)
            userDefaults.set(chooseWorkingHoursViewModel.d52TXT1 ?? "00:00", forKey: UserDefaultsConstants.first25)
            userDefaults.set(chooseWorkingHoursViewModel.d52TXT2 ?? "00:00", forKey: UserDefaultsConstants.first251)
            
            userDefaults.set(chooseWorkingHoursViewModel.d6TXT1 ?? "00:00", forKey: UserDefaultsConstants.first6)
            userDefaults.set(chooseWorkingHoursViewModel.d6TXT2 ?? "00:00", forKey: UserDefaultsConstants.first61)
            userDefaults.set(chooseWorkingHoursViewModel.d62TXT1 ?? "00:00", forKey: UserDefaultsConstants.first26)
            userDefaults.set(chooseWorkingHoursViewModel.d62TXT2 ?? "00:00", forKey: UserDefaultsConstants.first261)
            
            userDefaults.set(chooseWorkingHoursViewModel.d7TXT1 ?? "00:00", forKey: UserDefaultsConstants.first7)
            userDefaults.set(chooseWorkingHoursViewModel.d7TXT2 ?? "00:00", forKey: UserDefaultsConstants.first71)
            userDefaults.set(chooseWorkingHoursViewModel.d72TXT1 ?? "00:00", forKey: UserDefaultsConstants.first27)
            userDefaults.set(chooseWorkingHoursViewModel.d72TXT2 ?? "00:00", forKey: UserDefaultsConstants.first271)
            
            userDefaults.set(chooseWorkingHoursViewModel.day1 ?? false, forKey: UserDefaultsConstants.day1)
            userDefaults.set(chooseWorkingHoursViewModel.day2 ?? false, forKey: UserDefaultsConstants.day2)
            userDefaults.set(chooseWorkingHoursViewModel.day3 ?? false, forKey: UserDefaultsConstants.day3)
            userDefaults.set(chooseWorkingHoursViewModel.day4 ?? false, forKey: UserDefaultsConstants.day4)
            userDefaults.set(chooseWorkingHoursViewModel.day5 ?? false, forKey: UserDefaultsConstants.day5)
            userDefaults.set(chooseWorkingHoursViewModel.day6 ?? false, forKey: UserDefaultsConstants.day6)
            userDefaults.set(chooseWorkingHoursViewModel.day7 ?? false, forKey: UserDefaultsConstants.day7)
            
            userDefaults.set(true, forKey: UserDefaultsConstants.isWorkingHoursSaved)
            userDefaults.synchronize()
        }
    }
    
    fileprivate func checkValidateDoneButton() {
        validateFirstShift()
        
        
    }
    
    func getDays() -> [String] {
        var ss = [String]()
        if chooseWorkingHoursViewModel.day1 ?? true {
            ss.append("Sat")
        }
        if chooseWorkingHoursViewModel.day2 ?? true {
            ss.append("Sun")
        }
        if chooseWorkingHoursViewModel.day3 ?? true {
            ss.append("Mon")
        }
        if chooseWorkingHoursViewModel.day4 ?? true {
            ss.append("Tue")
        }
        if chooseWorkingHoursViewModel.day5 ?? true {
            ss.append("Wed")
        }
        if chooseWorkingHoursViewModel.day6 ?? true {
            ss.append("Thr")
        }
        if chooseWorkingHoursViewModel.day7 ?? true {
            ss.append("Fri")
        }
        return ss
    }
    
    func getDaysIndex() -> [Int] {
        var ss = [Int]()
        if chooseWorkingHoursViewModel.day1 ?? true {
            ss.append(1)
        }
        if chooseWorkingHoursViewModel.day2 ?? true {
            ss.append(2)
        }
        if chooseWorkingHoursViewModel.day3 ?? true {
            ss.append(3)
        }
        if chooseWorkingHoursViewModel.day4 ?? true {
            ss.append(4)
        }
        if chooseWorkingHoursViewModel.day5 ?? true {
            ss.append(5)
        }
        if chooseWorkingHoursViewModel.day6 ?? true {
            ss.append(6)
        }
        if chooseWorkingHoursViewModel.day7 ?? true {
            ss.append(7)
        }
        return ss
    }
    
    @objc func handleDone()  {
        checkValidateDoneButton()
        
    }
    
    func creates(day:Int,v:Bool?,t1:String? ,t2:String?,t21:String?,t22:String?) -> [String:Any] {
        
        return [   "part1_from": t1 ?? "00:00",
                   "part1_to":t2 ?? "00:00",
                   "part2_from": t21 ?? "00:00",
                   "part2_to": t22 ?? "00:00",
                   "day":day ,
                   "active":v ?? false
        ]
    }
    
    func getChoosenHours() -> [[String:Any]] {
        let vv:[[String:Any]] = [
            creates(day: 1, v: chooseWorkingHoursViewModel.day1, t1: chooseWorkingHoursViewModel.d1TXT1, t2: chooseWorkingHoursViewModel.d1TXT1,t21: chooseWorkingHoursViewModel.d12TXT1,t22: chooseWorkingHoursViewModel.d12TXT2)
            ,
            creates(day: 2, v: chooseWorkingHoursViewModel.day2, t1: chooseWorkingHoursViewModel.d2TXT1, t2: chooseWorkingHoursViewModel.d2TXT1,t21: chooseWorkingHoursViewModel.d22TXT1,t22: chooseWorkingHoursViewModel.d22TXT2),
            creates(day: 3, v: chooseWorkingHoursViewModel.day3, t1: chooseWorkingHoursViewModel.d3TXT1, t2: chooseWorkingHoursViewModel.d3TXT1,t21: chooseWorkingHoursViewModel.d32TXT1,t22: chooseWorkingHoursViewModel.d32TXT2),
            creates(day: 4, v: chooseWorkingHoursViewModel.day4, t1: chooseWorkingHoursViewModel.d4TXT1, t2: chooseWorkingHoursViewModel.d4TXT1,t21: chooseWorkingHoursViewModel.d42TXT1,t22: chooseWorkingHoursViewModel.d42TXT2),
            creates(day: 5, v: chooseWorkingHoursViewModel.day5, t1: chooseWorkingHoursViewModel.d5TXT1, t2: chooseWorkingHoursViewModel.d5TXT1,t21: chooseWorkingHoursViewModel.d52TXT1,t22: chooseWorkingHoursViewModel.d52TXT2),
            creates(day: 6, v: chooseWorkingHoursViewModel.day6, t1: chooseWorkingHoursViewModel.d6TXT1, t2: chooseWorkingHoursViewModel.d6TXT1,t21: chooseWorkingHoursViewModel.d62TXT1,t22: chooseWorkingHoursViewModel.d62TXT2),
            creates(day: 7, v: chooseWorkingHoursViewModel.day7, t1: chooseWorkingHoursViewModel.d7TXT1, t2: chooseWorkingHoursViewModel.d7TXT1,t21: chooseWorkingHoursViewModel.d72TXT1,t22: chooseWorkingHoursViewModel.d72TXT2)
            
        ]
        return vv
    }
}
