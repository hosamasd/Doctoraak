//
//  CustomMainHomeView.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MOLH
import SDWebImage

class CustomMainHomeView: CustomBaseView {
    
    var lab:LabModel?{
          didSet{
              guard let lab = lab else { return  }
              //                             customMainHomeLeftView.lab=lab
          }
      }
      var phy:PharamacyModel?{
          didSet{
              guard let phy = phy else { return  }
              //                             customMainHomeLeftView.phy=phy
          }
      }
      var rad:RadiologyModel?{
          didSet{
              guard let lab = rad else { return  }
              //            customMainHomeView.mainHomePatientsCollectionVC.notificationRADArray=lab
          }
      }
    
    lazy var LogoImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 4116"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var listImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_subject_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true

        return i
    }()
    lazy var notifyImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_notifications_active_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        i.isUserInteractionEnabled = true

        return i
    }()
    lazy var titleLabel = UILabel(text: "Home", font: .systemFont(ofSize: 30), textColor: .white)
    
    lazy var topMainHomeCell = TopMainHomeCell()
   
    lazy var mainHomePatientsCollectionVC:MainHomePatientsCollectionVC = {
       let vc = MainHomePatientsCollectionVC()
        vc.handledisplayRADNotification = {[unowned self] indexPath in
            self.handledisplayRADNotification?(indexPath)
        }
        vc.handledisplayLABNotification = {[unowned self] indexPath in
                   self.handledisplayLABNotification?(indexPath)
               }
        vc.handledisplayPHYNotification = {[unowned self] indexPath in
                   self.handledisplayPHYNotification?(indexPath)
               }
        
        return vc
    }()
    
    var handledisplayRADNotification:((RadGetOrdersModel)->Void)?
       var handledisplayLABNotification:((LABGetOrdersModel)->Void)?
       var handledisplayPHYNotification:((PharmacyGetOrdersModel)->Void)?
    
    override func setupViews() {
        
        addSubViews(views: LogoImage,listImage,notifyImage,titleLabel,topMainHomeCell,mainHomePatientsCollectionVC.view)
        
        LogoImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: -48, bottom: 0, right: 0))
        listImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 16, bottom: 0, right: 0))
        notifyImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: LogoImage.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 46, bottom: -20, right: 0))
        topMainHomeCell.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 0, right: 32))
        
        mainHomePatientsCollectionVC.view.anchor(top: topMainHomeCell.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 16, left: 46, bottom: 8, right: 32))
        
    }
}
