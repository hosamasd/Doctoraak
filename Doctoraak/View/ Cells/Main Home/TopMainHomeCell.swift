//
//  TopMainHomeCell.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class TopMainHomeCell: BaseCollectionCell {
    
    
    
    lazy var profileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 120)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var doctorWelcomeLabel = UILabel(text: "Welcome \n Dr. Bian Mohamed", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .left,numberOfLines: 2)
    
    lazy var doctorReservationLabel = UILabel(text: " 10 Reservations", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.3069777489, green: 0.7054325342, blue: 0.8267442584, alpha: 1))
    
    
    override func setupViews() {
        backgroundColor = .white
        let ss = stack(doctorWelcomeLabel,doctorReservationLabel).padBottom(20)
        hstack(profileImage,ss,spacing:16).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
    }
}

