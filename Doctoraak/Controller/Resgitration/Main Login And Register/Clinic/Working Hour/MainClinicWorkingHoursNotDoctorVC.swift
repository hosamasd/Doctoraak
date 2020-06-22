//
//  MainClinicWorkingHoursNotDoctorVC.swift
//  Doctoraak
//
//  Created by hosam on 4/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

protocol MainClinicWorkingHoursssProtocol {
    func getHoursChoosed(hours:[PharamacyWorkModel])
    func getDays(indexs:[Int],days:[String])
    
    
}

let cacheLABObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "lbw.json")
let cachdRADObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "rdw.json")
let cachdPHARMACYObjectWorkingHours: LocalJSONStore<[PharamacyWorkModel]> = LocalJSONStore(storageType: .cache, filename: "phw.json")

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
        
        v.handleShowPickers = {[unowned self] sender in
            self.handleShowPicker(sender: sender)
        }
        return v
    }()
    let timeSelector = TimeSelector()
    var delgate:MainClinicWorkingHoursssProtocol?
    var choosedHours = [String]()
    
    fileprivate let index:Int!
    
    init(index:Int) {
        self.index=index
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
        
        if userDefaults.bool(forKey: UserDefaultsConstants.isLabWorkingHoursCached) {
            customClinicWorkingHoursView.workingHoursCachedLAB = cacheLABObjectWorkingHours.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.isRADWorkingHoursCached) {
            customClinicWorkingHoursView.workingHoursCachedRAD = cachdRADObjectWorkingHours.storedValue

        }else if userDefaults.bool(forKey: UserDefaultsConstants.isPHYWorkingHoursCached){
            customClinicWorkingHoursView.workingHoursCachedPHY = cachdPHARMACYObjectWorkingHours.storedValue

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
    
    fileprivate func validateFirstShift() {
        if customClinicWorkingHoursView.checkDoneEnabled() {
            
            
            delgate?.getHoursChoosed(hours: customClinicWorkingHoursView.getChoosenHours())
            delgate?.getDays(indexs: customClinicWorkingHoursView.getDaysIndex(), days: customClinicWorkingHoursView.getDays())
//            customClinicWorkingHoursView.savedData()
            saveCached(vv:customClinicWorkingHoursView.getChoosenHours())
            navigationController?.popViewController(animated: true)
        }else{}
        
    }
    
    func saveCached(vv:[PharamacyWorkModel])  {
        if index == 2 {
           
            cacheLABObjectWorkingHours.save(vv)
            userDefaults.set(true, forKey: UserDefaultsConstants.isLabWorkingHoursCached)
                       userDefaults.synchronize()
        }else if index == 3 {
            cachdRADObjectWorkingHours.save(vv)
            userDefaults.set(true, forKey: UserDefaultsConstants.isRADWorkingHoursCached)
                       userDefaults.synchronize()
        }else {
            cachdPHARMACYObjectWorkingHours.save(vv)
            userDefaults.set(true, forKey: UserDefaultsConstants.isPHYWorkingHoursCached)
                       userDefaults.synchronize()
        }
    }
    
    fileprivate func checkValidateDoneButton() {
        validateFirstShift()
    }
    
    //TODO:- Handle methods
    
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
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDone()  {
        checkValidateDoneButton()
    }
    
    
}

