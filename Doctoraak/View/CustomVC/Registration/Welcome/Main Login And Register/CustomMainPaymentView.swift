//
//  CustomClinicPaymentView.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
class CustomMainPaymentView: CustomBaseView {
    
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
    
    lazy var titleLabel = UILabel(text: "Payment", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var soonLabel = UILabel(text: "Select the payment method", font: .systemFont(ofSize: 18), textColor: .white)
    
    lazy var vodafoneImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Vodafone_Sim_Card"))
        i.contentMode = .scaleAspectFill
//        i.isHide(true)
        i.constrainWidth(constant: 250)
        return i
    }()
    lazy var fawryImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Component 9 – 2"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 250)
        i.isHide(true)
        return i
    }()
    lazy var rightImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1724_22"))
        i.constrainWidth(constant: 8)
        i.contentMode = .scaleAspectFill
//        i.constrainHeight(constant: 30)
        return i
    }()
    lazy var leftImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1724"))
        i.constrainWidth(constant: 8)
        i.contentMode = .scaleAspectFill
//        i.constrainHeight(constant: 30)
        return i
    }()
    lazy var choosePayLabel = UILabel(text: "Enter your phone number :", font: .systemFont(ofSize: 18), textColor: .black,textAlignment: .center)

    lazy var numberTextField:UITextField = {
        let s = createMainTextFields(padding:100,place: "(324) 242-2457", type: .default,secre: true)
        let button = UIImageView(image: #imageLiteral(resourceName: "Group 4142-3"))
        button.frame = CGRect(x: CGFloat(s.frame.size.width - 80), y: CGFloat(0), width: CGFloat(80), height: CGFloat(50))
        s.leftView = button
        s.leftViewMode = .always
        return s
    }()
    lazy var codeTextField:UITextField = {
       let t = createMainTextFields(place: "65986")
        t.textAlignment = .center
        t.isHide(true)
        return t
    }()
    
    lazy var doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = ColorConstants.disabledButtonsGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.constrainHeight(constant: 50)
        
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    lazy var firstScrollButton = createButtons(image: #imageLiteral(resourceName: "Ellipse 128"),tags: 1)
    lazy var secondScrollButton = createButtons(image: #imageLiteral(resourceName: "Ellipse 129"),tags: 2)
    
    override func setupViews() {
        let ss = getStack(views: firstScrollButton,secondScrollButton, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        
        addSubViews(views: LogoImage,backImage,titleLabel,soonLabel,vodafoneImage,fawryImage,doneButton,leftImage,rightImage,ss,choosePayLabel,codeTextField,numberTextField)
        
        NSLayoutConstraint.activate([
            ss.centerXAnchor.constraint(equalTo: centerXAnchor),
             vodafoneImage.centerXAnchor.constraint(equalTo: centerXAnchor),
              fawryImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
        choosePayLabel.centerInSuperview(size: .init(width: frame.width, height: 120))
        //
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        soonLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        vodafoneImage.anchor(top: soonLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        fawryImage.anchor(top: soonLabel.bottomAnchor, leading: nil, bottom: vodafoneImage.bottomAnchor, trailing: nil,padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        
        leftImage.anchor(top: soonLabel.bottomAnchor, leading: nil, bottom: vodafoneImage.bottomAnchor, trailing: vodafoneImage.leadingAnchor,padding: .init(top: 32, left: 0, bottom: 0, right: -8))
        rightImage.anchor(top: soonLabel.bottomAnchor, leading: vodafoneImage.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 32, left: -8, bottom: 0, right: 0))
ss.anchor(top: choosePayLabel.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        numberTextField.anchor(top: choosePayLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 32, bottom: 16, right: 32))
 codeTextField.anchor(top: choosePayLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 32, bottom: 16, right: 32))
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
    func createButtons(image:UIImage,tags:Int) -> UIButton {
        let b = UIButton()
        b.setImage(image, for: .normal)
//        b.addTarget(self, action: #selector(handleChoosedButton), for: .touchUpInside)
        b.tag = tags
        return b
    }
    
//    func hideOrUnhide(tag:Int)  {
//        DispatchQueue.main.async {
//
//
//            self.vodafoneImage.isHide(tag == 1 ? false : true)
//            self.fawryImage.isHide(tag == 1 ? true : false)
//           self.numberTextField.isHide(tag == 1 ? false : true)
//            self.codeTextField.isHide(tag == 1 ? true : false)
////            self.num.rightViewMode = tag == 1 ? .always : .never
//        }
//    }
    
//    @objc func handleChoosedButton(sender:UIButton)  {
//        [firstScrollButton,secondScrollButton].forEach({$0.setImage(#imageLiteral(resourceName: "Ellipse 129"), for: .normal)})
//
//        sender.setImage( #imageLiteral(resourceName: "Ellipse 128"), for: .normal)
//        switch sender.tag {
//        case 1:
//           hideOrUnhide(tag: 1)
//        default:
//            hideOrUnhide(tag: tag)
//        }
//        [codeTextField,numberTextField].forEach({$0.text = ""})
//
//    }
}
