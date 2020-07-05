////
////  MainDoctorNotificationVC.swift
////  Doctoraak
////
////  Created by hosam on 3/30/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//
//class MainDoctorNotificationVC: CustomBaseViewVC {
//    
//    lazy var scrollView: UIScrollView = {
//        let v = UIScrollView()
//        v.backgroundColor = .clear
//        
//        return v
//    }()
//    lazy var mainView:UIView = {
//        let v = UIView(backgroundColor: .white)
//        v.constrainHeight(constant: 1000)
//        v.constrainWidth(constant: view.frame.width)
//        return v
//    }()
//    lazy var customMainDoctorNotificationView:CustomMainDoctorNotificationView = {
//        let v = CustomMainDoctorNotificationView()
//        v.listImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenMenu)))
//
////        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
//        return v
//    }()
//    
//    fileprivate let index:Int!
//       init(inde:Int) {
//           self.index = inde
//           super.init(nibName: nil, bundle: nil)
//       }
//       required init?(coder: NSCoder) {
//           fatalError("init(coder:) has not been implemented")
//       }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//    }
//    
//    
//    //MARK:-User methods
//    
//    override func setupNavigation()  {
//        navigationController?.navigationBar.isHide(true)
//    }
//    
//    override func setupViews()  {
//        view.backgroundColor = .white
//        
//        view.addSubview(scrollView)
//        scrollView.fillSuperview()
//        scrollView.addSubview(mainView)
//        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
//        mainView.addSubViews(views: customMainDoctorNotificationView)
//        customMainDoctorNotificationView.fillSuperview()
//        
//        
//        
//    }
//    
//    @objc func handleOpenMenu()  {
//           (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
//           
//       }
//}
