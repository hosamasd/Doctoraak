//
//  DeatilsVC.swift
//  Doctoraak
//
//  Created by hosam on 3/21/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class DeatilsVC: UIViewController {
    
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
    lazy var customDetailsView:CustomDetailsView = {
       let v = CustomDetailsView()
//        v.backgroundColor = .red
        return v
    }()
//    lazy var bookButton:UIButton = {
//        let button = CustomSiftButton(type: .system)
//        button.setTitle("Book", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        button.clipsToBounds = true
//        button.constrainHeight(constant: 50)
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setNeedsStatusBarAppearanceUpdate()
        setupViews()
        setupNavigation()
    }
    
    
    func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
//        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customDetailsView)
        customDetailsView.fillSuperview()
        
        
        
    }
}
