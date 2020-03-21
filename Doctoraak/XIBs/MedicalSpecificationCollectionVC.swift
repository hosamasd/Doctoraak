//
//  MedicalSpecificationCellCollectionVC.swift
//  Doctoraak
//
//  Created by Ahmad Eisa on 3/17/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import Kingfisher
class MedicalSpecificationCollectionVC: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func configureMedicalSpecificationCell(with model: SpecificationModel) {
        
        name.text = model.name
        if let url = URL(string: model.url){
           let placeholder = UIImage(named:"placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            image.kf.indicatorType = .activity
            image.kf.setImage(with: url  , placeholder: placeholder,options: options )
        }
        
    }

}
