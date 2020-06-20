//
//  TopMainHomeCell.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH
import SDWebImage

class TopMainHomeCell: BaseCollectionCell {
    
    var reservation:Int?{
        didSet{
            guard let reservation = reservation else { return  }
            doctorReservationLabel.text = " \(reservation) Reservations"
        }
    }
    
    
    var phy:PharamacyModel? {
        didSet{
            guard let notu = phy else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.nameAr ?? notu.name :  notu.name
            putsAttributedText(la: doctorWelcomeLabel, ft: "Welcome \n\n", st: title)

            let urlString = notu.photo
            guard  let url = URL(string: urlString) else { return  }
            profileImage.sd_setImage(with: url)
        }
    }
    
    var rad:RadiologyModel? {
        didSet{
            guard let notu = rad else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.nameAr ?? notu.name :  notu.name
            putsAttributedText(la: doctorWelcomeLabel, ft: "Welcome  \n\n", st: title)

            let urlString = notu.photo
            guard  let url = URL(string: urlString) else { return  }
            profileImage.sd_setImage(with: url)
        }
    }
    
    var lab:LabModel? {
        didSet{
            guard let notu = lab else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.nameAr ?? notu.name :  notu.name
            putsAttributedText(la: doctorWelcomeLabel, ft: "Welcome  \n\n", st: title)

            let urlString = notu.photo
            guard  let url = URL(string: urlString) else { return  }
            profileImage.sd_setImage(with: url)
        }
    }
    
    lazy var profileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 120)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var doctorWelcomeLabel = UILabel(text: "Welcome \n Dr. Bian Mohamed", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .left,numberOfLines: 3)
    
    lazy var doctorReservationLabel = UILabel(text: "  Reservations", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.3069777489, green: 0.7054325342, blue: 0.8267442584, alpha: 1))
    
    
    override func setupViews() {
        backgroundColor = .white
        let ss = stack(doctorWelcomeLabel,doctorReservationLabel).padBottom(20)
        hstack(profileImage,ss,spacing:16).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    func putsAttributedText(la:UILabel,ft:String,st:String)  {
     let attributeText = NSMutableAttributedString(string: ft, attributes:  [.font : UIFont.boldSystemFont(ofSize: 18),.foregroundColor:UIColor.black])
        attributeText.append(NSAttributedString(string: st, attributes: [.font : UIFont.systemFont(ofSize: 25),.foregroundColor: UIColor.lightGray]))
        la.attributedText = attributeText
    }
}

