//
//  PharmacyLoginVC.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class PharmacyLoginVC: CustomBaseViewVC {
    
    
    lazy var customLoginsView:CustomLoginsView = {
        let v = CustomLoginsView()
        
        return v
    }()
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customLoginsView)
        customLoginsView.fillSuperview()
    }
}
