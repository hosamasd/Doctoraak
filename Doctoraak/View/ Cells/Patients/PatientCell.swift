//
//  PatientCell.swift
//  Doctoraak
//
//  Created by hosam on 4/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SDWebImage

class PatientCell: BaseCollectionCell {
    
    var patient:PatientModel!{
        didSet{
            let urlString = patient.photo
            
            guard let url = URL(string: urlString) else {return}
            
            DispatchQueue.main.async {
                self.PatientProfileImage.sd_setImage(with: url)
                self.PatientNameLabel.text = self.patient.name
                self.PatientGenderLabel.text = self.patient.gender
                self.PatientPhoneLabel.text = self.patient.phone
            }
        }
    }
    
    
    lazy var PatientProfileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var PatientNameLabel = UILabel(text: "Jana Helal", font: .systemFont(ofSize: 16), textColor: .black)
    
    lazy var PatientGenderLabel = UILabel(text: "Female", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var PatientPhoneLabel = UILabel(text: "01063525215", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    override func setupViews() {
        let s = stack(PatientNameLabel,PatientGenderLabel,PatientPhoneLabel)
        
        hstack(PatientProfileImage,s,spacing:8).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
    }
}
