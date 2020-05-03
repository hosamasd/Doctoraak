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
                self.customClinicWorkingHoursView.updateTextField(  tag: sender.tag, texts: texts,hours:hour,mintue:minute,ppp:ppp)
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
    
    func checkValidteShifting(bol:Bool?,ftf:String?,stf:String?,title:String,ftf2:String?,stf2:String?) ->Bool {
        if bol ?? true  {
            guard let _ = ftf,let _ = stf else {creatMainSnackBar(message: "\(title) range should be choosen"); return false }
            //            guard let _ = ftf,let _ = stf else {creatMainSnackBar(message: "\(title) range should be choosen"); return  }
            
        }
        return true
    }
    
    func checkValidteShifting(bol:Bool,ftf:String?,stf:String?,title:String) -> Bool {
           let ss = ftf !=  "00:00" && stf != "00:00"
           let dd = stf == "00:00" && ftf == "00:00"
           
           
           if ss   {
               return true
           }else {
               creatMainSnackBar(message: "\(title) range should be choosen"); return  false
               
           }
           
       }
    
    func checkDayActive(_ d:Int) -> Bool {
           return d == 1 ? true : false
       }
    
    fileprivate func validateFirstShift() {
       if checkDayActive( customClinicWorkingHoursView.day1 ){
                   if checkValidteShifting(bol: checkDayActive( customClinicWorkingHoursView.day1), ftf: customClinicWorkingHoursView.d1TXT1, stf: customClinicWorkingHoursView.d1TXT2, title: "Saturday "){}else {return}
                  }
               if checkDayActive(customClinicWorkingHoursView.day2) {
                   if  checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day2), ftf: customClinicWorkingHoursView.d2TXT1, stf: customClinicWorkingHoursView.d2TXT2, title: "Sunday") {}else {return}
                      
                  }
               if checkDayActive(customClinicWorkingHoursView.day3) {
                   if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day3), ftf: customClinicWorkingHoursView.d3TXT1, stf: customClinicWorkingHoursView.d3TXT2, title: "Monday"){}else {return}
                  }
               if checkDayActive(customClinicWorkingHoursView.day4) {
                   if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day4), ftf: customClinicWorkingHoursView.d4TXT1, stf: customClinicWorkingHoursView.d4TXT2, title: "Tuesday"){}else {return}
                  }
               if checkDayActive(customClinicWorkingHoursView.day5) {
                   if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day5), ftf: customClinicWorkingHoursView.d5TXT1, stf: customClinicWorkingHoursView.d5TXT2, title: "Wednsday"){}else {return}
                  }
               if checkDayActive(customClinicWorkingHoursView.day6) {
                   if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day6), ftf: customClinicWorkingHoursView.d6TXT1, stf: customClinicWorkingHoursView.d6TXT2, title: "Thrusday "){}else {return}
                  }
               if checkDayActive(customClinicWorkingHoursView.day7) {
                      
                   if checkValidteShifting(bol: checkDayActive(customClinicWorkingHoursView.day7), ftf: customClinicWorkingHoursView.d7TXT1, stf: customClinicWorkingHoursView.d7TXT2, title: "Friday") {}else {return}
                  }
                  
                  
                  
               delgate?.getHoursChoosed(hours: customClinicWorkingHoursView.getChoosenHours())
               delgate?.getDays(indexs: customClinicWorkingHoursView.getDaysIndex(), days: customClinicWorkingHoursView.getDays())
               customClinicWorkingHoursView.savedData()
                  navigationController?.popViewController(animated: true)
              
    }
    
    
    fileprivate func checkValidateDoneButton() {
        validateFirstShift()
        
        
    }
    
  
    
    @objc func handleDone()  {
        checkValidateDoneButton()
        
    }
    
   
}

