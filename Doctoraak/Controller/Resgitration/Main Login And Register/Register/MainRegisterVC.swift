//
//  PharmacyLoginVC.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD
import MOLH


class MainRegisterVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1300)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customMainRegisterView:CustomMainRegisterView = {
        let v = CustomMainRegisterView()
        v.index = index
        
        v.userEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        v.handleChooseHours = {[unowned self] in
            let working = MainClinicWorkingHoursNotDoctorVC()
            working.delgate = self
            self.navigationController?.pushViewController(working, animated: true)
        }
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC()
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
        }
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleDismiss()
        }
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
    init(indexx:Int) {
        self.index = indexx
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
//        MAKEoPERATION()
    }
    
    //MARK:-User methods
    
        func MAKEoPERATION()  {
    
            let singldata:[SecondWorkModel] = [
    
                .init(partFrom: "00:00", partTo: "00:00", day: 1, active: 0),
                .init(partFrom: "00:00", partTo: "00:00", day: 2, active: 0),
                .init(partFrom: "00:00", partTo: "00:00", day: 3, active: 0),
                .init(partFrom: "00:00", partTo: "00:00", day: 4, active: 0),
                .init(partFrom: "00:00", partTo: "00:00", day: 5, active: 0),
                .init(partFrom: "00:00", partTo: "00:00", day: 6, active: 0),
                .init(partFrom: "12:00", partTo: "15:00", day: 7, active: 1),
    
            ]
    
            RegistrationServices.shared.mainPHARAMACYRegister( photo: #imageLiteral(resourceName: "Group 4143-2"), name: "asd", email: "cx1ss30ff@c.com", phone: "00065365331", password: "00000000", insurance: [1], delivery: 1, working_hours: singldata, latt: 51512.4555454, lang: 5451521.155151454545, city: 1, area: 1) { (base, err) in
                if let err=err{
                    print(err.localizedDescription)
                }
            }
        }
    
    
    override func setupViews() {
        
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customMainRegisterView)
        customMainRegisterView.fillSuperview()
    }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    fileprivate func setupViewModelObserver()  {
        customMainRegisterView.registerViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customMainRegisterView.nextButton)
        }
        
        customMainRegisterView.registerViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
    }
    
    fileprivate func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] (placemarks, error) -> Void in
            
            // Place details
            //            var placeMark: CLPlacemark?
            guard let   placeMark = placemarks?[0] else {return}
            
            self.customMainRegisterView.addressLabel.text =  placeMark.locality ?? ""
            
            // Location name
            guard  let street = placeMark.subLocality, let city = placeMark.administrativeArea, let country = placeMark.country else {return}
            self.customMainRegisterView.addressLabel.text =  " \(street) - \(city) - \(country)"
        })
        
        
    }
    
    fileprivate func saveRadToken(mobile:String,index:Int,user_id:Int)  {
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        userDefaults.set(mobile, forKey: UserDefaultsConstants.radiologyRegisterMobile)
        userDefaults.set(user_id, forKey: UserDefaultsConstants.radiologyRegisterUser_id)
        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        userDefaults.synchronize()
        goToNext(id: user_id)
    }
    
    fileprivate func saveLABToken(mobile:String,index:Int,user_id:Int)  {
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        userDefaults.set(mobile, forKey: UserDefaultsConstants.pharamcyRegisterMobile)
        userDefaults.set(user_id, forKey: UserDefaultsConstants.pharamcyRegisterUser_id)
        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        userDefaults.synchronize()
        goToNext(id: user_id)
    }
    
    fileprivate func savePharmacyToken(mobile:String,index:Int,user_id:Int)  {
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        userDefaults.set(mobile, forKey: UserDefaultsConstants.labRegisterMobile)
        userDefaults.set(user_id, forKey: UserDefaultsConstants.labRegisterUser_id)
        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        userDefaults.synchronize()
        goToNext(id: user_id)
    }
    
    fileprivate func saveDoctorToken(mobile:String,index:Int,user_id:Int)  {
        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
        userDefaults.set(mobile, forKey: UserDefaultsConstants.doctorRegisterMobile)
        userDefaults.set(user_id, forKey: UserDefaultsConstants.doctorSecondRegisterUser_id)
        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
        userDefaults.synchronize()
        goToNext(id: user_id)
    }
    
    
    //        let aa = index == 2 ? UserDefaultsConstants.labRegisterUser_id : index == 3 ? UserDefaultsConstants.radiologyRegisterUser_id : UserDefaultsConstants.pharamcyRegisterUser_id
    //        //        let dd = index == 2 ? UserDefaultsConstants.labRRegisterSMSCode : index == 3 ? UserDefaultsConstants.radiologyRegisterSMSCode : UserDefaultsConstants.pharamcyRegisterSMSCode
    //        let m = index == 2 ? UserDefaultsConstants.labRegisterMobile : index == 3 ? UserDefaultsConstants.radiologyRegisterMobile : UserDefaultsConstants.pharamcyRegisterMobile
    //
    //        userDefaults.set(user_id, forKey: aa)
    //
    //        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
    //        userDefaults.set(mobile, forKey: m)
    //
    //        userDefaults.set(index, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODEIndex)
    //        removeOtherDefaults()
    
    //    }
    
    fileprivate func removeOtherDefaults()  {
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst1)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst11)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst2)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst21)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst3)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst31)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst4)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst41)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst5)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst51)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst6)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst61)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst7)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainfirst71)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainday1)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainday3)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainday2)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainday4)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainday5)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainday6)
        userDefaults.removeObject(forKey: UserDefaultsConstants.mainday7)
    }
    
    fileprivate  func goToNext(id:Int)  {
        let phone = customMainRegisterView.mobileNumberTextField.text ?? ""
        
        let verify = MainVerificationVC(indexx: index,isFromForgetPassw: false, phone: phone, user_id: id)
        navigationController?.pushViewController(verify, animated: true)
    }
    
    //TODO: -handle methods
    
    
    
    fileprivate func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    @objc func createAlertForChoposingImage()  {
        let alert = UIAlertController(title: "Choose Image".localized, message: "Choose image fROM ".localized, preferredStyle: .alert)
        let camera = UIAlertAction(title: "Camera".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .camera)
            
        }
        let gallery = UIAlertAction(title: "Open From Gallery".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) {[unowned self] (_) in
            alert.dismiss(animated: true)
        }
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func checkPharamacyLoginState(_ phone:String)  {
        customMainRegisterView.registerViewModel.performPHARAMACYRegister {[unowned self] (base, err) in
            if let err = err {
                                                           SVProgressHUD.showError(withStatus: err.localizedDescription)
                 self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.savePharmacyToken(mobile: phone, index: self.index, user_id: user.id)
            }
        }
    }
    
    
    func checkRadLoginState(_ phone:String)  {
        customMainRegisterView.registerViewModel.performRADRegister {[unowned self] (base, err) in
            if let err = err {
                                                           SVProgressHUD.showError(withStatus: err.localizedDescription)
                 self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.saveRadToken(mobile: phone, index: self.index, user_id: user.id)
            }
        }
    }
    
    func checkLabLoginState(_ phone:String)  {
        customMainRegisterView.registerViewModel.performLABRegister {[unowned self] (base, err) in
            if let err = err {
                                                           SVProgressHUD.showError(withStatus: err.localizedDescription)
                 self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            //        self.saveToken(token: user.apiToken)
            
            DispatchQueue.main.async {
                self.saveLABToken(mobile: phone, index: self.index, user_id: user.id)
            }
        }
    }
    
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc  func handleNext()  {
        let phone = customMainRegisterView.mobileNumberTextField.text ?? ""
        index == 4 ? checkPharamacyLoginState(phone) : index == 2 ? checkLabLoginState(phone) : checkRadLoginState(phone)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//MARK:-Extension

extension MainRegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customMainRegisterView.registerViewModel.image = img
            customMainRegisterView.userProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customMainRegisterView.registerViewModel.image = img
            customMainRegisterView.userProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customMainRegisterView.registerViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}


extension MainRegisterVC: MainClinicWorkingHoursssProtocol{
    
    func getDays(indexs: [Int], days: [String]) {
        customMainRegisterView.workingHoursLabel.text = days.joined(separator: "-")
    }
    
    func getHoursChoosed(hours: [ SecondWorkModel]) {
        customMainRegisterView.registerViewModel.working_hours = hours
    }
    
    
}

extension MainRegisterVC: ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
        convertLatLongToAddress(latitude: lat, longitude: long)
        customMainRegisterView.registerViewModel.latt = lat
        customMainRegisterView.registerViewModel.lang = long
        
    }
}
