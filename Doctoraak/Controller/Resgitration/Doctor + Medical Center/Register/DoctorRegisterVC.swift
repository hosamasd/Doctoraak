//
//  RegisterVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SVProgressHUD

class DoctorRegisterVC: CustomBaseViewVC {
    
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
    
    lazy var customRegisterView:CustomRegisterView = {
        let v = CustomRegisterView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.index = index
        v.nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        v.userEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
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
        customRegisterView.doctorRegisterViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customRegisterView.nextButton)
        }
    }
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customRegisterView)
        customRegisterView.fillSuperview()
    }
    
    fileprivate func saveDefults(img:UIImage,name:String,mobile:String,email:String,password:String,male:String,index:Int)  {
        let data = img.pngData()
        userDefaults.set(data, forKey: UserDefaultsConstants.doctorRegisterImage)
        userDefaults.set(name, forKey: UserDefaultsConstants.doctorRegisterName)
        userDefaults.set(email, forKey: UserDefaultsConstants.doctorRegisterEmail)
        userDefaults.set(mobile, forKey: UserDefaultsConstants.doctorRegisterMobile)
        userDefaults.set(password, forKey: UserDefaultsConstants.doctorRegisterPassword)
        userDefaults.set(male, forKey: UserDefaultsConstants.doctorRegisterMale)
        userDefaults.set(index, forKey: UserDefaultsConstants.doctorRegisterIndee)
        userDefaults.set(true, forKey: UserDefaultsConstants.isDoctorSecondRegister)
        userDefaults.synchronize()
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
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNext()  {
        
        
        
        customRegisterView.doctorRegisterViewModel.performRegister {[unowned self] (img, name, mobile, email, password, male, index) in
            self.saveDefults(img: img, name: name, mobile: mobile, email: email, password: password, male: male, index: index)
            let second = DoctorSecondRegisterVC(indexx: index, male: male, photo: img, email: email, name: name, mobile: mobile, passowrd: password)
            self.navigationController?.pushViewController(second, animated: true)
        }
        
    }
    
}



//MARK:-Extension

extension DoctorRegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customRegisterView.doctorRegisterViewModel.image = img
            customRegisterView.userProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customRegisterView.doctorRegisterViewModel.image = img
            customRegisterView.userProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customRegisterView.doctorRegisterViewModel.image = nil
        dismiss(animated: true)
    }
    
    
    
}
