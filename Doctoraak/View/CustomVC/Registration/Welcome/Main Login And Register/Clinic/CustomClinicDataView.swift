//
//  CustomClinicDataView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import iOSDropDown
import MOLH
import SkyFloatingLabelTextField

class CustomClinicDataView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
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
    
    lazy var titleLabel = UILabel(text: "Clinic".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Fill your data".localized, font: .systemFont(ofSize: 18), textColor: .white)
    
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
    
    lazy var addressMainView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [addressLabel])
        //        v.addSubViews(views: addressImage,addressLabel)
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenLocation)))
        
        v.hstack(addressLabel).withMargins(.init(top: 0, left: 16, bottom: 0, right: 8))
        
        return v
    }()
    lazy var addressLabel = UILabel(text: "Address".localized, font: .systemFont(ofSize: 16), textColor: .lightGray,numberOfLines: 0)
    //    lazy var clinicAddressTextField = createMainTextFields(place: "Address")
    lazy var clinicMobileNumberTextField = createMainTextFields(place: "Clinic phone".localized,type: .numberPad)
    
    lazy var mainDropView:UIView =  makeMainSubViewWithAppendView(vv: [cityDrop])
    lazy var cityDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.arrowSize = 20
        i.placeholder = "City".localized
        i.didSelect { (txt, index, _) in
            self.getAreaAccordingToCityId(index: index)
            
            self.clinicDataViewModel.city = self.cityIDSArray[index]//index+1
            
        }
        return i
    }()
    lazy var mainDrop2View:UIView = makeMainSubViewWithAppendView(vv: [areaDrop])
    lazy var areaDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        i.arrowSize = 20
        
        i.placeholder = "Area".localized
        i.didSelect { (txt, index, _) in
            self.clinicDataViewModel.area = self.areaIDSArray[index]//index+1
        }
        return i
    }()
    lazy var feesTextField:UITextField = {
        let s = createMainTextFields(place: "Fees".localized, type: .numberPad)
        let label = UILabel(text: "EGY  ".localized, font: .systemFont(ofSize: 18), textColor: .lightGray)
        label.frame = CGRect(x: CGFloat(s.frame.size.width - 60), y: CGFloat(5), width: CGFloat(60), height: CGFloat(25))
        s.rightView = label
        s.rightViewMode = .always
        s.keyboardType = .numberPad
        
        return s
    }()
    lazy var consultationFeesTextField:UITextField = {
        let s = createMainTextFields(place: "Consultation fees".localized, type: .numberPad)
        let label = UILabel(text: "EGY  ".localized, font: .systemFont(ofSize: 18), textColor: .lightGray)
        label.frame = CGRect(x: CGFloat(s.frame.size.width - 60), y: CGFloat(5), width: CGFloat(60), height: CGFloat(25))
        s.rightView = label
        s.rightViewMode = .always
        s.keyboardType = .numberPad
        
        return s
    }()
    lazy var workingHourView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [workingHoursLabel])
        v.hstack(workingHoursLabel).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChoose)))
        return v
    }()
    lazy var workingHoursLabel = UILabel(text: "Working Hours".localized, font: .systemFont(ofSize: 16), textColor: .lightGray,numberOfLines: 0)
    
    //    lazy var clinicWorkingHoursTextField = createMainTextFields(place: "Work hours")
    lazy var waitingHoursTextField:UITextField = {
        let s = createMainTextFields(place: "Waiting hours".localized, type: .numberPad)
        let label = UILabel(text: "Time in m    ".localized, font: .systemFont(ofSize: 14), textColor: .lightGray)
        label.frame = CGRect(x: CGFloat(s.frame.size.width - 80), y: CGFloat(5), width: CGFloat(80), height: CGFloat(25))
        s.rightView = label
        s.rightViewMode = .always
        s.keyboardType = .numberPad
        return s
    }()
    lazy var doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    var index = 0
    var  doctor_id:Int = 0
    var  api_token:String = ""
    var handleChooseHours:(()->Void)?
    var handlerChooseLocation:(()->Void)?
    
    let clinicDataViewModel = ClinicDataViewModel()
    var cityArray = [String]() //["one","two","three","sdfdsfsd"]
    var areaArray = [String]()
    
    var cityIDSArray = [Int]() //["one","two","three","sdfdsfsd"]
    var areaIDSArray = [Int]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        areaIDSArray.removeAll()
        //            cityIDSArray.removeAll()
        //         areaArray.removeAll()
        //         cityArray.removeAll()
        putData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    
    func putData()  {
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
        
    }
    
    func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int])  {
        self.cityArray = sr
        self.areaArray = dr
        self.cityIDSArray = sid
        areaIDSArray = did
        
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        if isArabic {
            
            
            if let specificationsArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameARArray) as? [String],let specificationIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.areaNameARArray) as? [String], let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int] {
                putDataInDrops(sr: specificationsArray, sid: specificationIds, dr: degreeNames, did: degreeIds)
                
            }
        }else {
            if let specificationsArray = userDefaults.value(forKey: UserDefaultsConstants.cityNameArray) as? [String],let specificationIds = userDefaults.value(forKey: UserDefaultsConstants.cityIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String] , let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int]  {
                putDataInDrops(sr: specificationsArray, sid: specificationIds, dr: degreeNames, did: degreeIds)
            }
        }
        self.cityDrop.optionArray = self.cityArray
        self.areaDrop.optionArray = self.areaArray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    override func setupViews() {
        
        [ waitingHoursTextField, feesTextField,   clinicMobileNumberTextField, consultationFeesTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        
        workingHourView.hstack(workingHoursLabel).padLeft(16)
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: clinicProfileImage,clinicEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        clinicEditProfileImageView.anchor(top: nil, leading: nil, bottom: clinicProfileImage.bottomAnchor, trailing: clinicProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
        
        let textStack = getStack(views: clinicMobileNumberTextField,addressMainView,mainDropView,mainDrop2View,feesTextField,consultationFeesTextField,workingHourView,waitingHoursTextField, spacing: 16, distribution: .fillEqually, axis: .vertical)
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
    
    @objc func handleChoose()  {
        handleChooseHours?()
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        clinicDataViewModel.index = index
        clinicDataViewModel.doctor_id = doctor_id
        clinicDataViewModel.api_token = api_token
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
                
            }else  if text == feesTextField {
                if (texts.count < 1 ) {
                    floatingLabelTextField.errorMessage = "Invalid fees".localized
                    clinicDataViewModel.fees = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    clinicDataViewModel.fees = texts.toInt()
                }
            }else  if text == consultationFeesTextField {
                if (texts.count < 1 ) {
                    floatingLabelTextField.errorMessage = "Invalid consulation feez".localized
                    clinicDataViewModel.consultaionFees = nil
                }
                else {
                    
                    clinicDataViewModel.consultaionFees = texts.toInt()
                    floatingLabelTextField.errorMessage = ""
                }
                
            }else if text == waitingHoursTextField {
                if (texts.count < 1 ) {
                    floatingLabelTextField.errorMessage = "Invalid waiing".localized
                    clinicDataViewModel.waitingHours = nil
                }
                else {
                    
                    clinicDataViewModel.waitingHours = texts.toInt()
                    floatingLabelTextField.errorMessage = ""
                }
                
                
            }
        }
    }
    
    @objc  func handleOpenLocation()  {
        handlerChooseLocation?()
    }
    
}
