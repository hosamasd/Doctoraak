//
//  PatientCell.swift
//  Doctoraak
//
//  Created by hosam on 4/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class PatientCell: BaseCollectionCell {
    
    
   lazy var doctorProfileImage:UIImageView = {
          let i = UIImageView(backgroundColor: .gray)
          i.constrainWidth(constant: 80)
          i.constrainHeight(constant: 80)
          i.layer.cornerRadius = 8
          i.clipsToBounds = true
          return i
      }()
      lazy var doctorNameLabel = UILabel(text: "Jana Helal", font: .systemFont(ofSize: 16), textColor: .black)
      
      lazy var doctorGenderLabel = UILabel(text: "Female", font: .systemFont(ofSize: 16), textColor: .lightGray)
         lazy var doctorPhoneLabel = UILabel(text: "01063525215", font: .systemFont(ofSize: 16), textColor: .lightGray)
      
      override func setupViews() {
          let s = stack(doctorNameLabel,doctorGenderLabel,doctorPhoneLabel)
                    
          hstack(doctorProfileImage,s,spacing:8).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
          
      }
}