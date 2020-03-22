//
//  CustomDetailsView.swift
//  Doctoraak
//
//  Created by hosam on 3/21/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomDetailsView: UIView {
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var backImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Icon - Keyboard Arrow - Left - Filled"))
        //        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    lazy var notifyImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_notifications_active_24px"))
        //        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    lazy var titleLabel = UILabel(text: "Details", font: .systemFont(ofSize: 30), textColor: .white)
    lazy var suggestedLabel = UILabel(text: "Doctor free suggested days", font: .systemFont(ofSize: 18), textColor: .gray)
    lazy var workingDateLabel = UILabel(text: "Doctor's working date", font: .systemFont(ofSize: 18), textColor: .gray)
    lazy var mainSecondView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    let baseTestCell = BaseTestCell()
    lazy var doctorSuggestShiftHorizentalVC:DoctorSuggestShiftHorizentalVC = {
        let v = DoctorSuggestShiftHorizentalVC()
        v.view.constrainHeight(constant: 180)
        return v
    }()
    lazy var doctorWorkingDateCollectionVC:DoctorWorkingDateCollectionVC  = {
        let v = DoctorWorkingDateCollectionVC()
        v.view.constrainHeight(constant: 200)
        return v
    }()
    lazy var bookButton:UIButton = {
        let button = CustomSiftButton(type: .system)
        button.setTitle("Book", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.constrainHeight(constant: 50)
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
        backgroundColor = .white
        
        addSubViews(views: LogoImage,backImage,notifyImage,titleLabel,baseTestCell,suggestedLabel,workingDateLabel,doctorSuggestShiftHorizentalVC.view,doctorWorkingDateCollectionVC.view,bookButton)
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        baseTestCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        suggestedLabel.anchor(top: baseTestCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
        doctorSuggestShiftHorizentalVC.view.anchor(top: suggestedLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        workingDateLabel.anchor(top: doctorSuggestShiftHorizentalVC.view.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        doctorWorkingDateCollectionVC.view.anchor(top: workingDateLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        bookButton.anchor(top: doctorWorkingDateCollectionVC.view.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 32, left: 16, bottom: 16, right: 16))
        
        
    }
    
    func createButtons(image:UIImage) -> UIButton {
        let b = UIButton()
        b.setImage(image, for: .normal)
        return b
    }
}
