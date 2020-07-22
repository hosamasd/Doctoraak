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
import MapKit

class CustomPharamacyProfileView: CustomBaseView {
    
    
    
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            putPHYViewModel(phy)
            
            fullNameTextField.text = MOLHLanguage.isRTLLanguage() ? phy.nameAr ?? phy.name : phy.name
            mobileNumberTextField.text = phy.phone2 ?? phy.phone
            emailTextField.text = phy.email
            addressLabel.text = MOLHLanguage.isRTLLanguage() ? phy.addressAr ?? phy.address :  phy.address
            //            let city = getAreaAccordingToCityId(index: phy.)
            
            workingHoursLabel.text = getDays(ind: phy.workingHours).joined(separator: "-") == "" ? "No Days Chossen".localized :  getDays(ind: phy.workingHours).joined(separator: "-")
            deliverySwitch.isOn = phy.delivery.toInt() == 1 ? true : false
            let urlstring = phy.photo
            guard let url = URL(string: urlstring) else { return  }
            getIncuracneNames(dd: phy.insuranceCompany)
            doctorProfileImage.sd_setImage(with: url)
            
        }
    }
    
    
    
    var rad:RadiologyModel?{
        didSet{
            guard let phy = rad else { return  }
            putRADViewModel(phy)
            
            fullNameTextField.text = MOLHLanguage.isRTLLanguage() ? phy.nameAr ?? phy.name : phy.name
            mobileNumberTextField.text = phy.phone2 ?? phy.phone
            emailTextField.text = phy.email
            getNameANdCity(lat: phy.latt.toDouble() ?? 0.0, lng: phy.lang.toDouble() ?? 0.0)
            //            addressLabel.text = MOLHLanguage.isRTLLanguage() ? phy.ad ?? phy.address :  phy.address
            let cc = phy.city ?? 1 ;let aa = phy.area ?? 1
            
            let city = getCityFromIndex(cc)
            let area = getAreassFromIndex( aa)
            areaDrop.text = area
            areaDrop.selectedIndex = cc-1
            cityDrop.selectedIndex = aa-1
            cityDrop.text = city
            workingHoursLabel.text = getDaysRAD(ind: phy.workingHours).joined(separator: "-") == "" ? "No Days Chossen".localized :  getDaysRAD(ind: phy.workingHours).joined(separator: "-")
            deliverySwitch.isOn = phy.delivery.toInt() == 1 ? true : false
            let urlstring = phy.photo
            guard let url = URL(string: urlstring) else { return  }
            getIncuracneNames(dd: phy.insuranceCompany)
            doctorProfileImage.sd_setImage(with: url)
            
        }
    }
    
    var lab:LabModel?{
        didSet{
            guard let phy = lab else { return  }
            putLABViewModel(phy)
            
            fullNameTextField.text = MOLHLanguage.isRTLLanguage() ? phy.nameAr ?? phy.name : phy.name
            mobileNumberTextField.text = phy.phone2 ?? phy.phone
            emailTextField.text = phy.email
            getNameANdCity(lat: phy.latt.toDouble() ?? 0.0, lng: phy.lang.toDouble() ?? 0.0)
            
            let city = getCityFromIndex(phy.city ?? 1)
            let area = getAreassFromIndex( phy.area ?? 1)
            areaDrop.text = area
            areaDrop.selectedIndex = phy.area ?? 2-1
            cityDrop.selectedIndex = phy.city ?? 2-1
            cityDrop.text = city
            workingHoursLabel.text = getDaysLab(ind: phy.workingHours).joined(separator: "-") == "" ? "No Days Chossen".localized :  getDaysLab(ind: phy.workingHours).joined(separator: "-")
            deliverySwitch.isOn = phy.delivery.toInt() == 1 ? true : false
            getIncuracneNames(dd: phy.insuranceCompany)
            
            let urlstring = phy.photo
            guard let url = URL(string: urlstring) else { return  }
            doctorProfileImage.sd_setImage(with: url)
            
        }
    }
    
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
    lazy var titleLabel = UILabel(text: "Profile".localized, font: .systemFont(ofSize: 35), textColor: .white)
    
    lazy var doctorProfileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)//UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
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
    
    lazy var fullNameTextField = createMainTextFields(place: " Name".localized)
    lazy var mobileNumberTextField = createMainTextFields(place: " phone".localized,type: .numberPad)
    lazy var emailTextField = createMainTextFields(place: "enter email".localized,type: .emailAddress)
    lazy var addressMainView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [addressLabel])
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenLocation)))
        v.hstack(addressLabel).withMargins(.init(top: 0, left: 16, bottom: 0, right: 8))
        return v
    }()
    lazy var addressLabel = UILabel(text: "Address".localized, font: .systemFont(ofSize: 16), textColor: .lightGray,numberOfLines: 0)
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
        if MOLHLanguage.isRTLLanguage() {
            l.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 0, bottom: 0, right: 16))
            
        }else {
            l.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        }
        l.constrainHeight(constant: 60)
        return l
    }()
    lazy var deliveryLabel = UILabel(text: "Delivery ?".localized, font: .systemFont(ofSize: 20), textColor: .lightGray)
    lazy var mainDropView:UIView =  makeMainSubViewWithAppendView(vv: [cityDrop])
    lazy var cityDrop:DropDown = {
        let i = returnMainDropDown( plcae:  "City".localized)
        i.didSelect { (txt, index, _) in
            self.getAreaAccordingToCityId(index: index)
        }
        return i
    }()
    lazy var mainDrop2View:UIView = makeMainSubViewWithAppendView(vv: [areaDrop])
    lazy var areaDrop:DropDown = {
        let i = returnMainDropDown( plcae:  "Area".localized)
        i.didSelect { (txt, index, _) in
            //            self.edirProfileViewModel.area = self.areaIDSArray[index]//index+1
        }
        return i
    }()
    lazy var userProfileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
        i.constrainWidth(constant: 100)
        i.constrainHeight(constant: 100)
        i.layer.cornerRadius = 50
        i.layer.borderWidth=3
        i.layer.borderColor = UIColor.white.cgColor
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
    lazy var insuracneText = UILabel(text: "choose insurance".localized, font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .left,numberOfLines: 0)
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
        v.hstack(workingHoursLabel).withMargins(.init(top: 0, left: 16, bottom: 0, right: 16))
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChoose)))
        return v
    }()
    lazy var workingHoursLabel = UILabel(text: "Working Hours".localized, font: .systemFont(ofSize: 16), textColor: .lightGray,textAlignment: .left,numberOfLines: 2)
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
        [titleLabel,insuracneText,addressLabel,workingHoursLabel,deliveryLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        [fullNameTextField,emailTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        
        
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
    
    fileprivate func putLABViewModel(_ phy: LabModel) {
        edirProfileViewModel.image=userProfileImage.image
        edirProfileViewModel.apiToekn = phy.apiToken
        edirProfileViewModel.user_Id = phy.id
        edirProfileViewModel.name = phy.name
        edirProfileViewModel.delivery=phy.delivery.toInt()
        edirProfileViewModel.latt = phy.latt.toDouble()
        edirProfileViewModel.lang=phy.lang.toDouble()
        edirProfileViewModel.working_hours = getWorkingHourssLAB(ind: phy.workingHours)
    }
    
    fileprivate func putPHYViewModel(_ phy: PharamacyModel) {
        edirProfileViewModel.image=userProfileImage.image
        edirProfileViewModel.apiToekn = phy.apiToken
        edirProfileViewModel.user_Id = phy.id
        edirProfileViewModel.name = phy.name
        edirProfileViewModel.delivery=phy.delivery.toInt()
        edirProfileViewModel.latt = phy.latt?.toDouble()
        edirProfileViewModel.lang=phy.lang?.toDouble()
        edirProfileViewModel.working_hours = getWorkingHourss(ind: phy.workingHours)
    }
    
    fileprivate  func getIncuracneNames(dd:[InsurcaneCompanyModel])  {
        var sss = ""
        var aaaa = ""
        var eee = [Int]()
        
        dd.forEach { (s) in
            
            eee.append(s.id)
            sss += insuracneArray[s.id] + ","
        }
        aaaa = sss
        insuracneText.text = aaaa
        
        insuranceDrop.selectedIndexes = eee
        edirProfileViewModel.insurance=eee
        
    }
    
    
    fileprivate func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int],insuranceNameArray:[String],insuranceNumberArray:[Int])  {
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
    
    fileprivate func createTexts(type:UIKeyboardType,placeholder:String,title:String,userInteraction:Bool) -> SkyFloatingLabelTextField {
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
    
    fileprivate  func checkActiveDay(_ d:Int) -> Bool {
        return d == 1 ? true : false
    }
    
    
    fileprivate  func getDays(ind:[PharamacyWorkingHourModel])  ->[String]{
        var ss = [String]()
        ind.forEach { (s) in
            ss.append( getDaysForAll(s.active, day: s.day) ?? "")
        }
        let dd = ss.filter({$0 != "    "})
        
        return dd
        
    }
    
    fileprivate func getDaysForAll(_ ww:Int,day:Int ) ->String{
        switch day {
        case 1:
            if checkActiveDay(ww) {
                return "Sat".localized
            }
        case 2:
            if checkActiveDay(ww) {
                return "Sun".localized
            }
        case 3:
            if checkActiveDay(ww) {
                return "Mon".localized
            }
        case 4:
            if checkActiveDay(ww) {
                return "Tue".localized
            }
        case 5:
            if checkActiveDay(ww) {
                return "Wed".localized
            }
        case 6:
            if checkActiveDay(ww) {
                return "Thr".localized
            }
        default:
            if checkActiveDay(ww) {
                return "Fri".localized
            }
        }
        return "    "
    }
    
    fileprivate func getDaysLab(ind:[LabWorkingHoursModel])  ->[String]{
        var ss = [String]()
        ind.forEach { (s) in
            
            ss.append( getDaysForAll(s.active, day: s.day) )
        }
        let dd = ss.filter({$0 != "    "})
        
        return dd
    }
    
    fileprivate func getDaysRAD(ind:[RadiologyWorkingHourModel])  ->[String]{
        var ss = [String]()
        
        ind.forEach { (s) in
            ss.append( getDaysForAll(s.active, day: s.day) )
            
        }
        let dd = ss.filter({$0 != "    "})
        
        return dd
        
    }
    
    fileprivate func getWorkingHourss(ind:[PharamacyWorkingHourModel]) -> [PharamacyWorkModel]  {
        var ss = [PharamacyWorkModel]()
        ind.forEach { (v) in
            let d = PharamacyWorkModel(partFrom: v.partFrom, partTo: v.partTo, day: v.day, active: v.active)
            ss.append(d)
        }
        return ss
    }
    
    fileprivate func getWorkingHourssRAD(ind:[RadiologyWorkingHourModel]) -> [PharamacyWorkModel]  {
        var ss = [PharamacyWorkModel]()
        ind.forEach { (v) in
            let d = PharamacyWorkModel(partFrom: v.partFrom, partTo: v.partTo, day: v.day, active: v.active)
            ss.append(d)
        }
        return ss
    }
    
    fileprivate func getWorkingHourssLAB(ind:[LabWorkingHoursModel]) -> [PharamacyWorkModel]  {
        var ss = [PharamacyWorkModel]()
        ind.forEach { (v) in
            let d = PharamacyWorkModel(partFrom: v.partFrom, partTo: v.partTo, day: v.day, active: v.active)
            ss.append(d)
        }
        return ss
    }
    
    fileprivate func getNameANdCity(lat:Double,lng:Double)  {
        let location = CLLocation(latitude: lat, longitude: lng)
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.addressLabel.text = city+" - "+country
            print(city + ", " + country)  // Rio de Janeiro, Brazil
        }
    }
    
    fileprivate func putRADViewModel(_ phy: RadiologyModel) {
        edirProfileViewModel.image=userProfileImage.image
        edirProfileViewModel.apiToekn = phy.apiToken
        edirProfileViewModel.user_Id = phy.id
        edirProfileViewModel.name = phy.name
        edirProfileViewModel.delivery=phy.delivery.toInt()
        edirProfileViewModel.latt = phy.latt.toDouble()
        edirProfileViewModel.lang=phy.lang.toDouble()
        edirProfileViewModel.working_hours = getWorkingHourssRAD(ind: phy.workingHours)
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
