//
//  ClinicPaymentVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class ClinicPaymentVC: CustomBaseViewVC {
    
    lazy var customClinicPaymentView:CustomClinicPaymentView = {
        let v = CustomClinicPaymentView()
        return v
    }()
    
      var index:Int? = 0
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(customClinicPaymentView)
        customClinicPaymentView.fillSuperview()
        
    }
}
