//
//  SelectedPatientDataPHYCell.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class SelectedPatientDataPHYCell: BaseCollectionCell {
    
    var order:PharmacyDetailModel?{
        didSet{
            guard let order = order else { return  }
            nameLabel.text = getNameFromIndex(order.medicineID)
            typeLabel.text = getTypeFromIndex(order.medicineTypeID)
            countLabel.text = "Quantity : \(order.amount)"
        }
    }
    
    
    lazy var nameLabel = UILabel(text: "Name", font: .systemFont(ofSize: 20), textColor: .black)
    lazy var typeLabel = UILabel(text: "Type", font: .systemFont(ofSize: 16), textColor: .gray)
    lazy var countLabel = UILabel(text: "3", font: .systemFont(ofSize: 16), textColor: .lightGray )
    lazy var leftImage:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "Rectangle 1758"))
        i.constrainWidth(constant: 8)
        i.contentMode = .scaleAspectFill
        return i
    }()
    lazy var seperatorView:UIView = {
        let v = UIView(backgroundColor: .lightGray)
        v.constrainHeight(constant: 1)
        return v
    }()
    
    
    override func setupViews() {
        backgroundColor = .white
        let ss = stack(nameLabel,typeLabel,countLabel,spacing:8)
        
        hstack(leftImage,ss,spacing:16)
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
    
    
    func getNameFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        
        if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineNameIDSArray) as? [Int]{
            
            citName = cityArray
            cityId = cityIds
            
            
            
        }else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineNameArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineNameIDSArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        
        return citName[ff - 1 ]
    }
    
    func getTypeFromIndex(_ index:Int) -> String {
        var citName = [String]()
        var cityId = [Int]()
        
        if let  cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeIDSArray) as? [Int]{
            
            citName = cityArray
            cityId = cityIds
            
            
            
        }else {
            if let cityArray = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeArray) as? [String],let cityIds = userDefaults.value(forKey: UserDefaultsConstants.medicineTypeIDSArray) as? [Int] {
                citName = cityArray
                cityId = cityIds
            }
        }
        let ss = cityId.filter{$0 == index}
        let ff = ss.first ?? 1
        
        return citName[ff - 1 ]
    }
    
}


