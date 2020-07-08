//
//  CustomCecondRegisterView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import iOSDropDown
import UIMultiPicker
import SkyFloatingLabelTextField
import MOLH

class CustomSecondRegisterView: CustomBaseView {
    
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
    
    lazy var titleLabel = UILabel(text: "Welcome".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Create account".localized, font: .systemFont(ofSize: 18), textColor: .white)
    
    
    lazy var cvView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [cvLabel])
        if MOLHLanguage.isRTLLanguage() {
            v.hstack(cvLabel,cvImage).padRight(16)
        }else {
            v.hstack(cvLabel,cvImage).padLeft(16)
        }
        return v
    }()
    lazy var cvLabel = UILabel(text: "cv.pdf (Optional)".localized, font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var cvImage:UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "Group 4142-2"))
        //        v.contentMode = .scaleToFill
        v.contentMode = .scaleAspectFit
        
        v.constrainWidth(constant: 50)
        return v
    }()
    lazy var discriptionTextField = createMainTextFields(place: "Description (Optional)".localized)
    lazy var mainDropView = makeMainSubViewWithAppendView(vv: [specializationDrop])
    
    lazy var specializationDrop:DropDown = {
        let i = returnMainDropDown(plcae: "Specialization".localized)
        i.didSelect { (txt, index, _) in
            self.doctorSecondRegisterViewModel.specialization_id = self.specificationIDSArray[index]//index+1
        }
        return i
    }()
    lazy var mainDrop2View = makeMainSubViewWithAppendView(vv: [degreeDrop])
    
    lazy var degreeDrop:DropDown = {
        let i = returnMainDropDown(plcae:  "Degree".localized)
        i.didSelect { (txt, index, _) in
            self.doctorSecondRegisterViewModel.degree_id =  self.degreeIDSArray[index]//index+1
        }
        return i
    }()
    lazy var mainDrop3View:UIView =  {
        
        let l = makeMainSubViewWithAppendView(vv: [doenImage,insuracneText])
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseInsurance)))
        if MOLHLanguage.isRTLLanguage() {
            l.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 0, bottom: 0, right: 16))
        }else {
            l.hstack(insuracneText,doenImage).withMargins(.init(top: 0, left: 16, bottom: 0, right: 0))
        }
        return l
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
    lazy var acceptButton:UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "Rectangle 1712"), for: .normal)
        b.setImage(#imageLiteral(resourceName: "DropDown_Checked"), for: .selected)
        b.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        return b
    }()
    
    lazy var acceptLabel = UILabel(text: " Accept ".localized, font: .systemFont(ofSize: 16), textColor: .black)
    lazy var createAccountButton:UIButton = {
        let b = UIButton()
        b.setTitle("Terms and Conditions".localized, for: .normal)
        b.setTitleColor(#colorLiteral(red: 0.5999417901, green: 0.821531117, blue: 0.8872718215, alpha: 1), for: .normal)
        b.underline()
        b.constrainHeight(constant: 50)
        return b
    }()
    lazy var titleTextField = createMainTextFields(place: "enter title (Optional)".localized,type: .default)
    
    
    
    lazy var signUpButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitle("Sign up".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    //    var index = 0
    var iiii = ""
    var de = ""
    let doctorSecondRegisterViewModel = DoctorSecondRegisterViewModel()
    
    var insuracneArray = [String]() //["one","two","three","sdfdsfsd"]
    var degreeArray = [String]()
    var specificationArray = [String]()
    
    var insuranceSelectedNumbersArray = [Int]()
    
    var insuracneIDSArray = [Int]() //["one","two","three","sdfdsfsd"]
    var degreeIDSArray = [Int]()
    var specificationIDSArray = [Int]()
    
    var index:Int!{didSet{doctorSecondRegisterViewModel.index=index}}
    var name:String!{didSet{doctorSecondRegisterViewModel.name=name}}
    var email:String?{didSet{doctorSecondRegisterViewModel.email=email}}
    var mobile:String!{didSet{doctorSecondRegisterViewModel.phone=mobile}}
    var passowrd:String!{didSet{doctorSecondRegisterViewModel.password=passowrd}}
    var male:String!{didSet{doctorSecondRegisterViewModel.male=male}}
    var photo:UIImage!{didSet{doctorSecondRegisterViewModel.image=photo}}
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        putData()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelHided)))
        
    }
    
    func putData()  {
        fetchEnglishData(isArabic: MOLHLanguage.isRTLLanguage())
        
    }
    
    func putDataInDrops(sr:[String],sid:[Int],dr:[String],did:[Int],ir:[String],iid:[Int])  {
        self.specificationArray = sr
        self.degreeArray = dr
        self.insuracneArray = ir
        self.insuracneIDSArray = iid
        specificationIDSArray = sid
        degreeIDSArray = did
        
    }
    
    fileprivate func fetchEnglishData(isArabic:Bool) {
        
        if isArabic {
            
            
            if let specificationsArray = userDefaults.value(forKey: UserDefaultsConstants.specificationNameARArray) as? [String],let specificationIds = userDefaults.value(forKey: UserDefaultsConstants.specificationIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.degreeNameARArray) as? [String], let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.degreeIdArray) as? [Int],
                let insuracneNames = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameARArray) as? [String], let insuranceIds =  userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int] {
                putDataInDrops(sr: specificationsArray, sid: specificationIds, dr: degreeNames, did: degreeIds, ir: insuracneNames, iid: insuranceIds)
                
            }
        }else {
            if let specificationsArray = userDefaults.value(forKey: UserDefaultsConstants.specificationNameArray) as? [String],let specificationIds = userDefaults.value(forKey: UserDefaultsConstants.specificationIdArray) as? [Int],let degreeNames = userDefaults.value(forKey: UserDefaultsConstants.degreeNameArray) as? [String], let degreeIds =  userDefaults.value(forKey: UserDefaultsConstants.degreeIdArray) as? [Int],
                let insuracneNames = userDefaults.value(forKey: UserDefaultsConstants.insuranceNameArray) as? [String], let insuranceIds =  userDefaults.value(forKey: UserDefaultsConstants.insuranceIdArray) as? [Int] {
                putDataInDrops(sr: specificationsArray, sid: specificationIds, dr: degreeNames, did: degreeIds, ir: insuracneNames, iid: insuranceIds)
            }
        }
        self.specializationDrop.optionArray = self.specificationArray
        self.degreeDrop.optionArray = self.degreeArray
        self.insuranceDrop.options = insuracneArray
        
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        [titleLabel,soonLabel,cvLabel,insuracneText].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        [discriptionTextField,titleTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        //        [ descriptionTextField].forEach({$0.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)})
        
        let bottomStack = getStack(views: UIView(),acceptButton,acceptLabel,createAccountButton,UIView(), spacing: 0, distribution: .fillProportionally, axis: .horizontal)
        let textStack = getStack(views: mainDropView,mainDrop2View,titleTextField,discriptionTextField,cvView,mainDrop3View, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,textStack,bottomStack,insuranceDrop,signUpButton)
        [specializationDrop,degreeDrop].forEach({$0.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))})
        
        //       [specializationDrop,degreeDrop,insuranceDrop].forEach({$0.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))})
        
        NSLayoutConstraint.activate([
            bottomStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        if MOLHLanguage.isRTLLanguage() {
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -48))
        }else {
            
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        }
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        textStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 16, right: 32))
        
        insuranceDrop.anchor(top: textStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
        //        bottomStack.anchor(top: textStack.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        bottomStack.anchor(top: textStack.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        signUpButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 32, left: 32, bottom: 16, right: 32))
    }
    
    
    @objc func handleHidePicker(sender:UIMultiPicker)  {
        sender.selectedIndexes.forEach { (i) in
            insuranceSelectedNumbersArray.append(i+1)
            de += insuracneArray[i] + ","
        }
        iiii = de
        insuracneText.text = iiii == "" ? "Choose Insurancs".localized : iiii
        let ss =  insuranceSelectedNumbersArray.uniques
        doctorSecondRegisterViewModel.insurance = ss
        
        de = ""
    }
    
    
    @objc func handleOpenCloseInsurance()  {
        insuranceDrop.isHidden = !insuranceDrop.isHidden
    }
    
    @objc func handleUpload()  {
        print(965)
    }
    
    @objc func handleAgree(sender:UIButton)  {
        sender.isSelected = !sender.isSelected
        doctorSecondRegisterViewModel.isAccept = !(doctorSecondRegisterViewModel.isAccept ?? false)
    }
    
    
    @objc func textFieldDidChange(text: UITextField)  {
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == discriptionTextField {
                if  texts.count < 3    {
                    floatingLabelTextField.errorMessage = "Invalid   Description".localized
                    doctorSecondRegisterViewModel.description = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorSecondRegisterViewModel.description = texts
                }
            }else {
                if  texts.count < 2    {
                    floatingLabelTextField.errorMessage = "Invalid   Title".localized
                    doctorSecondRegisterViewModel.title = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    doctorSecondRegisterViewModel.title = texts
                }
            }
        }
    }
    @objc func handelHided()  {
        insuranceDrop.isHidden = true
        endEditing(true)
    }
}
