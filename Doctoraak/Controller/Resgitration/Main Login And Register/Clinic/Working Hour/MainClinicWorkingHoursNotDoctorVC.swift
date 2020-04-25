//
//  MainClinicWorkingHoursNotDoctorVC.swift
//  Doctoraak
//
//  Created by hosam on 4/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MainClinicWorkingHoursNotDoctorVC: CustomBaseViewVC {
    
    
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
       
       var day1:Bool? = false
       var day2:Bool? = true
       var day3:Bool? = false
       var day4:Bool? = false
       var day5:Bool? = false
       var day6:Bool? = false
       var day7:Bool? = false
       
       var d1TXT1:String?
       var d1TXT2:String?
       var d2TXT1:String?
       var d2TXT2:String?
       var d3TXT1:String?
       var d3TXT2:String?
       var d4TXT1:String?
       var d4TXT2:String?
       var d5TXT1:String?
       var d5TXT2:String?
       var d6TXT1:String?
       var d6TXT2:String?
       var d7TXT1:String?
       var d7TXT2:String?
       
       var d12TXT1:String?
       var d12TXT2:String?
       var d22TXT1:String?
       var d22TXT2:String?
       var d32TXT1:String?
       var d32TXT2:String?
       var d42TXT1:String?
       var d42TXT2:String?
       var d52TXT1:String?
       var d52TXT2:String?
       var d62TXT1:String?
       var d62TXT2:String?
       var d72TXT1:String?
       var d72TXT2:String?
    //    let chooseWorkingHoursViewModel = ChooseWorkingHoursViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupViewModelObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.bool(forKey: UserDefaultsConstants.isWorkingHoursSaved) {
            customClinicWorkingHoursView.getSavedData()
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
            }
            
        }else{
            //        chooseWorkingHoursViewModel.day2 = true
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
    
    //    func setupViewModelObserver()  {
    //        chooseWorkingHoursViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
    //            guard let isValid = isValidForm else {return}
    //            self.changeButtonState(enable: isValid, vv: self.customClinicWorkingHoursView.doneButton)
    //        }
    //        chooseWorkingHoursViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
    //            if isReg == true {
    //                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
    //                //                SVProgressHUD.show(withStatus: "Login...".localized)
    //
    //            }else {
    //                //                SVProgressHUD.dismiss()
    //                //                self.activeViewsIfNoData()
    //            }
    //        })
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
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.first1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.first1TextField, txt: texts)
        case 11:
            if isShift1 {
                d1TXT2 = ss
            }else {
            d12TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.first2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.first2TextField, txt: texts)
            
        case 2:
            if isShift1 {
            d2TXT1 = ss
            }else {
          d22TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.second1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.second1TextField, txt: texts)
            
            
        case 22:
            if isShift1 {
             d2TXT2 = ss
            }else {
              d22TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.second2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.second2TextField, txt: texts)
            
            
        case 3:
            if isShift1 {
               d3TXT1 = ss
            }else {
               d32TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.third1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.third1TextField, txt: texts)
            
            
        case 33:
            if isShift1 {
              d3TXT2 = ss
            }else {
              d32TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.third2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.third2TextField, txt: texts)
            
            
        case 4:
            if isShift1 {
         d4TXT1 = ss
            }else {
           d42TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.forth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.forth1TextField, txt: texts)
            
        case 44:
            if isShift1 {
                d4TXT2 = ss
            }else {
                d42TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.forth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.forth2TextField, txt: texts)
            
            
        case 5:
            if isShift1 {
                d5TXT1 = ss
            }else {
                d52TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.fifth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.fifth1TextField, txt: texts)
            
            
        case 55:
            if isShift1 {
                d5TXT2 = ss
            }else {
                d52TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.fifth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.fifth2TextField, txt: texts)
            
        case 6:
            if isShift1 {
                d6TXT1 = ss
            }else {
                d62TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.sexth2TextField, sbt: customClinicWorkingHoursView.mainSecondStack.sexth2TextField, txt: texts)
            
            
        case 66:
            if isShift1 {
                d6TXT2 = ss
            }else {
                d62TXT2 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.sexth1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.sexth1TextField, txt: texts)
            
            
        case 7:
            if isShift1 {
                d7TXT1 = ss
            }else {
                d72TXT1 = ss
            }
            titleForButton(isShift1, fbt: customClinicWorkingHoursView.seventh1TextField, sbt: customClinicWorkingHoursView.mainSecondStack.seventh1TextField, txt: texts)
        default:
            if isShift1 {
                d7TXT2 = ss
            }else {
                d72TXT2 = ss
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
                self.updateTextField(isShift1: self.shiftOne , tag: sender.tag, texts: texts,hours:hour,mintue:minute,ppp:ppp)
            }
        }
    }
    
    func showAndHide(fv:UIView,sv:UIView)  {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            fv.isHide(true)
            sv.isHide(false)
        })
    }
    
   
    
    func enalbes(t:UIButton...,enable:Bool? = true)   {
        t.forEach({$0.isEnabled = enable ?? true})
    }
    
    func enableTextFields(enable:Bool,tag:Int)  {
        switch tag {
        case 1:
            enalbes(t: customClinicWorkingHoursView.first1TextField,customClinicWorkingHoursView.first2TextField,customClinicWorkingHoursView.mainSecondStack.first1TextField,customClinicWorkingHoursView.mainSecondStack.first2TextField,enable:enable)
            day1 =  enable ? true : false
        case 2:
            enalbes(t: customClinicWorkingHoursView.second1TextField,customClinicWorkingHoursView.second2TextField,customClinicWorkingHoursView.mainSecondStack.second1TextField,customClinicWorkingHoursView.mainSecondStack.second2TextField,enable:enable)
            day2 = enable ? true : false
        case 3:
            enalbes(t: customClinicWorkingHoursView.third1TextField,customClinicWorkingHoursView.third2TextField,customClinicWorkingHoursView.mainSecondStack.third1TextField,customClinicWorkingHoursView.mainSecondStack.third2TextField,enable:enable)
            day3 = enable ? true : false
        case 4:
            enalbes(t: customClinicWorkingHoursView.forth1TextField,customClinicWorkingHoursView.forth2TextField,customClinicWorkingHoursView.mainSecondStack.forth1TextField,customClinicWorkingHoursView.mainSecondStack.forth2TextField,enable:enable)
            day4 = enable ? true : false
        case 5:
            enalbes(t: customClinicWorkingHoursView.fifth1TextField,customClinicWorkingHoursView.fifth2TextField,customClinicWorkingHoursView.mainSecondStack.fifth1TextField,customClinicWorkingHoursView.mainSecondStack.fifth2TextField,enable:enable)
            day5 = enable ? true : false
        case 6:
            enalbes(t: customClinicWorkingHoursView.sexth1TextField,customClinicWorkingHoursView.sexth2TextField,customClinicWorkingHoursView.mainSecondStack.sexth1TextField,customClinicWorkingHoursView.mainSecondStack.sexth2TextField,enable:enable)
            day6 = enable ? true : false
        default:
            enalbes(t: customClinicWorkingHoursView.seventh1TextField,customClinicWorkingHoursView.seventh2TextField,customClinicWorkingHoursView.mainSecondStack.seventh1TextField,customClinicWorkingHoursView.mainSecondStack.seventh2TextField,enable:enable)
            day7 = enable ? true : false
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
        if checkValidteShifting(bol: day2, ftf: d1TXT1, stf: d1TXT2, title: "Sunday",ftf2: d12TXT1,stf2: d12TXT2) && checkValidteShifting(bol: day3, ftf: d2TXT1, stf: d2TXT2, title: "Monday",ftf2: d22TXT1,stf2: d22TXT2) &&  checkValidteShifting(bol: day4, ftf: d3TXT1, stf: d3TXT2, title: "Tuesday",ftf2: d32TXT1,stf2: d32TXT2) &&
            checkValidteShifting(bol: day5, ftf: d4TXT1, stf: d4TXT2, title: "Wednsday",ftf2: d42TXT1,stf2: d42TXT2)
            &&  checkValidteShifting(bol: day6, ftf: d5TXT1, stf: d5TXT2, title: "Thrusday",ftf2: d52TXT1,stf2: d52TXT2) &&
            checkValidteShifting(bol: day7, ftf: d6TXT1, stf: d6TXT2, title: "Friday",ftf2: d62TXT1,stf2: d62TXT2) &&
            checkValidteShifting(bol: day1, ftf: d7TXT1, stf: d7TXT2, title: "Saturday",ftf2: d72TXT1,stf2: d72TXT2) {
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
            
            userDefaults.set(day1 ?? false, forKey: UserDefaultsConstants.day1)
            userDefaults.set(day2 ?? false, forKey: UserDefaultsConstants.day2)
            userDefaults.set(day3 ?? false, forKey: UserDefaultsConstants.day3)
            userDefaults.set(day4 ?? false, forKey: UserDefaultsConstants.day4)
            userDefaults.set(day5 ?? false, forKey: UserDefaultsConstants.day5)
            userDefaults.set(day6 ?? false, forKey: UserDefaultsConstants.day6)
            userDefaults.set(day7 ?? false, forKey: UserDefaultsConstants.day7)
            
            userDefaults.set(true, forKey: UserDefaultsConstants.isWorkingHoursSaved)
            userDefaults.synchronize()
        }
    }
    
    fileprivate func checkValidateDoneButton() {
        validateFirstShift()
        
        
    }
    
    func getDays() -> [String] {
        var ss = [String]()
        if day1 ?? true {
            ss.append("Sat")
        }
        if day2 ?? true {
            ss.append("Sun")
        }
        if day3 ?? true {
            ss.append("Mon")
        }
        if day4 ?? true {
            ss.append("Tue")
        }
        if day5 ?? true {
            ss.append("Wed")
        }
        if day6 ?? true {
            ss.append("Thr")
        }
        if day7 ?? true {
            ss.append("Fri")
        }
        return ss
    }
    
    func getDaysIndex() -> [Int] {
        var ss = [Int]()
        if day1 ?? true {
            ss.append(1)
        }
        if day2 ?? true {
            ss.append(2)
        }
        if day3 ?? true {
            ss.append(3)
        }
        if day4 ?? true {
            ss.append(4)
        }
        if day5 ?? true {
            ss.append(5)
        }
        if day6 ?? true {
            ss.append(6)
        }
        if day7 ?? true {
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
            creates(day: 1, v: day1, t1: d1TXT1, t2: d1TXT1,t21: d12TXT1,t22: d12TXT2)
            ,
            creates(day: 2, v: day2, t1: d2TXT1, t2: d2TXT1,t21: d22TXT1,t22: d22TXT2),
            creates(day: 3, v: day3, t1: d3TXT1, t2: d3TXT1,t21: d32TXT1,t22: d32TXT2),
            creates(day: 4, v: day4, t1: d4TXT1, t2: d4TXT1,t21: d42TXT1,t22: d42TXT2),
            creates(day: 5, v: day5, t1: d5TXT1, t2: d5TXT1,t21: d52TXT1,t22: d52TXT2),
            creates(day: 6, v: day6, t1: d6TXT1, t2: d6TXT1,t21: d62TXT1,t22: d62TXT2),
            creates(day: 7, v: day7, t1: d7TXT1, t2: d7TXT1,t21: d72TXT1,t22: d72TXT2)
            
        ]
        return vv
    }
}

