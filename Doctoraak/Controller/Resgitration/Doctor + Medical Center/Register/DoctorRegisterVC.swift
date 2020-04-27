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
        v.userEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
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
        
        customRegisterView.doctorRegisterViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
            }
        })
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
    
    func goToNext()  {
        //         let second = DoctorSecondRegisterVC(indexx: self.index, male: male, photo: img, email: email, name: name, mobile: mobile, passowrd: password)
        //                   self.navigationController?.pushViewController(second, animated: true)
        userDefaults.set("phone", forKey: UserDefaultsConstants.userMobileNumber)
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
    
    @objc func handleNext()  {
        
        
        
        customRegisterView.doctorRegisterViewModel.performRegister {[unowned self] (img, name, mobile, email, password, male, index) in
//            let second = DoctorSecondRegisterVC(indexx: index, male: male, photo: img, email: email, name: name, mobile: mobile, passowrd: password)
//            self.navigationController?.pushViewController(second, animated: true)
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
