//
//  File.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import iOSDropDown
import SDWebImage

class TopDoctorHomeCell: BaseCollectionCell {
    
    var doctor:DoctorModel? {
        didSet{
            guard let doctor = doctor else { return  }
            let urlString =  doctor.photo
            guard let url = URL(string: urlString) else { return  }
            profileImage.sd_setImage(with: url)
            doctorWelcomeLabel.text = "Welcome \n"+doctor.name
            //            doctorReservationLabel.text = doctor.reservationRate ?? "0" + " Reservations"
        }
    }
    
    
    lazy var profileImage:UIImageView = {
        let i = UIImageView(backgroundColor: .gray)
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 150)
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var doctorWelcomeLabel = UILabel(text: "Welcome \n Dr. Bian Mohamed", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .left,numberOfLines: 2)
    
    lazy var doctorReservationLabel = UILabel(text: " \(numberOfReserve) Reservations", font: .systemFont(ofSize: 16), textColor: .black)
    
    lazy var mainDropView:UIView = {
        let l = UIView(backgroundColor: .white)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.constrainHeight(constant: 60)
//        l.addSubview(doctorClinicDrop)
        l.stack(doctorClinicDrop).withMargins(.allSides(8))
        return l
    }()
    lazy var doctorClinicDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        //        i.optionArray = ["clinic1","clinic1","clinic3"]
        if let cc = userDefaults.value(forKey: UserDefaultsConstants.DoctornumberOfClinicsAvaiable) as? [String] {
            i.optionArray =  cc
            numberOfReserve = cc.count
        }
        i.arrowSize = 20
        i.placeholder = "clinic 1"
        i.didSelect { (s, index, _) in
            self.handleChoosedClinicID?(index)
        }
        return i
    }()
    var numberOfReserve:Int = 0
    
    
    var handleChoosedClinicID:((Int)->Void)?
    
    
    override func setupViews() {
//        [doctorClinicDrop,doctorReservationLabel,mainDropView].forEach({$0.isHide(true)})
        backgroundColor = .white
        let ss = stack(doctorWelcomeLabel,mainDropView,doctorReservationLabel,spacing:8)
//        doctorClinicDrop.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        hstack(profileImage,ss,spacing:16).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
    }
}
