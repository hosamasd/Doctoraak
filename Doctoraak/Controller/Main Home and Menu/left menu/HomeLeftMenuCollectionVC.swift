//
//  HomeLeftMenuVC.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class HomeLeftMenuVC: CustomBaseViewVC {
    
  
    lazy var customMainHomeLeftView:CustomMainHomeLeftView = {
        let v = CustomMainHomeLeftView()
//        v.firstStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOne)))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
      //MARK: -user methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(customMainHomeLeftView)
        customMainHomeLeftView.fillSuperview()
    }
  
     //TODO: -handle methods
    
    @objc func handleOne()  {
        print(9999999)
    }
}
