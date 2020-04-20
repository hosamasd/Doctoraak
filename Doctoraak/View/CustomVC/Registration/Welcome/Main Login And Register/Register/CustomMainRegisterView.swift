//
//  CustomPharmacyRegisterView.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import iOSDropDown
import UIMultiPicker
import SkyFloatingLabelTextField
import MOLH

class CustomMainRegisterView: CustomBaseView {
    
    var index:Int! {
        didSet{
            fullNameTextField.placeholder = index == 4 ? "Pharmacy Name" : index == 2 ? "Lap Name" : "Center Name"
            mobileNumberTextField.placeholder = index == 4 ? "Pharmacy phone"  : index == 2 ? "Lap phone" : "Center phone"
            soonLabel.text = index == 4 ? "Creat Pharmacy account"  : index == 2 ? "Creat Lap account" : "Creat Center account"

    }
    }
    
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
    
    lazy var titleLabel = UILabel(text: "Welcome", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Creat Pharmacy account", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var userProfileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
        i.constrainWidth(constant: 100)
        i.constrainHeight(constant: 100)
        i.layer.cornerRadius = 50
        i.clipsToBounds = true
        return i
    }()
    lazy var userEditProfileImageView: UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142"))
        i.constrainWidth(constant: 28)
        i.constrainHeight(constant: 28)
        i.layer.cornerRadius = 8
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.isUserInteractionEnabled = true
        return i
    }()
    
    lazy var fullNameTextField = createMainTextFields(place: " Name")
    lazy var mobileNumberTextField = createMainTextFields(place: " phone",type: .numberPad)
    lazy var emailTextField = createMainTextFields(place: "enter email",type: .emailAddress)
    lazy var passwordTextField:UITextField = {
        let s = createMainTextFields(place: "Password", type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASD), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
    lazy var confirmPasswordTextField:UITextField = {
        let s = createMainTextFields(place: "confirm Password", type: .default,secre: true)
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "visiblity"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(handleASDs), for: .touchUpInside)
        s.rightView = button
        s.rightViewMode = .always
        return s
    }()
    
    lazy var addressMainView:UIView = {
           let v = makeMainSubViewWithAppendView(vv: [addressLabel])
           //        v.addSubViews(views: addressImage,addressLabel)
           v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenLocation)))
           
           v.hstack(addressLabel).withMargins(.init(top: 0, left: 16, bottom: 0, right: 8))
           return v
       }()
       lazy var addressLabel = UILabel(text: "Address", font: .systemFont(ofSize: 16), textColor: .lightGray)
//    lazy var addressTextField = createMainTextFields(place: "Address")
    
    lazy var mainDrop3View:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
//        l.constrainHeight(constant: 50)
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseInsurance)))
        //        l.addSubview(insuranceDrop)
        return l
    }()
    lazy var doenImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-6"))
        i.constrainWidth(constant: 50)
//        i.constrainHeight(constant: 50)
        return i
    }()
    lazy var insuracneText = UILabel(text: "choose insurance", font: .systemFont(ofSize: 18), textColor: .black, textAlignment: .left)
    lazy var insuranceDrop:UIMultiPicker = {
        let v = UIMultiPicker(backgroundColor: .white)
//        v.options = insuracneArray
        v.color = .gray
        v.tintColor = .green
        v.font = .systemFont(ofSize: 30, weight: .bold)
        v.highlight(2, animated: true) // centering "Bitter"
        v.constrainHeight(constant: 150)
        v.isHide(true)
        v.addTarget(self, action: #selector(handleHidePicker), for: .valueChanged)
        return v
    }()
    lazy var workingHourView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [workingHoursLabel])
        v.hstack(workingHoursLabel).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChoose)))
        return v
    }()
    lazy var workingHoursLabel = UILabel(text: "Working Hours", font: .systemFont(ofSize: 16), textColor: .lightGray)
