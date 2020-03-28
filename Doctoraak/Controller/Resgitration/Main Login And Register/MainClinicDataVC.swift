//
//  ClinicDataVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class MainClinicDataVC: CustomBaseViewVC {
    
    
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
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        v.waitingHoursTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.feesTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.clinicAddressTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.clinicMobileNumberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.consultationFeesTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.clinicWorkingHoursTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChooseWorkingHours)))
        v.clinicEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))

        //        v.cityDrop.addTarget(self, action: #selector(handleMulti), for: .touchUpInside)
        return v
    }()
    var index:Int = 0
    
    let clinicDataViewModel = ClinicDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        customClinicDataView.clinicWorkingHoursTextField.inputAccessoryView = UIView()

    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        clinicDataViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customClinicDataView.doneButton)
        }
        
        clinicDataViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
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
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDone()  {
        let payment = MainPaymentVC()
        payment.index = index
        navigationController?.pushViewController(payment, animated: true)
    }
    
    @objc func handleChooseWorkingHours()  {
        let payment = MainClinicWorkingHoursVC()
        payment.delgate = self
        payment.index = index
        navigationController?.pushViewController(payment, animated: true)
    }
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        clinicDataViewModel.index = index
        clinicDataViewModel.city = "dd"
        clinicDataViewModel.area = "cc"
        clinicDataViewModel.workingHours = ["dsfds"]
//        registerViewModel.insurance = "asd"
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customClinicDataView.clinicMobileNumberTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    clinicDataViewModel.phone = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    clinicDataViewModel.phone = texts
                }
                
            }else if text == customClinicDataView.clinicAddressTextField {
                if  (texts.count < 3 )   {
                    floatingLabelTextField.errorMessage = "Invalid   Addresss".localized
                    clinicDataViewModel.address = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    clinicDataViewModel.address = texts
                }
                
            }else  if text == customClinicDataView.feesTextField {
                if (texts.count < 1 ) {
                    floatingLabelTextField.errorMessage = "Invalid fees".localized
                    clinicDataViewModel.fees = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    clinicDataViewModel.fees = texts
                }
            }else  if text == customClinicDataView.consultationFeesTextField {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid consulation feez".localized
                    clinicDataViewModel.consultaionFees = nil
                }
                else {
                    
                    clinicDataViewModel.consultaionFees = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }else if text == customClinicDataView.waitingHoursTextField {
                if (texts.count < 3 ) {
                    floatingLabelTextField.errorMessage = "Invalid waiing".localized
                    clinicDataViewModel.waitingHours = nil
                }
                else {
                    
                    clinicDataViewModel.waitingHours = texts
                    floatingLabelTextField.errorMessage = ""
                }
                
            }else {
//                if (texts.count < 3 ) {
//                    floatingLabelTextField.errorMessage = "Invalid working hours".localized
//                    registerViewModel.hours = nil
//                }
//                else {
//
//                    registerViewModel.hours = texts
//                    floatingLabelTextField.errorMessage = ""
//                }
            }
        }
    }
    
}

//MARK:-Extension


extension MainClinicDataVC: MainClinicWorkingHoursProtocol {
    
    func getHoursChoosed(hours: [String]) {
        let texts = hours.map{$0}.joined(separator: ",")
        
        customClinicDataView.clinicWorkingHoursTextField.text = texts
    }
    
    
    
}



extension MainClinicDataVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            clinicDataViewModel.image = img
            customClinicDataView.clinicProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            clinicDataViewModel.image = img
            customClinicDataView.clinicProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        clinicDataViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
