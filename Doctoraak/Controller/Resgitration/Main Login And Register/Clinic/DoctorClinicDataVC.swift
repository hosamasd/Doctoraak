//
//  DoctorClinicDataVC.swift
//  Doctoraak
//
//  Created by hosam on 6/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH
import MapKit


class DoctorClinicDataVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator=false
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1030)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customClinicDataView:CustomClinicDataView = {
        let v = CustomClinicDataView()
        v.index = index
        v.isFromUpdate=isUpdateClinic
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        v.updateButton.addTarget(self, action: #selector(createAlertsForUpdating), for: .touchUpInside)
        v.clinicEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        
        v.handleChooseHours = {[unowned self] in
            self.handleChooseWorkingHours()
        }
        v.handlerChooseLocation = {[unowned self] in
            let loct = ChooseLocationVC(isFromUpdate: false)
            
            
            loct.lattAndLng=self.clinic_id
            loct.delgate = self
            self.navigationController?.pushViewController(loct, animated: true)
        }
        v.cancelButton.addTarget(self, action: #selector(createAlerts), for: .touchUpInside)
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
    
    var cachedClinics:WorkModel?{
        didSet{
            guard let ww = cachedClinics else { return  }
            
            
        }
    }
    
    var clinic_id:ClinicGetDoctorsModel?{
        didSet{
            guard let clinic_id = clinic_id else { return  }
            customClinicDataView.clinic_id=clinic_id
        }
    }
    
    
    var doctor:DoctorModel?{
        didSet{
            guard let doc = doctor else { return  }
            customClinicDataView.doctor=doc
        }
    }
    
    
    //check to go specific way
    fileprivate let index:Int!
    fileprivate let isAddClinic:Bool!
    fileprivate let isUpdateClinic:Bool!
    fileprivate let isFromProfile:Bool!
    init(indexx:Int,isAddClinic:Bool,isUpdateClinic:Bool,isFromProfile:Bool){//,doctor_id:Int,api_token:String) {
        self.index = indexx
        self.isFromProfile=isFromProfile
        self.isAddClinic = isAddClinic
        self.isUpdateClinic = isUpdateClinic
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        //        customClinicDataView.clinicWorkingHoursTextField.inputAccessoryView = UIView()
        
    }
    
    //MARK:-User methods
    
    fileprivate func setupViewModelObserver()  {
        customClinicDataView.clinicDataViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            
            self.changeButtonState(enable: isValid, vv: self.customClinicDataView.doneButton)
        }
        
        customClinicDataView.clinicDataViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Looding...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
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
    
    fileprivate func goToNext(_ clinic_id:Int)  {
        self.updateStates(clinic_id,index: index)
        if isAddClinic {
            let payment = MainPaymentVC()
            navigationController?.pushViewController(payment, animated: true)
        }else{ dismiss(animated: true)}
        
        //        isFromProfile ? self.removeSomeObjects() :    self.updateStates(clinic_id,index: index)
        
    }
    
    fileprivate  func updateStates(_ clinic_id:Int,index:Int)  {
        userDefaults.removeObject(forKey: UserDefaultsConstants.indexForSMSCodeForSpecific)
        userDefaults.removeObject(forKey: UserDefaultsConstants.user_idForAll)
        userDefaults.set(true, forKey: UserDefaultsConstants.currentUserLoginInAPP)
        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
        cachdDOCTORWorkingHourObjectCodabe.deleteFile(cachdDOCTORWorkingHourObjectCodabe.storedValue!)
        userDefaults.set(false, forKey: UserDefaultsConstants.isDoctorWorkingHoursCached)
        userDefaults.synchronize()
    }
    
    fileprivate func handleChooseWorkingHours()  {
        let payment = DoctorClinicWorkingHoursVC(isFromLeftMenu: false, isFromMainClinic: true)//MainClinicWorkingHoursNotDoctorVC(index: index,isFromUpdateProfile:true,isFromRegister: true)
        payment.delgate = self
        payment.doctor=self.clinic_id
        navigationController?.pushViewController(payment, animated: true)
    }
    
    fileprivate func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    func handleCancelReservation()  {
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        //                SVProgressHUD.show(withStatus: "Looding...".localized)
        self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
        customClinicDataView.clinicDataViewModel.performCancelOrders { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //                   SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.saveDefaults()
                self.dismiss(animated: true)
                //                       self.goToNext(user.id)
            }
        }
    }
    
    func saveDefaults()  {
        userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetched)
        userDefaults.synchronize()
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
    
    @objc func createAlerts() {
        let alert = UIAlertController(title: "Warring...".localized, message: "Do You Want To Cancel All Orders Today?".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Submit".localized, style: .destructive) { (_) in
            self.handleCancelReservation()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func createAlertsForUpdating() {
        let alert = UIAlertController(title: "Warring...".localized, message: "Do You Want To Update?".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Submit".localized, style: .destructive) { (_) in
            self.handleUpdateClinic()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func handleBack()  {
        if isFromProfile {
            dismiss(animated: true)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func handleDone()  {
        
        customClinicDataView.clinicDataViewModel.performRegister { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.goToNext(user.id)
            }
        }
        
    }
    
    
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func handleUpdateClinic()  {
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        //                SVProgressHUD.show(withStatus: "Login...".localized)
        self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
        customClinicDataView.clinicDataViewModel.performUpdating { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //            SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                //                           self.goToNext(user.id)
            }
        }
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:-Extension


extension DoctorClinicDataVC: MainClinicWorkingHoursProtocol {
    func getHoursChoosed(hours: [WorkModel]) {
        customClinicDataView.clinicDataViewModel.workingArrayHours=hours
    }
    
    func getDays(indexs: [Int], days: [String]) {
        print(indexs,"              ",days)
        customClinicDataView.workingHoursLabel.text = days.count <=  0 ? "No Days Chossen".localized : days.joined(separator: "-")
    }
}

//MARK:-extension


extension DoctorClinicDataVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if var img = info[.originalImage]  as? UIImage   {
            let jpegData = img.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
            img = (jpegSize > 30000 ? img.resized(toWidth: 1300) : img) ?? img
            customClinicDataView.clinicDataViewModel.image = img
            customClinicDataView.clinicProfileImage.image = img
        }
        if var img = info[.editedImage]  as? UIImage   {
            let jpegData = img.jpegData(compressionQuality: 1.0)
            let jpegSize: Int = jpegData?.count ?? 0
            img = (jpegSize > 30000 ? img.resized(toWidth: 1300) : img) ?? img
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

//MARK:-extension


extension DoctorClinicDataVC: ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
        customClinicDataView.clinicDataViewModel.latt = lat
        customClinicDataView.clinicDataViewModel.lang = long
        convertLatLongToAddress(latitude: lat, longitude: long) { (ss) in
            self.customClinicDataView.addressLabel.text=ss
        }
    }
}

