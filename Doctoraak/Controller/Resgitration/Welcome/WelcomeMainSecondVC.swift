//
//  WelcomeMainSecondVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class WelcomeMainSecondVC: CustomBaseViewVC {
    
    
    
    lazy var customWelcomeMainSecondView:CustomWelcomeMainSecondView = {
        let v = CustomWelcomeMainSecondView()
        return v
    }()
    
    override func setupViews() {
        
        view.addSubview(customWelcomeMainSecondView)
        customWelcomeMainSecondView.fillSuperview()
    }
}
