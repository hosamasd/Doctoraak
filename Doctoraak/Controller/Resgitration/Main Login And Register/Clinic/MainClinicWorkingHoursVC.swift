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
        [v.first2TextField,v.first1TextField,v.second1TextField,v.second2TextField,v.third1TextField,v.third2TextField,v.forth1TextField,v.forth2TextField,v.fifth1TextField,v.fifth2TextField,v.sexth1TextField,v.sexth2TextField,v.seventh2TextField,v.seventh1TextField].forEach({$0
            .addTarget(self, action:#selector(handleShowPicker), for: .touchUpInside)})
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        v.shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
        v.shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        [v.sunButton,v.monButton,v.tuesButton,v.wedButton,v.thuButton,v.friButton,v.satButton].forEach({$0
            .addTarget(self, action:#selector(handleOpen), for: .touchUpInside)})
        
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
    
    //    func update(fv:UIButton,sv:String,texts:String)  {
    //        fv.setTitle(texts, for: .normal)
    //        chooseWorkingHoursViewModel.sv = texts
    //    }
    
    func updateTextField(tag:Int,texts:String)  {
        
        switch tag{
        case 1:
            //            update(fv: customClinicWorkingHoursView.first1TextField, sv: chooseWorkingHoursViewModel.d1TXT1, texts: texts)
            customClinicWorkingHoursView.first1TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d1TXT1 = texts
        case 11:
            customClinicWorkingHoursView.first2TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d1TXT2 = texts
            
        case 2:
            customClinicWorkingHoursView.second1TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d2TXT1 = texts
            
        case 22:
            customClinicWorkingHoursView.second2TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d2TXT2 = texts
            
        case 3:
            customClinicWorkingHoursView.third1TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d3TXT1 = texts
            
        case 33:
            customClinicWorkingHoursView.third2TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d3TXT2 = texts
            
        case 4:
            customClinicWorkingHoursView.forth1TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d4TXT1 = texts
            
        case 44:
            customClinicWorkingHoursView.forth2TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d4TXT2 = texts
            
        case 5:
            customClinicWorkingHoursView.fifth1TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d5TXT1 = texts
            
        case 55:
            customClinicWorkingHoursView.fifth2TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d5TXT2 = texts
            
        case 6:
            customClinicWorkingHoursView.sexth2TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d6TXT1 = texts
            
        case 66:
            customClinicWorkingHoursView.sexth1TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d6TXT2 = texts
            
        case 7:
            customClinicWorkingHoursView.seventh1TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d7TXT1 = texts
            
        default:
            customClinicWorkingHoursView.seventh2TextField.setTitle(texts, for: .normal)
            chooseWorkingHoursViewModel.d7TXT2 = texts
        }
        choosedHours.append(texts)
    }
    
    func checkValidation()  {
        //        guard let _ = customClinicWorkingHoursView.first1TextField.titleLabel?.text,let _=customClinicWorkingHoursView.first2TextField.titleLabel?.text else { creatMainSnackBar(message: "From and To required...");return  }
        //                           delgate?.getHoursChoosed(hours: choosedHours)
        //                                  navigationController?.popViewController(animated: true)
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
                self.updateTextField(tag: sender.tag, texts: texts)
            }
        }
    }
    
    
    @objc func handle1Shift(sender:UIButton)  {
        if sender.backgroundColor == nil {
            
            return
            //               ClinicDataViewModel.male = false;return
        }
        addGradientInSenderAndRemoveOther(sender: sender, vv: customClinicWorkingHoursView.shift2Button)
        chooseWorkingHoursViewModel.isShiftTwo = false
        chooseWorkingHoursViewModel.isShiftOne = true
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
        
        //           doctorRegisterViewModel.male = true
    }
    
    func enalbes(t:UIButton...,enable:Bool? = true)   {
        t.forEach({$0.isEnabled = enable ?? true})
    }
    
    func enableTextFields(enable:Bool,tag:Int)  {
        switch tag {
        case 1:
            enalbes(t: customClinicWorkingHoursView.first1TextField,customClinicWorkingHoursView.first2TextField,enable:enable)
            chooseWorkingHoursViewModel.day1 =  enable ? true : false
        case 2:
            enalbes(t: customClinicWorkingHoursView.second1TextField,customClinicWorkingHoursView.second2TextField,enable:enable)
            chooseWorkingHoursViewModel.day2 = enable ? true : false
        case 3:
            enalbes(t: customClinicWorkingHoursView.third1TextField,customClinicWorkingHoursView.third2TextField,enable:enable)
            chooseWorkingHoursViewModel.day3 = enable ? true : false
        case 4:
            enalbes(t: customClinicWorkingHoursView.forth1TextField,customClinicWorkingHoursView.forth2TextField,enable:enable)
            chooseWorkingHoursViewModel.day4 = enable ? true : false
        case 5:
            enalbes(t: customClinicWorkingHoursView.fifth1TextField,customClinicWorkingHoursView.fifth2TextField,enable:enable)
            chooseWorkingHoursViewModel.day5 = enable ? true : false
        case 6:
            enalbes(t: customClinicWorkingHoursView.sexth1TextField,customClinicWorkingHoursView.sexth2TextField,enable:enable)
            chooseWorkingHoursViewModel.day6 = enable ? true : false
        default:
            enalbes(t: customClinicWorkingHoursView.seventh1TextField,customClinicWorkingHoursView.seventh2TextField,enable:enable)
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
    
    fileprivate func checkValidateDoneButton() {
        if chooseWorkingHoursViewModel.day1 ?? true  {
            guard let _ = chooseWorkingHoursViewModel.d1TXT1,let _ = chooseWorkingHoursViewModel.d1TXT2 else {creatMainSnackBar(message: "Sunday range should be choosen"); return  }
        }
        if chooseWorkingHoursViewModel.day2 ?? true  {
            guard let _ = chooseWorkingHoursViewModel.d2TXT1,let _ = chooseWorkingHoursViewModel.d2TXT2 else {creatMainSnackBar(message: "Monday range should be choosen"); return  }
        }
        if chooseWorkingHoursViewModel.day3 ?? true  {
            guard let _ = chooseWorkingHoursViewModel.d3TXT1,let _ = chooseWorkingHoursViewModel.d3TXT2 else {creatMainSnackBar(message: "Tuesday range should be choosen"); return  }
        }
        if chooseWorkingHoursViewModel.day4 ?? true  {
            guard let _ = chooseWorkingHoursViewModel.d4TXT1,let _ = chooseWorkingHoursViewModel.d4TXT2 else {creatMainSnackBar(message: "Wednsday range should be choosen"); return  }
        }
        if chooseWorkingHoursViewModel.day5 ?? true  {
            guard let _ = chooseWorkingHoursViewModel.d5TXT1,let _ = chooseWorkingHoursViewModel.d5TXT2 else {creatMainSnackBar(message: "Thrusday range should be choosen"); return  }
        }
        if chooseWorkingHoursViewModel.day6 ?? true  {
            guard let _ = chooseWorkingHoursViewModel.d6TXT1,let _ = chooseWorkingHoursViewModel.d6TXT2 else {creatMainSnackBar(message: "Friday range should be choosen"); return  }
        }
        if chooseWorkingHoursViewModel.day7 ?? true  {
            guard let _ = chooseWorkingHoursViewModel.d7TXT1,let _ = chooseWorkingHoursViewModel.d7TXT2 else {creatMainSnackBar(message: "Saturday range should be choosen"); return  }
        }
        
        delgate?.getHoursChoosed(hours: getChoosenHours())
        navigationController?.popViewController(animated: true)
        print(99999)
    }
    
    @objc func handleDone()  {
        checkValidateDoneButton()

    }
    
    func creates(day:Int,v:Bool?,t1:String? ,t2:String?) -> [String:Any] {
       
         return [   "part1_from": t1 ?? "00:00",
                       "part1_to":t2 ?? "00:00",
                       "part2_from": t1 ?? "00:00",
                       "part2_to": t2 ?? "00:00",
                       "day":day ,
                       "active":v ?? false
        ]
    }
    
    func getChoosenHours() -> [[String:Any]] {
        let vv:[[String:Any]] = [
              creates(day: 1, v: chooseWorkingHoursViewModel.day1, t1: chooseWorkingHoursViewModel.d1TXT1, t2: chooseWorkingHoursViewModel.d1TXT1)
                ,
            creates(day: 2, v: chooseWorkingHoursViewModel.day2, t1: chooseWorkingHoursViewModel.d2TXT1, t2: chooseWorkingHoursViewModel.d2TXT1),
            creates(day: 3, v: chooseWorkingHoursViewModel.day3, t1: chooseWorkingHoursViewModel.d3TXT1, t2: chooseWorkingHoursViewModel.d3TXT1),
            creates(day: 4, v: chooseWorkingHoursViewModel.day4, t1: chooseWorkingHoursViewModel.d4TXT1, t2: chooseWorkingHoursViewModel.d4TXT1),
            creates(day: 5, v: chooseWorkingHoursViewModel.day5, t1: chooseWorkingHoursViewModel.d5TXT1, t2: chooseWorkingHoursViewModel.d5TXT1),
            creates(day: 6, v: chooseWorkingHoursViewModel.day6, t1: chooseWorkingHoursViewModel.d6TXT1, t2: chooseWorkingHoursViewModel.d6TXT1),
            creates(day: 7, v: chooseWorkingHoursViewModel.day7, t1: chooseWorkingHoursViewModel.d7TXT1, t2: chooseWorkingHoursViewModel.d7TXT1)

        ]
        return vv
    }
}
