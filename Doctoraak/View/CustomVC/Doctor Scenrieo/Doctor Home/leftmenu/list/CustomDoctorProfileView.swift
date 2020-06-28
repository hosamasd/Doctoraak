//
//  CustomDoctorProfileView.swift
//  Doctoraak
//
//  Created by hosam on 6/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import iOSDropDown
import UIMultiPicker
import SkyFloatingLabelTextField
import MOLH

class CustomDoctorProfileView: CustomBaseView {
    
    var doc:DoctorModel?{
        didSet{
            guard let phy = doc else { return  }
            fullNameTextField.text = MOLHLanguage.isRTLLanguage() ? phy.nameAr ?? phy.name : phy.name
            mobileNumberTextField.text = phy.phone2 ?? phy.phone
            emailTextField.text = phy.email
            let degree = phy.degreeID ?? 1
            degreeDrop.selectedIndex = degree  - 1
            degreeDrop.text = getDegreeFromIndex(degree)
            let spy = phy.specializationID
            specializationDrop.selectedIndex = spy-1
            specializationDrop.text = getSpecizalitionFromIndex(spy)
            cvLabel.text =  phy.cv
            let urlstring = phy.photo
            guard let url = URL(string: urlstring) else { return  }
            //            getIncuracneNames(dd: phy.insuranceCompany)
            doctorProfileImage.sd_setImage(with: url)
            
            putOtherData(phy)
            DispatchQueue.main.async {
                self.addGradientInSenderAndRemoveOther(sender: phy.gender == "male" ? self.boyButton : self.girlButton)
                
            }
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
    lazy var mobileSecondNumberTextField = createMainTextFields(place: " phone2",type: .numberPad)
    
    lazy var emailTextField = createMainTextFields(place: "enter email",type: .emailAddress)
    lazy var titleTextField = createMainTextFields(place: "title".localized)
    
    
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
    
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [specializationDrop])
    
    lazy var specializationDrop:DropDown = {
        let i = returnMainDropDown( plcae:  "Specialization".localized)
        i.isUserInteractionEnabled = false
        return i
    }()
    lazy var mainDrop2View = makeMainSubViewWithAppendView(vv: [degreeDrop])
    
    lazy var degreeDrop:DropDown = {
        let i = returnMainDropDown( plcae:  "Degree".localized)
        i.didSelect { (txt, index, _) in
            self.edirProfileViewModel.degreeId =  self.degreeIDSArray[index]//index+1
        }
        return i
    }()
    lazy var mainDrop3View:UIView =  {
        
        let l = makeMainSubViewWithAppendView(vv: [doenImage,insuracneText])
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseInsurance)))
        l.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        return l
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
    lazy var cvView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [cvLabel])
        v.hstack(cvLabel,cvImage).padLeft(16)
        return v
    }()
    lazy var cvLabel = UILabel(text: "cv.pdf".localized, font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var cvImage:UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "Group 4142-2"))
        //        v.contentMode = .scaleToFill
        v.contentMode = .scaleAspectFit
        
        v.constrainWidth(constant: 50)
        return v
    }()
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
    lazy var boyButton:UIButton = createMainButtonsForGenderss(title: "Male",img:#imageLiteral(resourceName: "toilet"), bg: true)
    lazy var girlButton:UIButton = createMainButtonsForGenderss(title: "Female",img:#imageLiteral(resourceName: "toile11t"), bg: true)
    
    let edirProfileViewModel = EdirDoctorProfileViewModel()
    var insuracneArray = ["one","two","three","sdfdsfsd"]
    var insuranceStringArray = [String]()
    var insuranceNumberArray = [Int]()
    var insuranceSelectedNumbersArray = [Int]()
    
    var degreeIDSArray = [Int]()
    
    var degreeArray = [String]() //["one","two","three","sdfdsfsd"]
    var specilizationArray = [String]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientInSenderAndRemoveOther(sender: nextButton)
        addGradientInSenderAndRemoveOther(sender: boyButton)
        
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
        [mobileSecondNumberTextField,titleTextField,emailTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .valueChanged)})
        let genderStack = getStack(views: boyButton,girlButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        [titleLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        
        [mobileNumberTextField].forEach({$0.isUserInteractionEnabled=false})
        
        
        
        let subView = UIView(backgroundColor: .clear)
        subView.addSubViews(views: userProfileImage,userEditProfileImageView)
        subView.constrainWidth(constant: 100)
        subView.constrainHeight(constant: 100)
        userEditProfileImageView.anchor(top: nil, leading: nil, bottom: userProfileImage.bottomAnchor, trailing: userProfileImage.trailingAnchor,padding: .init(top: 0, left:0 , bottom:10, right: 10))
        
        let textStack = getStack(views: fullNameTextField,mobileNumberTextField,mobileSecondNumberTextField,emailTextField,genderStack,mainDropView,mainDrop2View,mainDrop3View,titleTextField,cvView,mainDrop3View, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        mainDropView.hstack(degreeDrop).withMargins(.init(top: 16, left: 16, bottom: 8, right: 16))
        mainDrop2View.hstack(specializationDrop).withMargins(.init(top: 16, left: 16, bottom: 0, right: 16))
        
        
        addSubViews(views: LogoImage,backImage,titleLabel,subView,textStack,nextButton,insuranceDrop)
        
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
        
        nextButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
        
    }
    
    
    func getIncuracneNames(dd:[InsurcaneCompanyModel])  {
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
    
    
    func putDataInDrops(dr:[String],did:[Int],insuranceNameArray:[String],insuranceNumberArray:[Int])  {
        self.degreeArray = dr
        self.degreeIDSArray = did
        
        self.insuranceStringArray = insuranceNameArray
        self.insuranceNumberArray = insuranceNumberArray
        self.insuracneArray=insuranceNameArray
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        if isArabic {
            
            
            if let insuranceNameArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameARArray) as? [String],let insuranceIdArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int], let cityArray = userDefaults.value(forKey: UserDefaultsConstants.degreeNameARArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.degreeIdArray) as? [Int]  {
                
                putDataInDrops( dr: cityArray, did:cityIds , insuranceNameArray: insuranceNameArray, insuranceNumberArray: insuranceIdArray)
                
                
            }
        }else {
            if let insuranceNameArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameArray) as? [String],let insuranceIdArray = userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int], let cityArray = userDefaults.value(forKey: UserDefaultsConstants.degreeNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.degreeIdArray) as? [Int]{
                putDataInDrops( dr: cityArray, did:cityIds , insuranceNameArray: insuranceNameArray, insuranceNumberArray: insuranceIdArray)
                
            }
        }
        self.insuranceDrop.options = insuranceStringArray
        self.degreeDrop.optionArray = degreeArray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    fileprivate func fetchData()  {
        
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
    }
    
    func putOtherData(_ phy:DoctorModel) {
        edirProfileViewModel.image=doctorProfileImage.image
        edirProfileViewModel.apiToekn = phy.apiToken
        edirProfileViewModel.user_Id = phy.id
        edirProfileViewModel.name = phy.name
        edirProfileViewModel.degreeId=phy.degreeID ?? 1
        edirProfileViewModel.email=phy.email
        if phy.email != nil {
            self.emailTextField.isUserInteractionEnabled = false
        }else {
            self.emailTextField.isUserInteractionEnabled = true
            
        }
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
    
    func getDegreeFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        if MOLHLanguage.isRTLLanguage() {
            
            if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.degreeNameARArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.degreeIdArray) as? [Int]{
                
                citName = cityArray
                cityId = cityIds
                
                
                
            }}else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.degreeNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.degreeIdArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        
        return citName[ff - 1 ]
    }
    
    
    
    func getAreassFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        
        if MOLHLanguage.isRTLLanguage() {
            
            
            
            if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.areaNameARArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int]{
                
                citName = cityArray
                cityId = cityIds
                
                
                
            }}else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.areaNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.areaIdArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        
        return citName[ff - 1 ]
    }
    
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == titleTextField {
                if  texts.count < 3    {
                    floatingLabelTextField.errorMessage = "Invalid   title".localized
                    edirProfileViewModel.title = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    edirProfileViewModel.title = texts
                }
            }else if text == mobileSecondNumberTextField {
                if !texts.isValidPhoneNumber {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    edirProfileViewModel.name = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    edirProfileViewModel.phone2 = texts
                }
            }else {
                if !texts.isValidEmail {
                    floatingLabelTextField.errorMessage = "Invalid   email".localized
                    edirProfileViewModel.email = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    edirProfileViewModel.email = texts
                }
            }
        }
        
        
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
