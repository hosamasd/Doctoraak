//
//  CalenderVC.swift
//  Doctoraak
//
//  Created by hosam on 6/17/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//
import MapKit
import UIKit
import SVProgressHUD
import MOLH

class PharamacyProfileVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator=false
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1100)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customPharamacyProfileView:CustomPharamacyProfileView = {
        let v = CustomPharamacyProfileView()
        
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.userEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        v.nextButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        v.handleChooseHours = {[unowned self] in
            let working = MainClinicWorkingHoursNotDoctorVC(index: self.index,isFromUpdateProfile:true,isFromRegister: false)
            working.delgate = self
            if !userDefaults.bool(forKey: UserDefaultsConstants.chhosedCachesWorkingHours) {
                working.lab = self.lab
                working.rad=self.rad
                working.phy=self.phy
            }
            self.navigationController?.pushViewController(working, animated: true)
        }
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC(isFromUpdate: true)
            loct.delgate = self
            loct.lab = self.lab
            loct.rad=self.rad
            loct.phy=self.phy
            //            loct.phy = cachdPHARMACYObjectCodabe.storedValue //self.phy
            //            loct.lab=cacheLABObjectCodabe.storedValue
            //            loct.rad=cachdRADObjectCodabe.storedValue
            self.navigationController?.pushViewController(loct, animated: true)
        }
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            customPharamacyProfileView.phy=phy
        }
    }
    
    var lab:LabModel?{
        didSet{
            guard let phy = lab else { return  }
            customPharamacyProfileView.lab=phy
        }
    }
    
    var rad:RadiologyModel?{
        didSet{
            guard let phy = rad else { return  }
            customPharamacyProfileView.rad=phy
        }
    }
    
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
        setupViewModelObserver()
        scrollView.delegate=self
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    
    
    override func setupViews()  {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customPharamacyProfileView)
        customPharamacyProfileView.fillSuperview()
        
    }
    
    fileprivate func setupViewModelObserver()  {
        customPharamacyProfileView.edirProfileViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customPharamacyProfileView.nextButton)
        }
        
        customPharamacyProfileView.edirProfileViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
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
    
    fileprivate func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    fileprivate func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] (placemarks, error) -> Void in
            
            // Place details
            //            var placeMark: CLPlacemark?
            guard let   placeMark = placemarks?[0] else {return}
            
            self.customPharamacyProfileView.addressLabel.text =  placeMark.locality ?? ""
            
            // Location name
            guard  let street = placeMark.subLocality, let city = placeMark.administrativeArea, let country = placeMark.country else {return}
            self.customPharamacyProfileView.addressLabel.text =  " \(street) - \(city) - \(country)"
        })
        
        
    }
    
    fileprivate func cachedATA(_ patient:PharamacyModel? = nil ,_ lab:LabModel? = nil,_ rad:RadiologyModel? = nil)  {
        patient != nil ?    cachdPHARMACYObjectCodabe.save(patient!) : ()
        lab != nil ?    cacheLABObjectCodabe.save(lab!) : ()
        rad != nil ?    cachdRADObjectCodabe.save(rad!) : ()
        
        userDefaults.set(false, forKey: UserDefaultsConstants.chhosedCachesWorkingHours)
        userDefaults.synchronize()
    }
    
    fileprivate  func checkPharamacyLoginState()  {
        customPharamacyProfileView.edirProfileViewModel.performPHARAMACYUpdating { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                               self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                
                self.activeViewsIfNoData();return
            }
            //            SVProgressHUD.dismiss()
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            self.cachedATA(user)
            DispatchQueue.main.async {
                self.showToast(context: self, msg: "your information updated...".localized)
            }
        }
    }
    
    fileprivate  func checkLabLoginState()  {
        customPharamacyProfileView.edirProfileViewModel.performLABUpdating { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                               self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                
                self.activeViewsIfNoData();return
            }
            //            SVProgressHUD.dismiss()
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            self.cachedATA(nil,user)
            DispatchQueue.main.async {
                self.showToast(context: self, msg: "your information updated...".localized)
            }
        }
    }
    
    fileprivate func checkRadLoginState()  {
        customPharamacyProfileView.edirProfileViewModel.performRADUpdating { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                               self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //            SVProgressHUD.dismiss()
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            self.cachedATA(nil,nil,user)
            DispatchQueue.main.async {
                self.showToast(context: self, msg: "your information updated...".localized)
            }
        }
    }
    
    //TODO: -handle methods
    
    
    
    @objc func createAlertForChoposingImage()  {
        let alert = UIAlertController(title: "Choose Image".localized, message: "Choose image fROM ".localized, preferredStyle: .alert)
        let camera = UIAlertAction(title: "Camera".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .camera)
            
        }
        let gallery = UIAlertAction(title: "Open From Gallery".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_) in
            alert.dismiss(animated: true)
        }
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func handleBack()  {
        dismiss(animated: true)
        //        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleSave()  {
        index == 4 ? checkPharamacyLoginState() : index == 2 ? checkLabLoginState() : checkRadLoginState()
        
        
    }
}

//MARK:-extension


extension PharamacyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customPharamacyProfileView.edirProfileViewModel.image = img
            customPharamacyProfileView.userProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customPharamacyProfileView.edirProfileViewModel.image = img
            customPharamacyProfileView.userProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customPharamacyProfileView.edirProfileViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}

//MARK:-extension


extension PharamacyProfileVC :MainClinicWorkingHoursssProtocol{
    
    func getDays(indexs: [Int], days: [String]) {
        customPharamacyProfileView.workingHoursLabel.text = days.joined(separator: "-")
    }
    
    func getHoursChoosed(hours: [ PharamacyWorkModel]) {
        customPharamacyProfileView.edirProfileViewModel.working_hours = hours
    }
    
    
}

//MARK:-extension


extension PharamacyProfileVC: ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
        convertLatLongToAddress(latitude: lat, longitude: long)
        customPharamacyProfileView.edirProfileViewModel.latt = lat
        customPharamacyProfileView.edirProfileViewModel.lang = long
    }
}

extension PharamacyProfileVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
