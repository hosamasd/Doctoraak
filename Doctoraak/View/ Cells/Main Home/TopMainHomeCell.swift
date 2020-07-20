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
import iOSDropDown

class TopMainHomeCell: BaseCollectionCell {
    
    var urlString:String? {
        didSet{
            guard let urlString = urlString,let index = index else { return  }
            let url = URL(string: urlString)
            let img:UIImage = index == 0 || index == 1 ? #imageLiteral(resourceName: "ic_clinic") : index == 2 ? #imageLiteral(resourceName: "Group 4144") : index == 3 ? #imageLiteral(resourceName: "Group 4145") : #imageLiteral(resourceName: "ic_pharmacy_type")
            
            profileImage.sd_setImage(with: url, placeholderImage: img)
            
        }
    }
    
    
    var index:Int?{
        didSet{
            guard let index = index else { return  }
            let ss = index==0 || index == 1 ? false : true
            DispatchQueue.main.async {
                self.mainDropView.isHide(ss)
                self.layoutIfNeeded()
            }
        }
    }
    
    
    var reservation:Int?{
        didSet{
            guard let reservation = reservation else { return  }
            let dd = reservation <= 0  ? "No Reservation Avaliable".localized :   " Reservations".localized + " :  \(reservation)" 
            doctorReservationLabel.text = dd
        }
    }
    
    
    var phy:PharamacyModel? {
        didSet{
            guard let notu = phy else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.nameAr ?? notu.name :  notu.name
            putsAttributedText(la: doctorWelcomeLabel, ft: "Welcome \n\n".localized, st: title)
            let urlString = notu.photo
            guard let url = URL(string: urlString) else { return  }
            profileImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "ic_pharmacy_type"))
            //            profileImage.image = #imageLiteral(resourceName: "ic_pharmacy_type")
        }
    }
    
    var rad:RadiologyModel? {
        didSet{
            guard let notu = rad else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.nameAr ?? notu.name :  notu.name
            putsAttributedText(la: doctorWelcomeLabel, ft: "Welcome \n\n".localized, st: title)
            let urlString = notu.photo
            guard let url = URL(string: urlString) else { return  }
            profileImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Group 4145"))
            //            profileImage.image = #imageLiteral(resourceName: "Group 4145")
        }
    }
    
    var lab:LabModel? {
        didSet{
            guard let notu = lab else { return  }
            let title = MOLHLanguage.isRTLLanguage() ? notu.nameAr ?? notu.name :  notu.name
            putsAttributedText(la: doctorWelcomeLabel, ft: "Welcome \n\n".localized, st: title)
            let urlString = notu.photo
            guard let url = URL(string: urlString) else { return  }
            profileImage.sd_setImage(with: url, placeholderImage:#imageLiteral(resourceName: "Group 4144"))
            //            profileImage.image = #imageLiteral(resourceName: "Group 4144")
        }
    }
    var doctor:DoctorModel? {
        didSet{
            guard let doctor = doctor else { return  }
            
            let title = MOLHLanguage.isRTLLanguage() ? doctor.nameAr ?? doctor.name :  doctor.name
            putsAttributedText(la: doctorWelcomeLabel, ft: "Welcome \n\n".localized, st: title)            
            profileImage.image = #imageLiteral(resourceName: "ic_clinic")
        }
    }
    
    var medicalCenter:DoctorModel? {
        didSet{
            guard let doctor = medicalCenter else { return  }
            profileImage.image = #imageLiteral(resourceName: "ic_clinic")
            let title = MOLHLanguage.isRTLLanguage() ? doctor.nameAr ?? doctor.name :  doctor.name
            putsAttributedText(la: doctorWelcomeLabel, ft: "Welcome \n\n".localized, st: title)
        }
    }
    
    lazy var profileImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_lab_type"))
        i.constrainWidth(constant: 80)
        //        i.constrainHeight(constant: 200)
        //        i.contentMode = .scaleAspectFill
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        return i
    }()
    lazy var doctorWelcomeLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .black,textAlignment: .left,numberOfLines: 3)
    
    lazy var doctorReservationLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: #colorLiteral(red: 0.3069777489, green: 0.7054325342, blue: 0.8267442584, alpha: 1))
    lazy var mainDropView:UIView = {
        let l = UIView(backgroundColor: .white)
        //        l.isHide(true)
        l.layer.cornerRadius = 8
        l.layer.borderWidth = 1
        l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
        l.constrainHeight(constant: 50)
        //        l.addSubview(doctorClinicDrop)
        //        l.isHide(numberOfClinics > 0 ? false : true)
        
        l.stack(doctorClinicDrop).withMargins(.allSides(8))
        return l
    }()
    lazy var doctorClinicDrop:DropDown = {
        let i = DropDown(backgroundColor: #colorLiteral(red: 0.9591651559, green: 0.9593221545, blue: 0.9591317773, alpha: 1))
        //        i.optionArray = ["clinic1","clinic1","clinic3"]
        //        if let cc = userDefaults.value(forKey: UserDefaultsConstants.DoctornumberOfClinicsAvaiable) as? [String] {
        //            i.optionArray =  cc
        //            self.reservation = cc.count
        //        }
        i.arrowSize = 20
        i.placeholder = "Clinic 1".localized
        i.didSelect { (s, index, _) in
            self.handleChoosedClinicID?(index)
        }
        return i
    }()
    //    var numberOfReserve:Int = 0
    var numberOfClinics:Int?  {
        didSet{
            guard let l = numberOfClinics else { return  }
            DispatchQueue.main.async {
                //                self.mainDropView.isHide( l > 0 ? false : true)
                
            }
        }
    }
    
    
    var handleChoosedClinicID:((Int)->Void)?
    
    override func setupViews() {
        [doctorWelcomeLabel,doctorReservationLabel].forEach({$0.textAlignment=MOLHLanguage.isRTLLanguage() ? .right : .left
        })
        let ss = stack(doctorWelcomeLabel,mainDropView,doctorReservationLabel,spacing:8).padBottom(20)
        let dd = stack(profileImage,UIView())
        
        hstack(profileImage,ss,spacing:16).withMargins(.init(top: 8, left: 16, bottom: 0, right: 16))
    }
    
    func putsAttributedText(la:UILabel,ft:String,st:String)  {
        let attributeText = NSMutableAttributedString(string: ft, attributes:  [.font : UIFont.boldSystemFont(ofSize: 18),.foregroundColor:UIColor.black])
        attributeText.append(NSAttributedString(string: st, attributes: [.font : UIFont.systemFont(ofSize: 25),.foregroundColor: UIColor.lightGray]))
        la.attributedText = attributeText
    }
}

