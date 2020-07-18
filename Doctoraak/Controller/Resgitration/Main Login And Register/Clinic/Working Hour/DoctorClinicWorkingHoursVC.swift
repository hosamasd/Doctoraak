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
    func getHoursChoosed(hours:[WorkModel])
    func getDays(indexs:[Int],days:[String])
    
    
}

class DoctorClinicWorkingHoursVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator=false

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
        v.isOnlyShow=isOnlyShow
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        
        v.handleShowPickers = {[unowned self] sender in
            self.handleShowPicker(sender: sender)
        }
        return v
    }()
    let timeSelector = TimeSelector()
    var delgate:MainClinicWorkingHoursProtocol?
    var doctor:ClinicGetDoctorsModel?{
        didSet{
            guard let doc = doctor else { return  }
            
            customClinicWorkingHoursView.workingHours = doc.workingHours
        }
    }
    
     fileprivate let isFromLeftMenu:Bool!
    fileprivate let isOnlyShow:Bool!

    init(isFromLeftMenu:Bool,isOnlyShow:Bool) {
        self.isFromLeftMenu=isFromLeftMenu
        self.isOnlyShow=isOnlyShow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaults.bool(forKey: UserDefaultsConstants.isDoctorWorkingHoursCached){
            customClinicWorkingHoursView.workingHoursCachedDoc = cachdDOCTORWorkingHourObjectCodabe.storedValue
            
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
    
   fileprivate func checkValidateDoneButton() {
        if  customClinicWorkingHoursView.checkButtonDone() {
            delgate?.getHoursChoosed(hours: customClinicWorkingHoursView.getChoosenHours())
            delgate?.getDays(indexs: customClinicWorkingHoursView.getDaysIndex(), days: customClinicWorkingHoursView.getDays())
            saveCached(vv:customClinicWorkingHoursView.getChoosenHours())
            
            navigationController?.popViewController(animated: true)
        }else {}
    }
    
   fileprivate func saveCached(vv:[WorkModel])  {
        cachdDOCTORWorkingHourObjectCodabe.save(vv)
        userDefaults.set(true, forKey: UserDefaultsConstants.isDoctorWorkingHoursCached)
        userDefaults.synchronize()
    }
    
    //TODO:Handle methods
    
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
                self.customClinicWorkingHoursView.updateTextField(isShift1: self.customClinicWorkingHoursView.shiftOne , tag: sender.tag, texts: texts,hours:hour,mintue:minute,ppp:ppp)
            }
        }
    }
    
    @objc func handleBack()  {
        if isFromLeftMenu {
            dismiss(animated: true)
        }else {
        navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func handleDone()  {
        checkValidateDoneButton()
        
    }
}
