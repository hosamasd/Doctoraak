//
//  SecondRegisterVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class SecondRegisterVC: CustomBaseViewVC {
    
    lazy var customCecondRegisterView:CustomCecondRegisterView = {
        let v = CustomCecondRegisterView()
//        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
//        v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        return v
    }()
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customCecondRegisterView)
        customCecondRegisterView.fillSuperview()
    }
}
