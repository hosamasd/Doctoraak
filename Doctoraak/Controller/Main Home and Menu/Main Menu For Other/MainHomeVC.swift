//
//  MainHomeVC.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MainHomeVC: CustomBaseViewVC {
    
    lazy var customMainHomeView:CustomMainHomeView = {
        let v = CustomMainHomeView()
        v.handleSelectedIndex = {[unowned self] indexPath in
         self.goToSpecifyIndex(indexPath)
        }
        return v
    }()
    var index:Int? = 0
    
    
  
    
       //MARK: -user methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customMainHomeView)
        customMainHomeView.fillSuperview()
        
    }
    
    func goToSpecifyIndex(_ index:IndexPath)  {
        print(index.item)
        let patient = PatientDataVC()
        navigationController?.pushViewController(patient, animated: true)
        
    }
}
