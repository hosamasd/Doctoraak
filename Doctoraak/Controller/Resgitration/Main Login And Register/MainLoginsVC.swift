//
//  LoginVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MainLoginsVC: CustomBaseViewVC {
    
    lazy var customLoginsView:CustomLoginsView = {
       let v = CustomLoginsView()
        
        return v
    }()
    
    //check to go specific way
    var index:Int? = 0
    
//    var isLab,isPharamacy,isRediology,isDoctor:Int?
    
    
   override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews() {
        
        view.addSubview(customLoginsView)
        customLoginsView.fillSuperview()
    }
}
