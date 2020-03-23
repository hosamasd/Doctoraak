//
//  SecondWelcomeVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class SecondWelcomeVC: CustomBaseViewVC {
    
    lazy var customSecondWelcomeView:CustomSecondWelcomeView = {
        let v = CustomSecondWelcomeView()
        return v
    }()
    
    override func setupViews() {
        view.addSubview(customSecondWelcomeView)
        customSecondWelcomeView.fillSuperview()
    }
}
