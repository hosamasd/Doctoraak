//
//  WelcomeVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class WelcomeVC: CustomBaseViewVC {
    
lazy var customWelcomeView:CustomWelcomeView = {
    let v = CustomWelcomeView()
    return v
}()
    
    override func setupViews() {
        
        view.addSubview(customWelcomeView)
        customWelcomeView.fillSuperview()
    }
}
