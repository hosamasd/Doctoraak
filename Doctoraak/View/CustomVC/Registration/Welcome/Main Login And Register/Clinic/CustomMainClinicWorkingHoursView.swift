//
//  CustomClinicWorkingHoursView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
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
    
    
    lazy var shift1Button = creatShiftBTN(title: "Shift1")
     lazy var shift2Button = creatShiftBTN(title: "Shift2")
    
    
    lazy var sunButton = createButtons(title: "Sun",color: .white,tags: 1)
    lazy var first1TextField = createHoursButtons(tags: 1)
    lazy var first2TextField = createHoursButtons(tags: 11)
    
     lazy var monButton = createButtons(title: "Mon",color: .black,tags: 2)
    lazy var second1TextField = createHoursButtons(tags: 2)
    lazy var second2TextField = createHoursButtons(tags: 22)
    
     lazy var tuesButton = createButtons(title: "Tue",color: .black,tags: 3)
    lazy var third1TextField = createHoursButtons(tags: 3)
    lazy var third2TextField = createHoursButtons(tags: 33)
    
    lazy var wedButton = createButtons(title: "Wed",color: .black,tags: 4)
    lazy var forth1TextField = createHoursButtons(tags: 4)
    lazy var forth2TextField = createHoursButtons(tags: 44)
    
    lazy var thuButton = createButtons(title: "Thu",color: .black,tags: 5)
    lazy var fifth1TextField = createHoursButtons(tags: 5)
    lazy var fifth2TextField = createHoursButtons(tags: 55)
    
    lazy var friButton = createButtons(title: "Fri",color: .black,tags: 6)
    lazy var sexth1TextField = createHoursButtons(tags: 6)
    lazy var sexth2TextField = createHoursButtons(tags: 66)
    
    lazy var satButton = createButtons(title: "Sat",color: .black,tags: 7)
    lazy var seventh1TextField = createHoursButtons(tags: 7)
    lazy var seventh2TextField = createHoursButtons(tags: 77)
    
    lazy var doneButton:UIButton = {
        let button = CustomSiftButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
//        button.isEnabled = false
        return button
    }()
  

    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shift1Button.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: shift1Button)
            shift1Button.setTitleColor(.white, for: .normal)
        }
        if sunButton.backgroundColor != nil {
                  addGradientInSenderAndRemoveOther(sender: sunButton)
                  sunButton.setTitleColor(.white, for: .normal)
              }
    }
    
    override func setupViews() {
//        shift1Button.addTarget(self, action: #selector(handle1Shift), for: .touchUpInside)
//               shift2Button.addTarget(self, action: #selector(handle2Shift), for: .touchUpInside)
       [first2TextField,first1TextField].forEach({$0.isEnabled = true})
        
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
    
    func creatShiftBTN(title:String) -> UIButton {
               let button = UIButton(type: .system)
               button.backgroundColor = ColorConstants.disabledButtonsGray
               button.setTitle(title, for: .normal)
               button.setTitleColor(.white, for: .normal)
               button.layer.cornerRadius = 16
               button.constrainHeight(constant: 60)
               button.clipsToBounds = true
               return button
           
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

    
//    func enableTextFields(tag:Int)  {
//        switch tag {
//        case 1:
//            enalbes(t: first1TextField,first2TextField)
//        case 2:
//            enalbes(t: second1TextField,second2TextField)
//        case 3:
//            enalbes(t: third1TextField,third2TextField)
//        case 4:
//            enalbes(t: forth1TextField,forth2TextField)
//        case 5:
//            enalbes(t: fifth1TextField,fifth2TextField)
//        case 6:
//            enalbes(t: sexth1TextField,sexth2TextField)
//        default:
//            enalbes(t: seventh1TextField,seventh2TextField)
//
//        }
//    }
//
//  @objc  func handleOpen(sender:UIButton)  {
//        enableTextFields(tag: sender.tag)
//    addGradientInSenderAndRemoveOther(sender: sender)
//    }
    
    
   @objc func tapDone()  {
        print(969)
    }
    
//    @objc func handle1Shift(sender:UIButton)  {
//           if sender.backgroundColor == nil {
//            return
////               ClinicDataViewModel.male = false;return
//           }
//           addGradientInSenderAndRemoveOther(sender: sender, vv: shift2Button)
//        chooseWorkingHoursViewModel.isShiftTwo = false
//        chooseWorkingHoursViewModel.isShiftOne = true
////           doctorRegisterViewModel.male = false
//       }
//
//       @objc func handle2Shift(sender:UIButton)  {
//           if sender.backgroundColor == nil {
//            return
////               doctorRegisterViewModel.male = true;return
//           }
//           addGradientInSenderAndRemoveOther(sender: sender, vv: shift1Button)
//        chooseWorkingHoursViewModel.isShiftTwo = true
//                 chooseWorkingHoursViewModel.isShiftOne = false
////           doctorRegisterViewModel.male = true
//       }
    

}
