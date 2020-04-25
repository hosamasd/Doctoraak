//
//  PharmacyLoginVC.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
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
        v.constrainHeight(constant: 1200)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customMainRegisterView:CustomMainRegisterView = {
        let v = CustomMainRegisterView()
        v.index = index
        
        v.userEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        v.handleChooseHours = {[unowned self] in
            let working = DoctorClinicWorkingHoursVC()
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
    
    //check to go specific way
    fileprivate let index:Int!
    init(indexx:Int) {
        self.index = indexx
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customMainRegisterView.registerViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customMainRegisterView.nextButton)
        }
        
        customMainRegisterView.registerViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                                SVProgressHUD.dismiss()
                                self.activeViewsIfNoData()
            }
        })
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
    


    func convertLatLongToAddress(latitude:Double,longitude:Double){

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {[unowned self] (placemarks, error) -> Void in

            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]

            // Location name
            guard let locationName = placeMark.locality , let street = placeMark.thoroughfare, let city = placeMark.subAdministrativeArea, let country = placeMark.country else {return}
             self.customMainRegisterView.addressLabel.text = "\(locationName) - \(street) - \(city) - \(country)"
        })

        
    }


    
    //TODO: -handle methods
    
    
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc  func handleNext()  {
        let phone = customMainRegisterView.mobileNumberTextField.text ?? ""
        
        let verify = MainVerificationVC(indexx: index,isFromForgetPassw: false, phone: phone)
        navigationController?.pushViewController(verify, animated: true)
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


extension MainRegisterVC: MainClinicWorkingHoursProtocol{
    
    func getDays(indexs: [Int], days: [String]) {
           print(indexs,"              ",days)
       }
    
    func getHoursChoosed(hours: [[String : Any]]) {
        print(hours)
    }
    
//    func getHoursChoosed(hours: [String]) {
//        customMainRegisterView.workingHoursLabel.text = hours.first
//    }
    
    
    
}

extension MainRegisterVC: ChooseLocationVCProtocol{
    
    func getLatAndLong(lat: Double, long: Double) {
//           customMainRegisterView.registerViewModel.lat = "\(lat)"
//           customLapSearchView.registerViewModel.lng = "\(long)"
        convertLatLongToAddress(latitude: lat, longitude: long)
           print(lat, "            ",long)
       }
}
