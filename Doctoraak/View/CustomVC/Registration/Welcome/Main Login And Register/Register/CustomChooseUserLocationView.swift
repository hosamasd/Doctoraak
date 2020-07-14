//
//  CustomChooseUserLocationView.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import MOLH
import GoogleMaps

class CustomChooseUserLocationView: CustomBaseView {
    
    
    lazy var infoImageView:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Group 3928-1").withRenderingMode(.alwaysOriginal))
        i.constrainWidth(constant: 40)
        i.constrainHeight(constant: 40)
        i.contentMode = .scaleToFill
        i.isUserInteractionEnabled = true
        return i
    }()
    lazy var mapView:GMSMapView  = {
           let i = GMSMapView()
           i.padding = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
           return i
       }()
    lazy var searchView:UIView = {
        let v = makeMainSubViewWithAppendView(vv: [searchImage,searchLabel])
        v.constrainHeight(constant: 60)
        v.hstack(searchImage,searchLabel,spacing:32).padLeft(16)
        return v
    }()
    lazy var searchLabel = UILabel(text: "Search...", font: .systemFont(ofSize: 25), textColor: .lightGray,numberOfLines: 2)
    lazy var searchImage:UIImageView = {
        let b = UIImageView(image: #imageLiteral(resourceName: "loupe"))
        b.contentMode = .scaleAspectFit
        b.clipsToBounds = true
        b.constrainWidth(constant: 40)
        return b
    }()
    lazy var doneButton:UIButton = {
        let b = UIButton()
        b.setTitle("Done".localized, for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.backgroundColor = ColorConstants.disabledButtonsGray
        b.constrainHeight(constant: 50)
        b.layer.cornerRadius = 16
        b.clipsToBounds = true
        return b
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if doneButton.backgroundColor != nil {
            addGradientInSenderAndRemoveOther(sender: doneButton)
            doneButton.setTitleColor(.white, for: .normal)
        }
    }
    
    override func setupViews() {
        backgroundColor = .white
        searchLabel.textAlignment = MOLHLanguage.isRTLLanguage() ? .right : .left
        addSubViews(views: mapView,infoImageView,searchView,doneButton)
        mapView.fillSuperview()
        
        searchView.anchor(top: infoImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        
        infoImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        doneButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 16, bottom: 32, right: 16))
    }
}

