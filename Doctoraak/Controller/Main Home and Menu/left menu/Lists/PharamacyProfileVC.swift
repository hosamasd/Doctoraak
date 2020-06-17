//
//  CalenderVC.swift
//  Doctoraak
//
//  Created by hosam on 6/17/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class PharamacyProfileVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1100)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customPharamacyProfileView:CustomPharamacyProfileView = {
        let v = CustomPharamacyProfileView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customPharamacyProfileView)
        customPharamacyProfileView.fillSuperview()
        
    }
    
    //TODO: -handle methods
    
    
    @objc func handleBack()  {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}

