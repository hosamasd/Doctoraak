//
//  CustomMainHomeLeftView.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//



import UIKit
import SDWebImage
import MOLH

class CustomMainHomeLeftView: CustomBaseView {
    
    var index:Int? {
        didSet{
            guard let index = index else { return  }
            homeAllLeftMenuCollectionVC.index=index
        }
    }
    
     var doctor:DoctorModel?{
           didSet{
               guard let lab = doctor else { return  }
               
               let name = MOLHLanguage.isRTLLanguage() ? lab.nameAr ?? lab.name : lab.name
               let dd =  getSpecizalitionFromIndex(lab.specializationID)
               userNameLabel.text = name+"\n"+dd
               let urlString = lab.photo
               guard let url = URL(string: urlString) else { return  }
               userImage.sd_setImage(with: url)
           }
       }
       var meidicalCenter:DoctorModel?{
           didSet{
               guard let lab = meidicalCenter else { return  }
               
               let name = MOLHLanguage.isRTLLanguage() ? lab.nameAr ?? lab.name : lab.name
               let dd =  getSpecizalitionFromIndex(lab.specializationID)
               userNameLabel.text = name+"\n"+dd
               let urlString = lab.photo
               guard let url = URL(string: urlString) else { return  }
               userImage.sd_setImage(with: url)
           }
           
       }
    
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
            let name = MOLHLanguage.isRTLLanguage() ? lab.nameAr ?? lab.name : lab.name
            let dd =  lab.phone
            userNameLabel.text = name+"\n"+dd
            let urlString = lab.photo
            guard let url = URL(string: urlString) else { return  }
            userImage.sd_setImage(with: url)
            
        }
    }
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            
            let name = MOLHLanguage.isRTLLanguage() ? phy.nameAr ?? phy.name : phy.name
            let dd =  phy.phone
            userNameLabel.text = name+"\n"+dd
            let urlString = phy.photo
            guard let url = URL(string: urlString) else { return  }
            userImage.sd_setImage(with: url)
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            
            let name = MOLHLanguage.isRTLLanguage() ? lab.nameAr ?? lab.name : lab.name
            let dd =  lab.phone
            userNameLabel.text = name+"\n"+dd
            let urlString = lab.photo
            guard let url = URL(string: urlString) else { return  }
            userImage.sd_setImage(with: url)
        }
    }
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4142-5"))
        i.contentMode = .scaleAspectFill
        i.constrainHeight(constant: 120)
        return i
    }()
    lazy var userImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4143"))
        i.constrainWidth(constant: 80)
        i.constrainHeight(constant: 80)
        i.layer.cornerRadius = 40
        i.clipsToBounds = true
        return i
    }()
    lazy var userNameLabel = UILabel(text: "", font: .systemFont(ofSize: 20), textColor: .white,textAlignment: MOLHLanguage.isRTLLanguage() ? .right : .left,numberOfLines: 2)
    
    lazy var homeAllLeftMenuCollectionVC:SecondHomeLeftMenuCollcetionVC  =  {
        let vc = SecondHomeLeftMenuCollcetionVC()
        vc.handleCheckedIndex = {[unowned self ] index in
            self.handleCheckedIndex?(index)
        }
        //        vc.collectionView.isHide(true)
        return vc
    }()
    var handleCheckedIndex:((IndexPath)->Void)?
    //    var handleCheckedDocIndex:((IndexPath)->Void)?
    
    override func setupViews() {
        addSubViews(views: LogoImage,userImage,userNameLabel,homeAllLeftMenuCollectionVC.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        userImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        userNameLabel.anchor(top: userImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 24, bottom: 0, right: 0))
        
        
        
        homeAllLeftMenuCollectionVC.view.anchor(top: userNameLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 60, left: 20, bottom: 16, right: 0))
        
        
    }
}

