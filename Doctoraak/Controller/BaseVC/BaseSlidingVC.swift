//
//  BaseSlidingVC.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
import SVProgressHUD
import MOLH

class BaseSlidingVC: UIViewController {
    
    
    
    lazy var redView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var blueView:UIView = {
        let v = UIView(backgroundColor: .blue)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var darkCoverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
//    var currentDoctor:DoctorLoginModel!
//    var currentLab:LabLoginModel!
//    var currentRadiolog:RadiologyLoginModel!
//    var currentPharamacy:MainPharamacyLoginModel!
    
    //     var rightViewController: UIViewController = UINavigationController(rootViewController: HomeVC())
    
    lazy var rightViewController: UIViewController = UINavigationController(rootViewController: index < 2 ?  DoctorHomeVC() : MainHomeVC(inde: index))
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate let menuWidth:CGFloat = 300
    fileprivate var isMenuOpen:Bool = false
    var redViewTrailingConstraint: NSLayoutConstraint!
    var redViewLeadingConstarint:NSLayoutConstraint!
    
    var index = 0
    
//    fileprivate let index:Int!
//    init(indexx:Int) {
//        self.index = indexx
//        super.init(nibName: nil, bundle: nil)
//    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupViews()
        setupGesture()
        setupViewControllers()
        
        darkCoverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapped)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
         
        if index == 0  {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(true)
           if userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) {
               let welcome = WelcomeVC()
            let nav = UINavigationController(rootViewController: welcome)
            
               nav.modalPresentationStyle = .fullScreen
               present(nav, animated: true)
           }else {}
       }
    
    func check()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) {
                   let welcome = WelcomeVC()
                   let nav = UINavigationController(rootViewController: welcome)
                   nav.modalPresentationStyle = .fullScreen
                   present(nav, animated: true)
               }else {
//                   checkData()
               }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) {
//            let welcome = WelcomeVC()
//            let nav = UINavigationController(rootViewController: welcome)
//            nav.modalPresentationStyle = .fullScreen
//            present(nav, animated: true)
//        }else {
//            checkData()
//        }
////        checkData()
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpen ? .lightContent : .default
    }
    
    
    
    //MARK: -user methods
    
//    func checkData()  {
//        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
//        SVProgressHUD.show(withStatus: "Looding...")
//         index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
//        if index == 0 && currentDoctor == nil {
//            let user_id = userDefaults.integer(forKey: UserDefaultsConstants.doctorCurrentUSERID)
//            guard let api_Key = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentApiToken),let name = userDefaults.string(forKey: UserDefaultsConstants.doctorCurrentNAME) else { return  }
//
//            RegistrationServices.shared.updateDoctorProfile(user_id: user_id, api_token: api_Key, name: name) { (base, err) in
//                if let err = err {
//                    SVProgressHUD.showError(withStatus: err.localizedDescription)
//                    self.activeViewsIfNoData();return
//                }
//                SVProgressHUD.dismiss()
//                self.activeViewsIfNoData()
//
//                guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
//
//                self.currentDoctor = user
//                DispatchQueue.main.async {
//
//                    self.view.layoutIfNeeded()
//                }
//
//            }
//        }
        
        
        
//    }
    
    fileprivate func setupViews()  {
        view.backgroundColor = .red
        view.addSubViews(views: redView,blueView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
        ])
        self.redViewLeadingConstarint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        //        redViewLeadingConstraint.constant = 150
        redViewLeadingConstarint.isActive = true
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true
        
        
    }
    
    fileprivate func setupGesture()  {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePaneed))
        //        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
    
    fileprivate func setupViewControllers()  {
        let homeView = rightViewController.view!
        
        //        let menuVC = MenuVC()
        let menuVC = DoctorHomeLeftMenuVC()
        let menuView = menuVC.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(menuView)
        
        homeView.fillSuperview()
        menuView.fillSuperview()
        darkCoverView.fillSuperview()
        
        addChild(rightViewController)
        addChild(menuVC)
    }
    
    
    
    func handleEnded(gesture:UIPanGestureRecognizer)  {
        let translate = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        // Cleaning up this section of code to solve for Lesson #10 Challenge of velocity and darkCoverView
        if isMenuOpen {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translate.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            
            if translate.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
        
    }
    
    func didSelectItemAtIndex(indexx:IndexPath)  {
        
        
        
        performRightViewCleanUp()
        closeMenu()
        
        switch indexx.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: DoctorProfileVC())
            //        case 1:
            //            rightViewController = UINavigationController(rootViewController: DoctorNotificationsVC())
            //        case 2:
        //            rightViewController = BookmarkVC()
        default:
            rightViewController = UINavigationController(rootViewController: MainDoctorNotificationVC(inde: index))
            //            let tabBarController = UITabBarController()
            //            let momentsController = UIViewController()
            //            momentsController.navigationItem.title = "Moments"
            //            momentsController.view.backgroundColor = .orange
            //            let navController = UINavigationController(rootViewController: momentsController)
            //            navController.tabBarItem.title = "Moments"
            //            tabBarController.viewControllers = [navController]
            //            rightViewController = tabBarController
        }
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        redView.bringSubviewToFront(darkCoverView)
        
        
    }
    
    func performRightViewCleanUp()  {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpen ? 1 : 0
        })
    }
    
    func closeMenu() {
        redViewLeadingConstarint.constant = 0
        redViewTrailingConstraint.constant = 0
        isMenuOpen = false
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func openMenu() {
        isMenuOpen = true
        redViewLeadingConstarint.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate() // for indicate system to any changes in status bar
    }
    
    //TODO: -handle methods
    
    @objc func handleTapped()  {
        closeMenu()
    }
    
    @objc  func handlePaneed(gesture:UIPanGestureRecognizer)  {
        let transltaion = gesture.translation(in: view)
        var x = transltaion.x
        x = isMenuOpen ? x+menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        redViewLeadingConstarint.constant = x
        darkCoverView.alpha = x / menuWidth
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
