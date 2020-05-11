//
//  DoctorHomeCell.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SDWebImage

class DoctorHomePatientsCell: BaseCollectionCell {
    
    var patient:PatientModel! {
        didSet{
//            guard let ss = patient.photo.removeSubstringAfterOrBefore(needle: "http", beforeNeedle: false) else { return  }
//            let dd = "http"+ss ?? ""
            
            let urlString = patient.photo // dd ?? patient.photo
            guard let url = URL(string: urlString) else { return  }
            doctorProfileImage.sd_setImage(with: url)
            doctorNameLabel.text = patient.name
            doctorDateLabel.text = patient.createdAt
            doctorGenderLabel.text = patient.gender
        }
    }
    
    
    lazy var doctorProfileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var doctorDateLabel = UILabel(text: "22 Feb 19 / 14:45", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var doctorNameLabel = UILabel(text: "Jana Helal", font: .systemFont(ofSize: 16), textColor: .black)
    
    lazy var doctorGenderLabel = UILabel(text: "Female", font: .systemFont(ofSize: 16), textColor: .lightGray)
       lazy var doctorPhoneLabel = UILabel(text: "01063525215", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    override func setupViews() {
        let s = stack(doctorNameLabel,doctorGenderLabel,doctorPhoneLabel)
        
        let ss = hstack(UIView(),doctorDateLabel)
        
        let mains = hstack(doctorProfileImage,s,spacing:8)
        stack(ss,mains,spacing:8).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
    }
}
