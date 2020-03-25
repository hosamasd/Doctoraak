//
//  CustomMainHomeLeftView.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit


class CustomMainHomeLeftView: CustomBaseView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-5"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var userImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "humberto-chavez-FVh_yqLR9eA-unsplash"))
         i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        return i
    }()
    lazy var userNameLabel = UILabel(text: "Bian Mohamed", font: .systemFont(ofSize: 20), textColor: .white)
    lazy var userSpecificationLabel = UILabel(text: "Cardiologist", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    lazy var Image1:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_language_24px"))
        return i
    }()
    lazy var Label1 = UILabel(text: "Profile", font: .systemFont(ofSize: 24), textColor: .black)
    lazy var firstStack:UIStackView = {
        let s = hstack(Image1,Label1,spacing:16,alignment:.center)
        return s
    }()
    lazy var Image2:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_language_24px"))
        return i
    }()
     lazy var Label2 = UILabel(text: "Calender", font: .systemFont(ofSize: 24), textColor: .black)
    lazy var first2Stack:UIStackView = {
        let s = hstack(Image2,Label2,spacing:16,alignment:.center)
        return s
    }()
    lazy var Image3:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_language_24px"))
        return i
    }()
     lazy var Label3 = UILabel(text: "Add clinic", font: .systemFont(ofSize: 24), textColor: .black)
    lazy var first3Stack:UIStackView = {
        let s = hstack(Image3,Label3,spacing:16,alignment:.center)
        return s
    }()
    lazy var Image4:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_language_24px"))
        return i
    }()
     lazy var Label4 = UILabel(text: "Clinic information", font: .systemFont(ofSize: 24), textColor: .black)
    lazy var first4Stack:UIStackView = {
        let s = hstack(Image4,Label4,spacing:16,alignment:.center)
        return s
    }()
    lazy var Image5:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4122"))
        return i
    }()
     lazy var Label5 = UILabel(text: "Analysis", font: .systemFont(ofSize: 24), textColor: .black)
    
    lazy var first5Stack:UIStackView = {
        let s = hstack(Image5,Label5,spacing:16,alignment:.center)
        return s
    }()
    lazy var Image6:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_phone_24px"))
        return i
    }()
     lazy var Label6 = UILabel(text: "Contact Us", font: .systemFont(ofSize: 24), textColor: .black)
    lazy var first6Stack:UIStackView = {
        let s = hstack(Image6,Label6,spacing:16,alignment:.center)
        return s
    }()
    lazy var Image7:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_language_24px"))
        return i
    }()
     lazy var Label7 = UILabel(text: "Language", font: .systemFont(ofSize: 24), textColor: .black)
    lazy var first7Stack:UIStackView = {
        let s = hstack(Image7,Label7,spacing:16,alignment:.center)
        s.constrainHeight(constant: 60)
        return s
    }()
    lazy var Image8:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "icon2"))
        return i
    }()
    lazy var Label8 = UILabel(text: "Log Out", font: .systemFont(ofSize: 24), textColor: #colorLiteral(red: 0.6841606498, green: 0.6842750907, blue: 0.6841363311, alpha: 1))
    lazy var first8Stack:UIStackView = {
        let s = getStack(views: Image8,Label8, spacing: 16, alignment: .center, distribution: .fill, axis: .horizontal)
        s.constrainHeight(constant: 60)
        return s
    }()
    
    override func setupViews() {
        [Image1,Image2,Image3,Image4,Image5,Image6,Image7,Image8].forEach({$0.constrainWidth(constant: 20)})
//        let ss = getStack(views: okButton,cancelButton, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let mainStack = getStack(views: firstStack,first2Stack,first3Stack,first4Stack,first5Stack,first6Stack,first7Stack, spacing: 32, distribution: .fillEqually, axis: .vertical)
        
        addSubViews(views: LogoImage,userImage,userNameLabel,userSpecificationLabel,mainStack,first8Stack)//,ss,docotrCollectionView.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        userImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 24, bottom: 0, right: 0))
        userNameLabel.anchor(top: userImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 46, bottom: 0, right: 0))

        userSpecificationLabel.anchor(top: userNameLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: 0, right: 0))
         mainStack.anchor(top: userSpecificationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 46, bottom: 0, right: 0))
//        doctorHomePatientsCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        //        ss.anchor(top: topDoctorHomeCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        //
        first8Stack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: 8, right: 32))
        
    }
}
