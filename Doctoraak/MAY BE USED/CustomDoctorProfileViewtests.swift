////
////  CustomDoctorProfileView.swift
////  Doctoraak
////
////  Created by hosam on 3/28/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//import SkyFloatingLabelTextField
//
//class CustomDoctorProfileView: CustomBaseView {
//    
//    lazy var LogoImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
//        i.contentMode = .scaleAspectFill
//        return i
//    }()
//    lazy var listImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "ic_subject_24px"))
//        i.constrainWidth(constant: 30)
//        i.constrainHeight(constant: 30)
//        i.isUserInteractionEnabled = true
//        return i
//    }()
//    lazy var notifyImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "ic_notifications_active_24px"))
//        i.constrainWidth(constant: 30)
//        i.constrainHeight(constant: 30)
//        i.isUserInteractionEnabled = true
//        
//        return i
//    }()
//    lazy var titleLabel = UILabel(text: "Profile", font: .systemFont(ofSize: 35), textColor: .white)
//    
//    lazy var doctorProfileImage:UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
//        i.constrainWidth(constant: 100)
//        i.constrainHeight(constant: 100)
//        i.layer.cornerRadius = 50
//        i.clipsToBounds = true
//        return i
//    }()
//    lazy var doctorEditProfileImageView: UIImageView = {
//        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142"))
//        i.constrainWidth(constant: 28)
//        i.constrainHeight(constant: 28)
//        i.layer.cornerRadius = 8
//        i.contentMode = .scaleAspectFill
//        i.clipsToBounds = true
//        i.isUserInteractionEnabled = true
//        return i
//    }()
//    lazy var addressTextField:SkyFloatingLabelTextField = {
//        let t = SkyFloatingLabelTextField()
//        t.keyboardType = UIKeyboardType.default
//        t.placeholder = " Address".localized
//        t.titleColor = .black
//        t.title = "enter your Address".localized
//        t.placeholderColor = .black
//        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
//        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
//        t.errorColor = UIColor.red
//        return t
//    }()
//    lazy var phoneTextField:SkyFloatingLabelTextField = {
//        let t = SkyFloatingLabelTextField()
//        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
//        t.placeholder = "Phone".localized
//        t.keyboardType = UIKeyboardType.numberPad
//        t.title = "Phone".localized
//        t.placeholderColor = .black
//        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
//        return t
//    }()
//    lazy var emailTextField:SkyFloatingLabelTextField = {
//        let t = SkyFloatingLabelTextField()
//        t.keyboardType = UIKeyboardType.emailAddress
//        t.placeholder = "enter your email ".localized
//        t.titleColor = .black
//        t.title = "your email ".localized
//        t.placeholderColor = .black
//        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
//        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
//        t.errorColor = UIColor.red
//        t.constrainHeight(constant: 60)
//        return t
//    }()
//    lazy var cvView:UIView = {
//       let v = makeMainSubViewWithAppendView(vv: [cvLabel])
//        v.hstack(cvLabel,cvImage).padLeft(16)
//        return v
//    }()
//    lazy var cvLabel = UILabel(text: "cv.pdf", font: .systemFont(ofSize: 16), textColor: .lightGray)
//    lazy var cvImage:UIImageView = {
//       let v = UIImageView(image: #imageLiteral(resourceName: "Group 4142-2"))
//        v.constrainWidth(constant: 50)
//        return v
//    }()
////    lazy var cVTextField:SkyFloatingLabelTextField = {
////        let t = SkyFloatingLabelTextField()
////        t.title = "CV".localized
////        t.tintColor = .white
////        t.placeholderColor = .black
////        t.placeholder = "CV".localized
////        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
////        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
////        let chooseCVImage = UIImageView(image: #imageLiteral(resourceName: "Group 4142-2"))
////        //        chooseCVImage.setImage(#imageLiteral(resourceName: "Group 4142-2"), for: .normal)
////        chooseCVImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
////        //        chooseCVImage.frame = CGRect(x: CGFloat(t.frame.size.width - 80), y: CGFloat(0), width: CGFloat(80), height: CGFloat(50))
////        t.rightView = chooseCVImage
////        t.rightViewMode = .always
////
////        return t
////    }()
//    lazy var waitingHoursTextField:UITextField = {
//        let s = createMainTextFields(place: "Waiting hours", type: .numberPad)
//        let label = UILabel(text: "Time in m", font: .systemFont(ofSize: 16), textColor: .lightGray)
//        label.frame = CGRect(x: CGFloat(s.frame.size.width - 60), y: CGFloat(5), width: CGFloat(60), height: CGFloat(25))
//        s.rightView = label
//        s.rightViewMode = .always
//        return s
//    }()
//    //    lazy var chooseCVImage:UIImageView = {
//    //        let button = UIImageView(image: #imageLiteral(resourceName: "Group 4142-2"))
//    //
//    //        return button
//    //    }()
//    
//    lazy var nextButton:UIButton = {
//        let button = UIButton()
//        button.setTitle("Done", for: .normal)
//        button.backgroundColor = ColorConstants.disabledButtonsGray
//        button.setTitleColor(.black, for: .normal)
//        button.layer.cornerRadius = 16
//        button.constrainHeight(constant: 50)
//        button.clipsToBounds = true
//        button.isEnabled = false
//        return button
//    }()
//    
//    let doctorEdirProfileViewModel = DoctorEdirProfileViewModel()
//    
//    
//    override func setupViews() {
//        
//        [  phoneTextField,emailTextField,  addressTextField, waitingHoursTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
//        
//        let subView = UIView(backgroundColor: .clear)
//        subView.addSubViews(views: doctorProfileImage,doctorEditProfileImageView)
//        subView.constrainWidth(constant: 100)
//        subView.constrainHeight(constant: 100)
//        doctorEditProfileImageView.anchor(top: nil, leading: nil, bottom: doctorProfileImage.bottomAnchor, trailing: doctorProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
//        
//        let textStack = getStack(views: addressTextField,emailTextField,phoneTextField,cvView,waitingHoursTextField, spacing: 24, distribution: .fillEqually, axis: .vertical)
//        
//        addSubViews(views: LogoImage,listImage,notifyImage,titleLabel,subView,textStack,nextButton)
//        
//        //         insuranceDrop.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
//        NSLayoutConstraint.activate([
//            subView.centerXAnchor.constraint(equalTo: centerXAnchor)
//        ])
//        
//        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
//        subView.anchor(top: LogoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 50, left: 0, bottom: 0, right: 0))
//        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
//        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
//        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
//        textStack.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 148, left: 32, bottom: 16, right: 32))
//        //        //        genderStack.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
//        //        insuranceDrop.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
//        
//        
//        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
//        
//    }
//    
//    
//    //TODO: -handle methods
//    
//    @objc func textFieldDidChange(text: UITextField)  {
//        guard let texts = text.text else { return  }
//        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
//            if text == phoneTextField {
//                if  !texts.isValidPhoneNumber    {
//                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
//                    doctorEdirProfileViewModel.phone = nil
//                }
//                else {
//                    floatingLabelTextField.errorMessage = ""
//                    doctorEdirProfileViewModel.phone = texts
//                }
//                
//            }else if text == emailTextField {
//                if  !texts.isValidEmail    {
//                    floatingLabelTextField.errorMessage = "Invalid   Email".localized
//                    doctorEdirProfileViewModel.email = nil
//                }
//                else {
//                    floatingLabelTextField.errorMessage = ""
//                    doctorEdirProfileViewModel.email = texts
//                }
//                
//            }else if text ==  waitingHoursTextField {
//                if  (texts.count < 3 )    {
//                    floatingLabelTextField.errorMessage = "Invalid   waiting".localized
//                    doctorEdirProfileViewModel.hours = nil
//                }
//                else {
//                    floatingLabelTextField.errorMessage = ""
//                    doctorEdirProfileViewModel.hours = texts
//                }
//                
//            }else   {
//                if (texts.count < 3 ) {
//                    floatingLabelTextField.errorMessage = "Invalid Address".localized
//                    doctorEdirProfileViewModel.address = nil
//                }
//                else {
//                    
//                    doctorEdirProfileViewModel.address = texts
//                    floatingLabelTextField.errorMessage = ""
//                }
//                
//            }
//            
//        }
//    }
//}
