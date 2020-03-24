//
//  VerificationVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class VerificationVC: CustomBaseViewVC {
    
    lazy var customVerificationView:CustomVerificationView = {
        let v = CustomVerificationView()
        return v
    }()
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customVerificationView)
        customVerificationView.fillSuperview()
    }
}
