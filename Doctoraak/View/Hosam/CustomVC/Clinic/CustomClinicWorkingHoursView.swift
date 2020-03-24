//
//  CustomClinicWorkingHoursView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomClinicWorkingHoursView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    
    lazy var titleLabel = UILabel(text: "Clinic", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Fill your data", font: .systemFont(ofSize: 18), textColor: .white)
    
    
    lazy var shift1Button = createButtons(title: "Shift 1",color: .white)
     lazy var shift2Button = createButtons(title: "Shift 2",color: .black)
    
    func createButtons(title:String,color:UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.constrainHeight(constant: 50)
       
        button.layer.cornerRadius = 25
        return button
    }
    
    lazy var sunButton = createButtons(title: "Sun",color: .white)
    lazy var first1TextField = createHoursTextFields()
    lazy var first2TextField = createHoursTextFields()
    
     lazy var monButton = createButtons(title: "Mon",color: .black)
    lazy var second1TextField = createHoursTextFields()
    lazy var second2TextField = createHoursTextFields()
    
     lazy var tuesButton = createButtons(title: "Tue",color: .black)
    lazy var third1TextField = createHoursTextFields()
    lazy var third2TextField = createHoursTextFields()
    
    lazy var wedButton = createButtons(title: "Wed",color: .black)
    lazy var forth1TextField = createHoursTextFields()
    lazy var forth2TextField = createHoursTextFields()
    
    lazy var thuButton = createButtons(title: "Thu",color: .black)
    lazy var fifth1TextField = createHoursTextFields()
    lazy var fifth2TextField = createHoursTextFields()
    
    lazy var friButton = createButtons(title: "Fri",color: .black)
    lazy var sexth1TextField = createHoursTextFields()
    lazy var sexth2TextField = createHoursTextFields()
    
    lazy var satButton = createButtons(title: "Sat",color: .black)
    lazy var seventh1TextField = createHoursTextFields()
    lazy var seventh2TextField = createHoursTextFields()
    
    lazy var doneButton:UIButton = {
        let button = CustomSiftButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
        return button
    }()
  

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let leftColor = #colorLiteral(red: 0.6555111408, green: 0.5125037432, blue: 0.9976704717, alpha: 1)
        let rightColor = #colorLiteral(red: 0.7503471971, green: 0.6148311496, blue: 0.9988300204, alpha: 1)
        [shift1Button,sunButton].forEach({$0.applyGradient(colors: [leftColor.cgColor, rightColor.cgColor], index: 0)})
    }
    
    override func setupViews() {
        [satButton,sunButton,monButton,tuesButton,thuButton,wedButton,friButton].forEach({$0.constrainWidth(constant: 50)})
        let ss = getStack(views: shift1Button,shift2Button, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let text1Stack = getStack(views: first1TextField,first2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let firstStack = getStack(views: sunButton,text1Stack, spacing: 32, distribution: .fill, axis: .horizontal)
        
        let text2Stack = getStack(views: second1TextField,second2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first2Stack = getStack(views: monButton,text2Stack, spacing: 32, distribution: .fill, axis: .horizontal)
       
        let text3Stack = getStack(views: third1TextField,third2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first3Stack = getStack(views: tuesButton,text3Stack, spacing: 32, distribution: .fill, axis: .horizontal)
       
        let text4Stack = getStack(views: forth1TextField,forth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first4Stack = getStack(views: wedButton,text4Stack, spacing: 32, distribution: .fill, axis: .horizontal)
        
        let text5Stack = getStack(views: fifth1TextField,fifth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first5Stack = getStack(views: thuButton,text5Stack, spacing: 32, distribution: .fill, axis: .horizontal)
       
        let text6Stack = getStack(views: sexth1TextField,sexth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first6Stack = getStack(views: friButton,text6Stack, spacing: 32, distribution: .fill, axis: .horizontal)
        
        let text7Stack = getStack(views: seventh1TextField,seventh2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        let first7Stack = getStack(views: satButton,text7Stack, spacing: 32, distribution: .fill, axis: .horizontal)
        
        let mainStack = getStack(views: firstStack,first2Stack,first3Stack,first4Stack,first5Stack,first6Stack,first7Stack, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
      
            addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,ss,mainStack,doneButton)
            
           
            LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
            backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
            titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
            soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        ss.anchor(top: soonLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 76, left: 32, bottom: 0, right: 32))

            mainStack.anchor(top: ss.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
            
            //
            doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
            
        }
    
    
}
