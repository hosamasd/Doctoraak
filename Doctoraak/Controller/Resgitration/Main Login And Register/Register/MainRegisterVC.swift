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
            let working = MainClinicWorkingHoursNotDoctorVC(index: self.index, isFromUpdateProfile: true,isFromRegister: true)
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
        customMainRegisterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customMainRegisterView.fullNameTextField.becomeFirstResponder()
    }
    
    //MARK:-User methods
    
    
    
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
    
    fileprivate func saveAllToken(mobile:String,index:Int,user_id:Int)  {
           userDefaults.set(mobile, forKey: UserDefaultsConstants.mobileForAll)
           userDefaults.set(user_id, forKey: UserDefaultsConstants.user_idForAll)
           userDefaults.set(true, forKey: UserDefaultsConstants.waitForSMSCodeForSpecific)
           userDefaults.set(index, forKey: UserDefaultsConstants.indexForSMSCodeForSpecific)

           userDefaults.synchronize()
           goToNext(id: user_id)
       }
    
//    fileprivate func saveRadToken(mobile:String,index:Int,user_id:Int)  {
//        userDefaults.set(mobile, forKey: UserDefaultsConstants.mobileForAll)
//        userDefaults.set(user_id, forKey: UserDefaultsConstants.user_idForAll)
//        userDefaults.set(true, forKey: UserDefaultsConstants.waitForSMSCodeForSpecific)
//        userDefaults.set(index, forKey: UserDefaultsConstants.indexForSMSCodeForSpecific)
//
//        userDefaults.synchronize()
//        goToNext(id: user_id)
//    }
//
//    fileprivate func saveLABToken(mobile:String,index:Int,user_id:Int)  {
////        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
//        userDefaults.set(mobile, forKey: UserDefaultsConstants.pharamcyRegisterMobile)
//        userDefaults.set(user_id, forKey: UserDefaultsConstants.pharamcyRegisterUser_id)
//        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
//        userDefaults.synchronize()
//        goToNext(id: user_id)
//    }
//
//    fileprivate func savePharmacyToken(mobile:String,index:Int,user_id:Int)  {
////        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
//        userDefaults.set(mobile, forKey: UserDefaultsConstants.labRegisterMobile)
//        userDefaults.set(user_id, forKey: UserDefaultsConstants.labRegisterUser_id)
//        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
//        userDefaults.synchronize()
//        goToNext(id: user_id)
//    }
    
//    fileprivate func saveDoctorToken(mobile:String,index:Int,user_id:Int)  {
//        userDefaults.set(index, forKey: UserDefaultsConstants.MainLoginINDEX)
//        userDefaults.set(mobile, forKey: UserDefaultsConstants.doctorRegisterMobile)
//        userDefaults.set(user_id, forKey: UserDefaultsConstants.doctorSecondRegisterUser_id)
//        userDefaults.set(true, forKey: UserDefaultsConstants.isUserRegisterAndWaitForSMScODE)
//        userDefaults.synchronize()
//        goToNext(id: user_id)
//    }
    
    fileprivate  func goToNext(id:Int)  {
        let phone = customMainRegisterView.mobileNumberTextField.text ?? ""
        
        let verify = MainVerificationVC(indexx: index,isFromForgetPassw: false, isFromDoctor: false, phone: phone, user_id: id)
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
                self.saveAllToken(mobile: phone, index: self.index, user_id: user.id)
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
                self.saveAllToken(mobile: phone, index: self.index, user_id: user.id)
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
                self.saveAllToken(mobile: phone, index: self.index, user_id: user.id)
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
    
    @objc func handleDismissKeyboard()  {
        view.endEditing(true)
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

//MARK:-extension


extension MainRegisterVC: MainClinicWorkingHoursssProtocol{
    
    func getDays(indexs: [Int], days: [String]) {
        customMainRegisterView.workingHoursLabel.text = days.joined(separator: "-")
    }
    
    func getHoursChoosed(hours: [ PharamacyWorkModel]) {
        customMainRegisterView.registerViewModel.working_hours = hours
    }
    
    
}

//MARK:-extension


extension MainRegisterVC: ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
        convertLatLongToAddress(latitude: lat, longitude: long)
        customMainRegisterView.registerViewModel.latt = lat
        customMainRegisterView.registerViewModel.lang = long
        
    }
}
