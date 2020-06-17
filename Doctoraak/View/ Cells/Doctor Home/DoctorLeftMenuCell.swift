//
//  DoctorLeftMenuCell.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DoctorLeftMenuCell: UICollectionViewCell {
    
    
    
    lazy var Image6:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "ic_phone_24px"))
        i.constrainWidth(constant: 30)
        i.constrainHeight(constant: 30)
        return i
    }()
    lazy var Label6 = UILabel(text: "Contact Us", font: .systemFont(ofSize: 24), textColor: .black)
    
    override var isSelected: Bool{
           didSet{
               backgroundColor = isSelected ? #colorLiteral(red: 0.4410271694, green: 0.3507713137, blue: 1, alpha: 1) : .white
           }
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupViews() {
        hstack(Image6,Label6,spacing:16,alignment: .center).withMargins(.init(top: 8, left: 0, bottom: 8, right: 0))
    }
}
