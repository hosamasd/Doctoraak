//
//  CustomClinicDataView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import iOSDropDown
import RSSelectionMenu
import SkyFloatingLabelTextField

class CustomClinicDataView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
         i.isUserInteractionEnabled = true
        return i
    }()
    
    lazy var titleLabel = UILabel(text: "Clinic", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Fill your data", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var clinicProfileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Ellipse 119-2"))
        i.constrainWidth(constant: 100)
        i.constrainHeight(constant: 100)
        i.layer.cornerRadius = 50
        i.clipsToBounds = true
        return i
    }()
    lazy var clinicEditProfileImageView: UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142"))
        i.isUserInteractionEnabled = true
        i.constrainWidth(constant: 28)
        i.constrainHeight(constant: 28)
        i.layer.cornerRadius = 8
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    lazy var clinicAddressTextField = createMainTextFields(place: "Address")
    lazy var clinicMobileNumberTextField = createMainTextFields(place: "Clinic phone",type: .numberPad)
    
    lazy var mainDropView:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.addSubview(cityDrop)
        return l
    }()
    lazy var cityDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
        i.placeholder = "City".localized
        return i
    }()
    lazy var mainDrop2View:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.addSubview(areaDrop)
        return l
    }()
    lazy var areaDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.optionArray = ["one","two","three"]
        i.arrowSize = 20
    
        i.placeholder = "Area".localized
        return i
    }()
    lazy var feesTextField:UITextField = {
        let s = createMainTextFields(place: "Fees", type: .numberPad)
        let label = UILabel(text: "EGY", font: .systemFont(ofSize: 18), textColor: .lightGray)
        label.frame = CGRect(x: CGFloat(s.frame.size.width - 60), y: CGFloat(5), width: CGFloat(60), height: CGFloat(25))
        s.rightView = label
        s.rightViewMode = .always
        return s
    }()
    lazy var consultationFeesTextField:UITextField = {
        let s = createMainTextFields(place: "Consultation fees", type: .numberPad)
        let label = UILabel(text: "EGY", font: .systemFont(ofSize: 18), textColor: .lightGray)
        label.frame = CGRect(x: CGFloat(s.frame.size.width - 60), y: CGFloat(5), width: CGFloat(60), height: CGFloat(25))
        s.rightView = label
        s.rightViewMode = .always
        return s
    }()
    lazy var clinicWorkingHoursTextField = createMainTextFields(place: "Work hours")
    lazy var waitingHoursTextField:UITextField = {
        let s = createMainTextFields(place: "Waiting hours", type: .numberPad)
        let label = UILabel(text: "Time in m", font: .systemFont(ofSize: 14), textColor: .lightGray)
        label.frame = CGRect(x: CGFloat(s.frame.size.width - 80), y: CGFloat(5), width: CGFloat(80), height: CGFloat(25))
        s.rightView = label
        s.rightViewMode = .always
        return s
    }()
    lazy var doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    var index = 0
    
    let clinicDataViewModel = ClinicDataViewModel()

    
    override func setupViews() {
        
        [ waitingHoursTextField, feesTextField, clinicAddressTextField,   clinicMobileNumberTextField, consultationFeesTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: clinicProfileImage,clinicEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        clinicEditProfileImageView.anchor(top: nil, leading: nil, bottom: clinicProfileImage.bottomAnchor, trailing: clinicProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
        
        let textStack = getStack(views: clinicMobileNumberTextField,clinicAddressTextField,mainDropView,mainDrop2View,feesTextField,consultationFeesTextField,clinicWorkingHoursTextField,waitingHoursTextField, spacing: 16, distribution: .fillEqually, axis: .vertical)
        [areaDrop,cityDrop].forEach({$0.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))})

        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,subView,textStack,doneButton)
        
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
//
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        subView.anchor(top: LogoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        textStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))

//
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    
    @objc func textFieldDidChange(text: UITextField)  {
           clinicDataViewModel.index = index
           clinicDataViewModel.city = "dd"
           clinicDataViewModel.area = "cc"
           clinicDataViewModel.workingHours = ["dsfds"]
           //        registerViewModel.insurance = "asd"
           guard let texts = text.text else { return  }
           if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
               if text == clinicMobileNumberTextField {
                   if  !texts.isValidPhoneNumber    {
                       floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                       clinicDataViewModel.phone = nil
                   }
                   else {
                       floatingLabelTextField.errorMessage = ""
                       clinicDataViewModel.phone = texts
                   }
                   
               }else if text == clinicAddressTextField {
                   if  (texts.count < 3 )   {
                       floatingLabelTextField.errorMessage = "Invalid   Addresss".localized
                       clinicDataViewModel.address = nil
                   }
                   else {
                       floatingLabelTextField.errorMessage = ""
                       clinicDataViewModel.address = texts
                   }
                   
               }else  if text == feesTextField {
                   if (texts.count < 1 ) {
                       floatingLabelTextField.errorMessage = "Invalid fees".localized
                       clinicDataViewModel.fees = nil
                   }
                   else {
                       floatingLabelTextField.errorMessage = ""
                       clinicDataViewModel.fees = texts
                   }
               }else  if text == consultationFeesTextField {
                   if (texts.count < 3 ) {
                       floatingLabelTextField.errorMessage = "Invalid consulation feez".localized
                       clinicDataViewModel.consultaionFees = nil
                   }
                   else {
                       
                       clinicDataViewModel.consultaionFees = texts
                       floatingLabelTextField.errorMessage = ""
                   }
                   
               }else if text == waitingHoursTextField {
                   if (texts.count < 3 ) {
                       floatingLabelTextField.errorMessage = "Invalid waiing".localized
                       clinicDataViewModel.waitingHours = nil
                   }
                   else {
                       
                       clinicDataViewModel.waitingHours = texts
                       floatingLabelTextField.errorMessage = ""
                   }
                   
               
               }
           }
       }
    
}
