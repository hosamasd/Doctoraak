//
//  DoctorHomeVC.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DoctorHomeVC: CustomBaseViewVC {
    
    lazy var customDoctorHomeView:CustomDoctorHomeView = {
        let v = CustomDoctorHomeView()
        return v
    }()
    var index:Int? = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    //MARK:-User methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customDoctorHomeView)
        customDoctorHomeView.fillSuperview()
        
    }
    
}
