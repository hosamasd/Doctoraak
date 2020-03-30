//
//  DoctorProfileVC.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class DoctorProfileVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 800)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customDoctorProfileView:CustomDoctorProfileView = {
        let v = CustomDoctorProfileView()
        v.phoneTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.emailTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.addressTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.waitingHoursTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.doctorEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
        return v
    }()
    
    let doctorEdirProfileViewModel = DoctorEdirProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        doctorEdirProfileViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customDoctorProfileView.nextButton)
        }
        
        doctorEdirProfileViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
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
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customDoctorProfileView)
        customDoctorProfileView.fillSuperview()
        
        
        
    }
    
    //TODO: -handle methods
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customDoctorProfileView.phoneTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    doctorEdirProfileViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorEdirProfileViewModel.phone = texts
                }
                
            }else if text == customDoctorProfileView.emailTextField {
                if  !texts.isValidEmail    {
                    floatingLabelTextField.errorMessage = "Invalid   Email".localized
                    doctorEdirProfileViewModel.email = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorEdirProfileViewModel.email = texts
                }
                
            }else if text == customDoctorProfileView.waitingHoursTextField {
                if  (texts.count < 3 )    {
                    floatingLabelTextField.errorMessage = "Invalid   waiting".localized
                    doctorEdirProfileViewModel.hours = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorEdirProfileViewModel.hours = texts
                }
                
            }else   {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid Address".localized
                    doctorEdirProfileViewModel.address = nil
                }
                else {
                    
                    doctorEdirProfileViewModel.address = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }
            
        }
    }
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    
}


//MARK:-Extension

extension DoctorProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            doctorEdirProfileViewModel.image = img
            customDoctorProfileView.doctorProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            doctorEdirProfileViewModel.image = img
            customDoctorProfileView.doctorProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        doctorEdirProfileViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
