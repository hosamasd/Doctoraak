//
//  RegisterVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DoctorRegisterVC: CustomBaseViewVC {
    
    lazy var customRegisterView:CustomRegisterView = {
        let v = CustomRegisterView()
        v.boyButton.addTarget(self, action: #selector(handleBoy), for: .touchUpInside)
          v.girlButton.addTarget(self, action: #selector(handleGirl), for: .touchUpInside)
        return v
    }()
    var index:Int = 0
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customRegisterView)
        customRegisterView.fillSuperview()
    }
    
   @objc func handleGirl(sender:UIButton)  {
    addGradientInSenderAndRemoveOther(sender: sender, vv: customRegisterView.boyButton)

    }
    
    @objc func handleBoy(sender:UIButton)  {
        addGradientInSenderAndRemoveOther(sender: sender, vv: customRegisterView.girlButton)
    }
}
