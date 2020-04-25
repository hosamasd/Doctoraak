//
//  CustomMainsClinicWorkingHoursView.swift
//  Doctoraak
//
//  Created by hosam on 4/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomMainClinicWorkingHoursView: CustomBaseView {
    
    
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
    
    
  
    lazy var sunButton = createButtons(title: "Sun",color: .white,tags: 2)
    lazy var first1TextField = createHoursButtons(tags: 1)
    lazy var first2TextField = createHoursButtons(tags: 11)
    
    lazy var monButton = createButtons(title: "Mon",color: .black,tags: 3)
    lazy var second1TextField = createHoursButtons(tags: 2)
    lazy var second2TextField = createHoursButtons(tags: 22)
    
    lazy var tuesButton = createButtons(title: "Tue",color: .black,tags: 4)
    lazy var third1TextField = createHoursButtons(tags: 3)
    lazy var third2TextField = createHoursButtons(tags: 33)
    
    lazy var wedButton = createButtons(title: "Wed",color: .black,tags: 5)
    lazy var forth1TextField = createHoursButtons(tags: 4)
    lazy var forth2TextField = createHoursButtons(tags: 44)
    
    lazy var thuButton = createButtons(title: "Thu",color: .black,tags: 6)
    lazy var fifth1TextField = createHoursButtons(tags: 5)
    lazy var fifth2TextField = createHoursButtons(tags: 55)
    
    lazy var friButton = createButtons(title: "Fri",color: .black,tags: 7)
    lazy var sexth1TextField = createHoursButtons(tags: 6)
    lazy var sexth2TextField = createHoursButtons(tags: 66)
    
    lazy var satButton = createButtons(title: "Sat",color: .black,tags: 1)
    lazy var seventh1TextField = createHoursButtons(tags: 7)
    lazy var seventh2TextField = createHoursButtons(tags: 77)
    
    lazy var mainFirstSecondStack:UIStackView = {
        let text1Stack = getStack(views: first1TextField,first2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let text2Stack = getStack(views: second1TextField,second2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let text3Stack = getStack(views: third1TextField,third2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text4Stack = getStack(views: forth1TextField,forth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text5Stack = getStack(views: fifth1TextField,fifth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text6Stack = getStack(views: sexth1TextField,sexth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text7Stack = getStack(views: seventh1TextField,seventh2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let v = getStack(views: text2Stack,text3Stack,text4Stack,text5Stack,text6Stack,text7Stack,text1Stack, spacing: 16, distribution: .fillEqually, axis: .vertical)
        return v
    }()
    lazy var buttonDaysStack:UIStackView = {
        let v = getStack(views: sunButton,monButton,tuesButton,wedButton,thuButton,friButton,satButton, spacing: 16, distribution: .fillEqually, axis: .vertical)
        return v
    }()
    lazy var totalStack:UIStackView = {
        let v = getStack(views: buttonDaysStack,mainFirstSecondStack,mainSecondStack, spacing: 48, distribution: .fillProportionally, axis: .horizontal )
        return v
    }()
    lazy var mainSecondStack:CustomMainCliView = {
        let v = CustomMainCliView()
        v.isHide(true)
        return v
    }()
    
    lazy var doneButton:UIButton = {
        let button = CustomSiftButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //                button.backgroundColor = ColorConstants.disabledButtonsGray
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
        //                button.isEnabled = false
        return button
    }()
    
    var handleShowPickers:((UIButton)->Void)?
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        if sunButton.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: sunButton)
            sunButton.setTitleColor(.white, for: .normal)
        }
        
        putDefualValues()
    }
    
    func getSavedData()  {
        if let f1 = userDefaults.string(forKey: UserDefaultsConstants.first1),let f11 = userDefaults.string(forKey: UserDefaultsConstants.first11),let f12 = userDefaults.string(forKey: UserDefaultsConstants.first211),let f112 = userDefaults.string(forKey: UserDefaultsConstants.first2111),
            let f2 = userDefaults.string(forKey: UserDefaultsConstants.first2),let f21 = userDefaults.string(forKey: UserDefaultsConstants.first21),let f221 = userDefaults.string(forKey: UserDefaultsConstants.first22),let f222 = userDefaults.string(forKey: UserDefaultsConstants.first221),
            let f3 = userDefaults.string(forKey: UserDefaultsConstants.first3),let f31 = userDefaults.string(forKey: UserDefaultsConstants.first31),let f23 = userDefaults.string(forKey: UserDefaultsConstants.first23),let f231 = userDefaults.string(forKey: UserDefaultsConstants.first231),
            let f4 = userDefaults.string(forKey: UserDefaultsConstants.first4),let f41 = userDefaults.string(forKey: UserDefaultsConstants.first41),let f24 = userDefaults.string(forKey: UserDefaultsConstants.first24),let f241 = userDefaults.string(forKey: UserDefaultsConstants.first241),
            let f5 = userDefaults.string(forKey: UserDefaultsConstants.first5),let f51 = userDefaults.string(forKey: UserDefaultsConstants.first51),let f25 = userDefaults.string(forKey: UserDefaultsConstants.first25),let f251 = userDefaults.string(forKey: UserDefaultsConstants.first251),
            let f6 = userDefaults.string(forKey: UserDefaultsConstants.first6),let f61 = userDefaults.string(forKey: UserDefaultsConstants.first61),let f26 = userDefaults.string(forKey: UserDefaultsConstants.first26),let f261 = userDefaults.string(forKey: UserDefaultsConstants.first261),
            
            let f7 = userDefaults.string(forKey: UserDefaultsConstants.first7),let f71 = userDefaults.string(forKey: UserDefaultsConstants.first71),let f27 = userDefaults.string(forKey: UserDefaultsConstants.first27),let f271 = userDefaults.string(forKey: UserDefaultsConstants.first271)
            
            
            
        {
            first1TextField.setTitle(f1, for: .normal)
            first2TextField.setTitle(f11, for: .normal)
            mainSecondStack.first1TextField.setTitle(f12, for: .normal)
            mainSecondStack.first1TextField.setTitle(f112, for: .normal)
            
            second1TextField.setTitle(f2, for: .normal)
            second2TextField.setTitle(f21, for: .normal)
            mainSecondStack.second1TextField.setTitle(f221, for: .normal)
            mainSecondStack.second2TextField.setTitle(f222, for: .normal)
            
            third1TextField.setTitle(f3, for: .normal)
            third2TextField.setTitle(f31, for: .normal)
            mainSecondStack.third1TextField.setTitle(f23, for: .normal)
            mainSecondStack.third2TextField.setTitle(f231, for: .normal)
            
            forth1TextField.setTitle(f4, for: .normal)
            forth2TextField.setTitle(f41, for: .normal)
            mainSecondStack.forth1TextField.setTitle(f24, for: .normal)
            mainSecondStack.forth2TextField.setTitle(f241, for: .normal)
            
            fifth1TextField.setTitle(f5, for: .normal)
            fifth2TextField.setTitle(f51, for: .normal)
            mainSecondStack.fifth1TextField.setTitle(f25, for: .normal)
            mainSecondStack.fifth2TextField.setTitle(f251, for: .normal)
            
            sexth1TextField.setTitle(f6, for: .normal)
            sexth2TextField.setTitle(f61, for: .normal)
            mainSecondStack.sexth1TextField.setTitle(f26, for: .normal)
            mainSecondStack.sexth2TextField.setTitle(f261, for: .normal)
            
            seventh1TextField.setTitle(f7, for: .normal)
            seventh2TextField.setTitle(f71, for: .normal)
            mainSecondStack.seventh1TextField.setTitle(f27, for: .normal)
            mainSecondStack.seventh2TextField.setTitle(f271, for: .normal)
            
            
        }
    }
    
    func putDefualValues()  {
    }
    
    override func setupViews() {
        //        shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
        //               shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
        [first2TextField,first1TextField,second1TextField,second2TextField,third1TextField,third2TextField,forth1TextField,forth2TextField,fifth1TextField,fifth2TextField,sexth1TextField,sexth2TextField,seventh2TextField,seventh1TextField,
         mainSecondStack.first1TextField,mainSecondStack.first2TextField,mainSecondStack.second1TextField,mainSecondStack.second2TextField,mainSecondStack.third1TextField,mainSecondStack.third2TextField,mainSecondStack.forth1TextField,mainSecondStack.forth2TextField,mainSecondStack.fifth1TextField,mainSecondStack.fifth2TextField,mainSecondStack.sexth1TextField,mainSecondStack.sexth2TextField,mainSecondStack.seventh2TextField,mainSecondStack.seventh1TextField].forEach({$0
            .addTarget(self, action:#selector(handleShowPicker), for: .touchUpInside)})
        [second1TextField,second2TextField].forEach({$0.isEnabled = true})
        
        [satButton,sunButton,monButton,tuesButton,thuButton,wedButton,friButton].forEach({$0.constrainWidth(constant: 50)})
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,totalStack,doneButton)
        
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        totalStack.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 128, left: 32, bottom: 0, right: 32))
        
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
  
    func createHoursButtons(tags:Int) -> UIButton {
        let t = UIButton()
        t.layer.borderWidth = 1
        t.layer.backgroundColor = UIColor.gray.cgColor
        t.layer.cornerRadius = 16
        t.clipsToBounds = true
        t.setTitleColor(.black, for: .normal)
        t.backgroundColor = .white
        t.setTitle("00:00", for: .normal)
        t.constrainHeight(constant: 50)
        t.tag = tags
        t.isEnabled = false
        
        return t
    }
    
    func enalbes(t:UIButton...,enable:Bool? = true)   {
        t.forEach({$0.isEnabled = enable ?? true})
    }
    
    func createButtons(title:String,color:UIColor,tags : Int? = 0) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.constrainHeight(constant: 50)
        button.tag = tags ?? 0
        button.layer.cornerRadius = 25
        //        button.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        return button
    }
    
    @objc func handleShowPicker(sender:UIButton) {
        handleShowPickers?(sender)
    }
    
    @objc func tapDone()  {
        print(969)
    }
    
    
}