//    lazy var pharamacyWorkingHoursTextField = createMainTextFields(place: "Work hours")

    lazy var deliverySwitch:UISwitch = {
       let s = UISwitch()
        s.onTintColor = #colorLiteral(red: 0.3896943331, green: 0, blue: 0.8117204905, alpha: 1)
        s.isOn = true
        s.addTarget(self, action: #selector(handleDelvieryCheck), for: .valueChanged)

        return s
    }()
    
    lazy var deliveryView = makeMainSubViewWithAppendView(vv: [deliveryLabel,deliverySwitch])
      
      lazy var deliveryLabel = UILabel(text: "Delivery ?", font: .systemFont(ofSize: 20), textColor: .lightGray)
    
   
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    var text:String?
     var insuracneArray = ["one","two","three","sdfdsfsd"]
 let registerViewModel = RegisterViewModel()
    var handleChooseHours:(()->Void)?
    var handlerChooseLocation:(()->Void)?
    var insuranceStringArray = [String]()
              var insuranceNumberArray = [Int]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
           if isArabic {
               
               
            if let insuranceNameArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameARArray) as? [String],let insuranceIdArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int] {
                self.insuranceStringArray = insuranceNameArray
                self.insuranceNumberArray = insuranceIdArray
            
                
               }
           }else {
               if let insuranceNameArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameArray) as? [String],let insuranceIdArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int] {
                   self.insuranceStringArray = insuranceNameArray
                   self.insuranceNumberArray = insuranceIdArray
               }
           }
        self.insuranceDrop.options = insuranceStringArray
           DispatchQueue.main.async {
               self.layoutIfNeeded()
           }
       }
    
    fileprivate func fetchData()  {
        
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
    }
    
    override func setupViews() {
        [mobileNumberTextField,passwordTextField,  emailTextField, fullNameTextField, confirmPasswordTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: userProfileImage,userEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        userEditProfileImageView.anchor(top: nil, leading: nil, bottom: userProfileImage.bottomAnchor, trailing: userProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
       
        let textStack = getStack(views: fullNameTextField,mobileNumberTextField,emailTextField,passwordTextField,confirmPasswordTextField,addressMainView,mainDrop3View, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        mainDrop3View.addSubViews(views: doenImage,insuracneText)
        mainDrop3View.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        deliveryView.hstack(deliveryLabel,deliverySwitch).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))

        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,subView,textStack,workingHourView,deliveryView,insuranceDrop,nextButton)
        
//         insuranceDrop.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        subView.anchor(top: LogoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        
        textStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
         insuranceDrop.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        //        genderStack.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        workingHourView.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        deliveryView.anchor(top: workingHourView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
       

        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
           registerViewModel.index = index
           registerViewModel.insurance = "asd"
           guard let texts = text.text else { return  }
           if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
               if text == mobileNumberTextField {
                   if  !texts.isValidPhoneNumber    {
                       floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                       registerViewModel.phone = nil
                   }
                   else {
                       floatingLabelTextField.errorMessage = ""
                       registerViewModel.phone = texts
                   }
                   
               }else if text == emailTextField {
                   if  !texts.isValidEmail    {
                       floatingLabelTextField.errorMessage = "Invalid   Email".localized
                       registerViewModel.email = nil
                   }
                   else {
                       floatingLabelTextField.errorMessage = ""
                       registerViewModel.email = texts
                   }
                   
               }else   if text == confirmPasswordTextField {
                   if text.text != passwordTextField.text {
                       floatingLabelTextField.errorMessage = "Passowrd should be same".localized
                       registerViewModel.confirmPassword = nil
                   }
                   else {
                       registerViewModel.confirmPassword = texts
                       floatingLabelTextField.errorMessage = ""
                   }
               }else  if text == passwordTextField {
                   if(texts.count < 8 ) {
                       floatingLabelTextField.errorMessage = "password must have 8 character".localized
                       registerViewModel.password = nil
                   }
                   else {
                       floatingLabelTextField.errorMessage = ""
                       registerViewModel.password = texts
                   }
               
                   
               }else if text == fullNameTextField {
                   if (texts.count < 3 ) {
                       floatingLabelTextField.errorMessage = "Invalid name".localized
                       registerViewModel.name = nil
                   }
                   else {
                       
                       registerViewModel.name = texts
                       floatingLabelTextField.errorMessage = ""
                   }
                   
               }else {
                   if (texts.count < 3 ) {
                       floatingLabelTextField.errorMessage = "Invalid working hours".localized
                       registerViewModel.hours = nil
                   }
                   else {
                       
                       registerViewModel.hours = texts
                       floatingLabelTextField.errorMessage = ""
                   }
               }
           }
       }
    
    @objc func handleASD()  {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func handleASDs()  {
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
    }
    
   
    var iiii = ""
    var de = ""
    
    @objc func handleHidePicker(sender:UIMultiPicker)  {
        sender.selectedIndexes.forEach { (i) in
            
            de += insuracneArray[i] + ","
        }
        iiii = de
        insuracneText.text = iiii
        de = ""
    }
    
    @objc func handleOpenCloseInsurance()  {
        insuranceDrop.isHidden = !insuranceDrop.isHidden
    }
    
    @objc func handleAgree(sender:UIButton)  {
        sender.isSelected = !sender.isSelected
    }
    
   @objc func handleChoose()  {
        handleChooseHours?()
    }
    
    @objc  func handleOpenLocation()  {
           handlerChooseLocation?()
       }
    
    @objc func handleDelvieryCheck(sender:UISwitch)  {
        sender.isOn = !sender.isOn
    }
}


