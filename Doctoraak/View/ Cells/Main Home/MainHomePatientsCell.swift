//
//  MainHomePatientsCell.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH

class MainHomePatientsCell: BaseCollectionCell {
    
    var phy:PharmacyGetOrdersModel? {
        didSet{
            guard let notu = phy else { return  }
            patienDateLabel.text = notu.createdAt
            patientCityLabel.text = notu.patient.address
            let title = MOLHLanguage.isRTLLanguage() ? notu.patient.nameAr ?? notu.patient.name :  notu.patient.name
            patientNameLabel.text = title
            let urlString = notu.photo
            guard  let url = URL(string: urlString) else { return  }
            patientProfileImage.sd_setImage(with: url)
        }
    }
    
    var rad:RadGetOrdersModel? {
        didSet{
            guard let notu = rad else { return  }
            patienDateLabel.text = notu.createdAt
            patientCityLabel.text = notu.patient.address
            let title = MOLHLanguage.isRTLLanguage() ? notu.patient.nameAr ?? notu.patient.name :  notu.patient.name
            patientNameLabel.text = title
            let urlString = notu.photo
            guard  let url = URL(string: urlString) else { return  }
            patientProfileImage.sd_setImage(with: url)
        }
    }
    
    var lab:LABGetOrdersModel? {
        didSet{
            guard let notu = lab else { return  }
            patienDateLabel.text = notu.createdAt
            patientCityLabel.text = notu.patient.address
            let title = MOLHLanguage.isRTLLanguage() ? notu.patient.nameAr ?? notu.patient.name :  notu.patient.name
            patientNameLabel.text = title
            let urlString = notu.photo
            guard  let url = URL(string: urlString) else { return  }
            patientProfileImage.sd_setImage(with: url)
        }
    }
    var patient:PatientModel? {
        didSet{
            guard let patient = patient else { return  }
            
            patientNameLabel.text = patient.name
            patienDateLabel.text = patient.createdAt
            patientCityLabel.text = patient.gender
            let urlString = patient.photo // dd ?? patient.photo
            guard let url = URL(string: urlString) else { return  }
            patientProfileImage.sd_setImage(with: url)
        }
    }
    
    lazy var patientProfileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var patienDateLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .lightGray)
    lazy var patientNameLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black)
    
    lazy var patientCityLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .lightGray)
    
    override func setupViews() {
        [patientNameLabel,patientCityLabel].forEach({$0.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left})
        let s = stack(patientNameLabel,patientCityLabel).padBottom(20)
        
        let ss = hstack(UIView(),patienDateLabel)
        
        let mains = hstack(patientProfileImage,s,spacing:8)
        stack(ss,mains).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
    }
    
}
