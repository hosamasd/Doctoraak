//
//  ClinicDataVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import MapKit
import SVProgressHUD
import MOLH



class MainClinicDataVC: CustomBaseViewVC {
    
    var cachedClinics:PharamacyWorkingHourModel?{
        didSet{
            guard let ww = cachedClinics else { return  }
            
        }
    }
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customClinicDataView:CustomClinicDataView = {
        let v = CustomClinicDataView()
        v.index = index
        v.api_token = api_token
        v.doctor_id=doctor_id
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        
        //        v.clinicWorkingHoursTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChooseWorkingHours)))
        v.clinicEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        
        v.handleChooseHours = {[unowned self] in
            self.handleChooseWorkingHours()
        }
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC()
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
        }
        //        v.cityDrop.addTarget(self, action: #selector(handleMulti), for: .touchUpInside)
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
    fileprivate let doctor_id:Int!
    fileprivate let api_token:String!
    init(indexx:Int,api_token:String,doctor_id:Int) {
        self.index = indexx
        self.api_token = api_token
        self.doctor_id = doctor_id
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        //        customClinicDataView.clinicWorkingHoursTextField.inputAccessoryView = UIView()
        
    }
    
    //MARK:-User methods
    
    func check()  {
        let s = #imageLiteral(resourceName: "lego(1)")
        let dd:[WorkModel] = [
            .init(part1From: "00:00", part1To: "00:00", part2From: "00:00", part2To: "00:00", day: 1, active: 0),
            .init(part1From: "00:00", part1To: "00:00", part2From: "00:00", part2To: "00:00", day: 2, active: 0),
            .init(part1From: "00:00", part1To: "00:00", part2From: "00:00", part2To: "00:00", day: 3, active: 0),
            .init(part1From: "00:00", part1To: "00:00", part2From: "00:00", part2To: "00:00", day: 4, active: 0),
            .init(part1From: "00:00", part1To: "00:00", part2From: "00:00", part2To: "00:00", day: 5, active: 0),
            .init(part1From: "00:00", part1To: "00:00", part2From: "00:00", part2To: "00:00", day: 6, active: 0),
            .init(part1From: "15:00", part1To: "20:00", part2From: "00:00", part2To: "00:00", day: 7, active: 1),
        ]
        
        
        RegistrationServices.shared.RegiasterClinicCreate(fees2: 4, fees: 4, lang: "30.5653565965", latt: "30.5653565965", phone: "99999999632", photo:s , city: 1, area: 1, api_token: "Jb7LVajdcATjzD6ShfC1QPCsfMOndOt2jMk4DI1USrETbRwM5T", waiting_time: 20, doctor_id: 30, working_hours: dd) { (base, err) in
            if let err=err{
                print(err.localizedDescription)
            }
        }
    }
    
    func setupViewModelObserver()  {
        customClinicDataView.clinicDataViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            
            self.changeButtonState(enable: isValid, vv: self.customClinicDataView.doneButton)
        }
        
        customClinicDataView.clinicDataViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                SVProgressHUD.show(withStatus: "Looding...".localized)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
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
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customClinicDataView)
        customClinicDataView.fillSuperview()
        
        
        
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Location name
            guard let locationName = placeMark.locality , let street = placeMark.thoroughfare, let city = placeMark.subAdministrativeArea, let country = placeMark.country else {return}
            self.customClinicDataView.addressLabel.text = "\(locationName) - \(street) - \(city) - \(country)"
        })
        
        
    }
    
    func goToNext(_ clinic_id:Int)  {
        
        self.updateStates(clinic_id,index: index)
        let base = BaseSlidingVC()
        //        base
        
        //        let main = DoctorHomeVC(inde: index)
        //        navigationController?.pushViewController(main, animated: true)
        //           if  isFromForgetPassw {
        //               let  vc =  MainNewPassVC(indexx: index)
        //               navigationController?.pushViewController(vc, animated: true)
        //           }else {
        //
        //               let vc =  MainClinicDataVC(indexx: index,api_token: api_token,doctor_id: doctor_id)
        //               navigationController?.pushViewController(vc, animated: true)
        //           }
        
    }
    
    func updateStates(_ clinic_id:Int,index:Int)  {
        let d = index == 0 ? UserDefaultsConstants.DoctorPerformLogin : UserDefaultsConstants.medicalCenterPerformLogin
        
        userDefaults.set(clinic_id, forKey: UserDefaultsConstants.DocotrClinicCreateCLINICID)
        userDefaults.set(true, forKey: d)
        userDefaults.set(index, forKey: UserDefaultsConstants.DoctorPerformLoginWithMainIndex)
        removeOtherDefults()
        userDefaults.synchronize()
    }
    
    func removeOtherDefults()  {
        userDefaults.removeObject(forKey: UserDefaultsConstants.first1)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first11)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first211)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first2111)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first21)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first2)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first22)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first221)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first3)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first31)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first23)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first231)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.first4)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first41)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first24)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first241)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first5)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first51)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first25)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.first251)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first6)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first61)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first26)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first261)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first1)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first1)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.first7)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first71)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first27)
        userDefaults.removeObject(forKey: UserDefaultsConstants.first271)
        userDefaults.removeObject(forKey: UserDefaultsConstants.day1)
        userDefaults.removeObject(forKey: UserDefaultsConstants.day2)
        userDefaults.removeObject(forKey: UserDefaultsConstants.day3)
        userDefaults.removeObject(forKey: UserDefaultsConstants.day4)
        userDefaults.removeObject(forKey: UserDefaultsConstants.day5)
        userDefaults.removeObject(forKey: UserDefaultsConstants.day6)
        userDefaults.removeObject(forKey: UserDefaultsConstants.day7)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterImage)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterName)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterEmail)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterMobile)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterPassword)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterMale)
        
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterIndee)
        userDefaults.set(false, forKey: UserDefaultsConstants.isDoctorSecondRegister)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorSecondRegisterSMSCode)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterMobile)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterPassword)
        userDefaults.removeObject(forKey: UserDefaultsConstants.doctorRegisterMale)
        
    }
    
    //TODO: -handle methods
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDone()  {
        
        customClinicDataView.clinicDataViewModel.performRegister { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.goToNext(user.id)
            }
        }
        
    }
    
    func handleChooseWorkingHours()  {
        let payment = MainClinicWorkingHoursNotDoctorVC(index: index)
        payment.delgate = self
        navigationController?.pushViewController(payment, animated: true)
    }
    
    fileprivate func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:-Extension


extension MainClinicDataVC: MainClinicWorkingHoursssProtocol {
    func getDays(indexs: [Int], days: [String]) {
        print(indexs,"              ",days)
        customClinicDataView.workingHoursLabel.text = days.joined(separator: "-")
    }
    
    func getHoursChoosed(hours: [ PharamacyWorkModel]) {
        //        customClinicDataView.clinicDataViewModel.workingArrayHours = hours
    }
}



extension MainClinicDataVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customClinicDataView.clinicDataViewModel.image = img
            customClinicDataView.clinicProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customClinicDataView.clinicDataViewModel.image = img
            customClinicDataView.clinicProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customClinicDataView.clinicDataViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}


extension MainClinicDataVC: ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
        customClinicDataView.clinicDataViewModel.latt = "\(lat)"
        customClinicDataView.clinicDataViewModel.lang = "\(long)"
        convertLatLongToAddress(latitude: lat, longitude: long)
        print(lat, "            ",long)
    }
}
