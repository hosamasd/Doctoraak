//
//  CustomCalenderView.swift
//  Doctoraak
//
//  Created by hosam on 6/17/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH
import SkyFloatingLabelTextField
import iOSDropDown
import SDWebImage
import UIMultiPicker

class CustomPharamacyProfileView: CustomBaseView {
    
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116").withRenderingMode(.alwaysOriginal))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: MOLHLanguage.isRTLLanguage() ? #imageLiteral(resourceName: "left-arrow") : #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var titleLabel = UILabel(text: "Profile", font: .systemFont(ofSize: 35), textColor: .white)
    
    lazy var doctorProfileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
        i.constrainWidth(constant: 100)
        i.constrainHeight(constant: 100)
        i.layer.cornerRadius = 50
        i.clipsToBounds = true
        return i
    }()
    lazy var doctorEditProfileImageView: UIImageView = {
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
    lazy var addressMainView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [addressLabel])
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenLocation)))
        v.hstack(addressLabel).withMargins(.init(top: 0, left: 16, bottom: 0, right: 8))
        return v
    }()
    lazy var addressLabel = UILabel(text: "Address", font: .systemFont(ofSize: 16), textColor: .lightGray,numberOfLines: 0)
    lazy var deliverySwitch:UISwitch = {
        let s = UISwitch()
        s.onTintColor = #colorLiteral(red: 0.3896943331, green: 0, blue: 0.8117204905, alpha: 1)
        s.isOn = true
        s.addTarget(self, action: #selector(handleDelvieryCheck), for: .valueChanged)
        return s
    }()
    
    lazy var deliveryView = makeMainSubViewWithAppendView(vv: [deliveryLabel,deliverySwitch])
    lazy var mainDrop3View:UIView =  {
        let l = makeMainSubViewWithAppendView(vv: [doenImage,insuracneText])
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseInsurance)))
        l.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        return l
    }()
    lazy var deliveryLabel = UILabel(text: "Delivery ?", font: .systemFont(ofSize: 20), textColor: .lightGray)
    lazy var mainDropView:UIView =  makeMainSubViewWithAppendView(vv: [cityDrop])
    lazy var cityDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.arrowSize = 20
        i.placeholder = "City".localized
        i.didSelect { (txt, index, _) in
            self.getAreaAccordingToCityId(index: index)
            
            self.edirProfileViewModel.city = self.cityIDSArray[index]//index+1
            
        }
        return i
    }()
    lazy var mainDrop2View:UIView = makeMainSubViewWithAppendView(vv: [areaDrop])
    lazy var areaDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.arrowSize = 20
        
        i.placeholder = "Area".localized
        i.didSelect { (txt, index, _) in
            self.edirProfileViewModel.area = self.areaIDSArray[index]//index+1
        }
        return i
    }()
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
    lazy var doenImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-6"))
        i.constrainWidth(constant: 50)
        //        i.constrainHeight(constant: 50)
        return i
    }()
    lazy var insuracneText = UILabel(text: "choose insurance", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .left,numberOfLines: 0)
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
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save".localized, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        //                button.isEnabled = false
        return button
    }()
    
    let edirProfileViewModel = EdirProfileViewModel()
    var insuracneArray = ["one","two","three","sdfdsfsd"]
    var handleChooseHours:(()->Void)?
    var handlerChooseLocation:(()->Void)?
    var insuranceStringArray = [String]()
    var insuranceNumberArray = [Int]()
    var insuranceSelectedNumbersArray = [Int]()
    
    var cityArray = [String]() //["one","two","three","sdfdsfsd"]
    var areaArray = [String]()
    
    var cityIDSArray = [Int]() //["one","two","three","sdfdsfsd"]
    var areaIDSArray = [Int]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientInSenderAndRemoveOther(sender: nextButton)
    }
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          fetchData()
          addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelHided)))
      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    override func setupViews() {
        [titleLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
    
        
        [mobileNumberTextField,emailTextField].forEach({$0.isUserInteractionEnabled=false})
        
    
        
        let subView = UIView(backgroundColor: .clear)
               subView.addSubViews(views: userProfileImage,userEditProfileImageView)
               subView.constrainWidth(constant: 100)
               subView.constrainHeight(constant: 100)
               userEditProfileImageView.anchor(top: nil, leading: nil, bottom: userProfileImage.bottomAnchor, trailing: userProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
               
               let textStack = getStack(views: fullNameTextField,mobileNumberTextField,emailTextField,addressMainView,mainDropView,mainDrop2View,mainDrop3View, spacing: 16, distribution: .fillEqually, axis: .vertical)
               
               deliveryView.hstack(deliveryLabel,deliverySwitch).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
               mainDropView.hstack(cityDrop).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
               mainDrop2View.hstack(areaDrop).withMargins(.init(top: 16, left: 16, bottom: 0, right: 16))
               
               
               addSubViews(views: LogoImage,backImage,titleLabel,subView,textStack,workingHourView,deliveryView,insuranceDrop,nextButton)
               
               NSLayoutConstraint.activate([
                   subView.centerXAnchor.constraint(equalTo: centerXAnchor)
               ])
        
        if MOLHLanguage.isRTLLanguage() {
                   LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
               }else {
                   
                   LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
               }
               
//               LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
               subView.anchor(top: LogoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 50, left: 0, bottom: 0, right: 0))
               backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
               titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
               
               textStack.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
               insuranceDrop.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
               //        genderStack.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
               workingHourView.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
               deliveryView.anchor(top: workingHourView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
               
               
               
               nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    
    func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int],insuranceNameArray:[String],insuranceNumberArray:[Int])  {
        self.cityArray = sr
        self.areaArray = dr
        self.cityIDSArray = sid
        areaIDSArray = did
        self.insuranceStringArray = insuranceNameArray
        self.insuranceNumberArray = insuranceNumberArray
        self.insuracneArray=insuranceNameArray
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        if isArabic {
            
            
            if let insuranceNameArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameARArray) as? [String],let insuranceIdArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int], let cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String] , let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int]  {
                
                putDataInDrops(sr: cityArray, sid: cityIds, dr: degreeNames, did:degreeIds , insuranceNameArray: insuranceNameArray, insuranceNumberArray: insuranceIdArray)
                
                
            }
        }else {
            if let insuranceNameArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameArray) as? [String],let insuranceIdArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int], let cityArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String] , let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int]  {
                putDataInDrops(sr: cityArray, sid: cityIds, dr: degreeNames, did:degreeIds , insuranceNameArray: insuranceNameArray, insuranceNumberArray: insuranceIdArray)
                
            }
        }
        self.insuranceDrop.options = insuranceStringArray
        self.cityDrop.optionArray = cityArray
        self.areaDrop.optionArray = areaArray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    fileprivate func fetchData()  {
        
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
    }
    
    func putOtherData(_ patient:PharamacyModel) {
        //            edirProfileViewModel.name=patient.name
        //            edirProfileViewModel.email=patient.email
        //            edirProfileViewModel.birthday=patient.birthdate
        //            edirProfileViewModel.male=patient.gender
        //            edirProfileViewModel.address=patient.address
        //            edirProfileViewModel.user_id=patient.id
        //            edirProfileViewModel.api_token=patient.apiToken
        //            edirProfileViewModel.image=doctorEditProfileImageView.image ?? UIImage()
        //            edirProfileViewModel.isPhotoEdit=false
        //            edirProfileViewModel.phone=patient.phone
    }
    
    func createTexts(type:UIKeyboardType,placeholder:String,title:String,userInteraction:Bool) -> SkyFloatingLabelTextField {
        let t = SkyFloatingLabelTextField()
        t.keyboardType = UIKeyboardType.default
        t.placeholder = placeholder
        t.titleColor = .black
        t.title = title
        t.placeholderColor = .black
        t.lineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.selectedLineColor = #colorLiteral(red: 0.2641228139, green: 0.9383022785, blue: 0.9660391212, alpha: 1)
        t.errorColor = UIColor.red
        t.isUserInteractionEnabled = userInteraction
        t.constrainHeight(constant: 60)
        return t
    }
    
    fileprivate func getAreaAccordingToCityId(index:Int)  {
        areaIDSArray.removeAll()
        areaArray.removeAll()
        
        if let  cityIdArra = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let areaIdArra = userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int],let areaIdArray = userDefaults.value(forKey: UserDefaultsConstants.areaCityIdsArrays) as? [Int],let areasStringArray =  MOLHLanguage.isRTLLanguage() ? userDefaults.value(forKey: UserDefaultsConstants.areaNameARArray) as? [String] : userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String]  {
            //            self.areaNumberArray = cityIdArra
            
            let areas = self.cityIDSArray[index]
            
            let areasFilteredArray = areaIdArray.indexes(of: areas)
            areasFilteredArray.forEach { (s) in
                areaIDSArray.append(areaIdArra[s])
            }
            areasFilteredArray.forEach { (indexx) in
                
                
                areaArray.append( areasStringArray[indexx])
                
            }
            
            self.areaDrop.optionArray = areaArray
            
            DispatchQueue.main.async {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func handleChoose()  {
        handleChooseHours?()
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == fullNameTextField {
                if  texts.count < 3    {
                    floatingLabelTextField.errorMessage = "Invalid   Name".localized
                    edirProfileViewModel.name = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    edirProfileViewModel.name = texts
                }
                
                
            }
            
        }
    }
    
    @objc func handleDelvieryCheck(sender:UISwitch)  {
        sender.isOn = !sender.isOn
        edirProfileViewModel.delivery = sender.isOn ? 1 : 0
    }
    
    @objc  func handleOpenLocation()  {
        handlerChooseLocation?()
    }
    
    var iiii = ""
    var de = ""
    
    @objc func handleHidePicker(sender:UIMultiPicker)  {
        sender.selectedIndexes.forEach { (i) in
            insuranceSelectedNumbersArray.append(i+1)
            de += insuracneArray[i] + ","
        }
        iiii = de
        insuracneText.text = iiii
        let ss =  insuranceSelectedNumbersArray.uniques
        edirProfileViewModel.insurance = ss
        
        de = ""
    }
    
    @objc func handelHided()  {
           insuranceDrop.isHidden = true
           
       }
    
    @objc func handleOpenCloseInsurance()  {
           insuranceDrop.isHidden = !insuranceDrop.isHidden
       }
}
