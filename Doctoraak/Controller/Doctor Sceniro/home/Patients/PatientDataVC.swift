//
//  PatientDataVC.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class PatientDataVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customPatientDataView:CustomPatientDataView = {
        let v = CustomPatientDataView()
        return v
    }()
    var index:Int? = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
    }
    
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customPatientDataView)
        customPatientDataView.fillSuperview()
        
        
        
    }
}