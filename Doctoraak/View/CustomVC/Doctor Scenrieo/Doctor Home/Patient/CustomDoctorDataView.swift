//
//  CustomDoctorDataView.swift
//  Doctoraak
//
//  Created by hosam on 4/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH
import SDWebImage

class CustomDoctorDataView: CustomBaseView {
    
    var patient:DoctorGetPatientsFromClinicModel?{
        didSet {
            guard let patient = patient else { return  }
            let insuranceCompany = patient.patient.insurance?.name
            let notes = patient.notes ?? "No Notes Found".localized
            let s = patient.type.toInt()
            let urlString = patient.patient.insurance?.photo ?? ""
            
            
            let type = s == 1 ? "New".localized : s == 2 ? "Consultation".localized : s == 3 ? "Follow Up".localized : "All".localized
            let number = patient.reservationNumber
            
            self.patientCell.patient = patient.patient
            
            
            DispatchQueue.main.async {[unowned self] in
                self.makeAttributedTextssss(la:self.topLabel,fir: "Reservation Type".localized, sec: type)
                self.makeAttributedTextssss(la:self.bottomLabel,fir: "Reservation  Number".localized, sec: "\(number)")
                
                //                self.bottomLabel.attributedText = second
                self.insuranceDetailLabel.text = insuranceCompany
                self.notesDetailLabel.text = notes
            }
            let ssss = urlString == "" ? true : false
            insuranceView.isHide(ssss)
            guard  let url = URL(string: urlString) else {return}
            self.insuranceImage.sd_setImage(with: url)
            
        }
    }
    
    var accepetArrayDOC:[Int]?  {
        didSet{
            guard let a = accepetArrayDOC else { return }
            let itemFound = a.contains(patient?.id ?? -1)
            bottomStack.isHide(itemFound)
        }
    }
    var accepetArrayMEDICALCENTER:[Int]?  {
        didSet{
            guard let a = accepetArrayMEDICALCENTER else { return }
            let itemFound = a.contains(patient?.id ?? -1)
            bottomStack.isHide(itemFound)
        }
    }
    
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
    
    
    lazy var titleLabel = UILabel(text: "Patient data".localized, font: .systemFont(ofSize: 30), textColor: .white)
    lazy var informationLabel = UILabel(text: "Information".localized, font: .systemFont(ofSize: 20), textColor: .lightGray)
    lazy var insuranceLabel = UILabel(text: "Insurance".localized, font: .systemFont(ofSize: 20), textColor: .lightGray)
    lazy var notesLabel = UILabel(text: "Notes".localized, font: .systemFont(ofSize: 20), textColor: .lightGray)
    
    lazy var mainStack:UIStackView = {
        
        let s = hstack(topImage,topLabel,spacing:0,alignment:.center)
        let d = hstack(bottomImage,bottomLabel,spacing:0,alignment:.center)
        [s,d].forEach({$0.constrainHeight(constant: 80)})
        let cc = stack(s,seperatorView,d, spacing: 0).padLeft(16).padRight(16)
        return cc
    }()
    lazy var bottomView:UIView = {
        let v = makeMainSubViewWithAppendViewwww(vv: [mainStack], height: 161)
        v.hstack(mainStack)
        return v
    }()
    lazy var topImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "download-(1)"))
        i.constrainWidth(constant: 100)
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        
        return i
    }()
    lazy var bottomImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_insert_invitation_24px"))
        i.constrainWidth(constant: 100)
        i.constrainHeight(constant: 60)
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = true
        
        return i
    }()
    lazy var topLabel = UILabel(text: "Reservation Type", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .left, numberOfLines: 2)//makeAttributedTextssss(fir: "Reservation Type", sec: "Consultation")
    lazy var bottomLabel = UILabel(text: "Reservation Number", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .left, numberOfLines: 2)//makeAttributedTextssss(fir: "Reservation Number", sec: "15")
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .gray)
        v.constrainHeight(constant: 1)
        return v
    }()
    
    
    lazy var insuranceView:UIView = {
        let v = makeMainSubViewWithAppendViewwww(vv: [insuranceImage,insuranceDetailLabel], height: 80)
        v.hstack(insuranceImage,insuranceDetailLabel,spacing:8,alignment:.center)
        return v
    }()
    lazy var insuranceImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "download-(1)"))
        i.constrainWidth(constant: 100)
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        
        return i
    }()
    lazy var insuranceDetailLabel = UILabel(text: "One Care Medical", font: .systemFont(ofSize: 20), textColor: .black)
    
    lazy var noteView:UIView = {
        let v = makeMainSubViewWithAppendViewwww(vv: [noteImage,notesDetailLabel], height: 80)
        v.hstack(noteImage,notesDetailLabel,spacing:0,alignment:.center)
        return v
    }()
    lazy var noteImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "22741-NU3AN9-1"))
        i.contentMode = .scaleAspectFill
        i.constrainWidth(constant: 100)
        i.clipsToBounds = true
        
        return i
    }()
    lazy var notesDetailLabel = UILabel(text: "There is no notes", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    
    lazy var okButton = createMainButtons(title: "Ok".localized, color: .white)
    lazy var cancelButton = createMainButtons(title: "Cancel".localized, color: .white)
    lazy var patientCell:PatientCell = {
        let v = PatientCell()
        v.backgroundColor = .white
        return v
    }()
    lazy var bottomStack:UIStackView = {
        let sta = getStack(views: okButton,cancelButton, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        return sta
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        okButton.applyGradient(colors: [ColorConstants.firstColorBangsegy,ColorConstants.secondColorBangsegy],index: 0)
        [okButton,cancelButton].forEach({$0.setTitleColor(.white, for: .normal)})
        cancelButton.backgroundColor = #colorLiteral(red: 0.7318444848, green: 0.7521331906, blue: 0.8052451015, alpha: 1)
    }
    
    
    override func setupViews() {
        
        [notesLabel,insuranceLabel,informationLabel,titleLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        
        [informationLabel,insuranceLabel,notesLabel].forEach({$0.constrainHeight(constant: 30)})
        let mains = getStack(views: informationLabel,bottomView,insuranceLabel,insuranceView,notesLabel,noteView, spacing: 16, distribution: .fillProportionally, axis: .vertical)
        
        //        let ss = getStack(views: okButton,cancelButton, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        
        addSubViews(views: LogoImage,backImage,titleLabel,patientCell,mains,bottomStack)
        //        addSubViews(views: LogoImage,backImage,titleLabel,doctorHomePatientsCell,ss)//,ss,docotrCollectionView.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        backImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        //        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        patientCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        mains.anchor(top: patientCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 32, bottom: 40, right: 32))
        //
        bottomStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
    
    
    func makeMainSubViewWithAppendViewwww(vv:[UIView],height:CGFloat) ->UIView {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.constrainHeight(constant: height)
        vv.forEach { (v) in
            l.addSubViews(views: v)
        }
        return l
    }
    
    
    func makeAttributedTextssss(la:UILabel,fir:String,sec:String)  {
        let attrString = NSMutableAttributedString()
            .appendWith(color: .black, weight: .regular, ofSize: 18, fir+"\n")
            .appendWith(color:.lightGray, weight: .bold, ofSize: 16, sec)
        
        la.attributedText=attrString
        //        l.attributedText = attrString
        //        l.numberOfLines = 2
        //        l.textAlignment = .left
    }
}


