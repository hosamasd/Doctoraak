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
    lazy var customAlertChooseLanguageView:CustomAlertChooseLanguageView = {
        let v = CustomAlertChooseLanguageView()
        [v.englishButton,v.arabicButton,v.cancelButton].forEach({$0.addTarget(self, action: #selector(handleLanguages), for: .touchUpInside)})
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    
    lazy var customContactUsView:CustomContactUsView = {
        let v = CustomContactUsView()
        v.handleChoosedOption = {[unowned self] index in
            self.takeSpecificAction(index)
        }
        return v
    }()
    lazy var customAlertMainLoodingssView:CustomUpdateSserProfileView = {
        let v = CustomUpdateSserProfileView()
        v.handleLogoutTap = {[unowned self] in
            self.performLogout()
            self.removeViewWithAnimation(vvv: self.customAlertMainLoodingssView)
            self.customMainAlertVC.dismiss(animated: true)
            self.check()
        }
        v.handleCancelTap = {[unowned self] in
            self.removeViewWithAnimation(vvv: self.customAlertMainLoodingssView)
            self.customMainAlertVC.dismiss(animated: true)
            //               DispatchQueue.main.async {
            //                   self.dismiss(animated: true, completion: nil)
            //               }
        }
        return v
    }()
    
    fileprivate  func performLogout()  {
        
        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
            cacheLABObjectCodabe.deleteFile(cacheLABObjectCodabe.storedValue!)
            userDefaults.set(false, forKey: UserDefaultsConstants.labPerformLogin)
            userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedLAB)
        }else if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
            cachdRADObjectCodabe.deleteFile(cachdRADObjectCodabe.storedValue!)
            userDefaults.set(false, forKey: UserDefaultsConstants.radiologyPerformLogin)
            userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedRAD)
        }else if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
            cachdPHARMACYObjectCodabe.deleteFile(cachdPHARMACYObjectCodabe.storedValue!)
            userDefaults.set(false, forKey: UserDefaultsConstants.pharamacyPerformLogin)
            userDefaults.set(false, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedPHY)
        }
        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
        userDefaults.removeObject(forKey: UserDefaultsConstants.MainLoginINDEX)
        
        userDefaults.synchronize()
    }
    
    
    
    lazy var rightViewController: UIViewController = UINavigationController(rootViewController: index < 2 ?  DoctorHomeVC(inde: index) : MainHomeVC(inde: index))
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate let menuWidth:CGFloat = 300
    fileprivate var isMenuOpen:Bool = false
    var redViewTrailingConstraint: NSLayoutConstraint!
    var redViewLeadingConstarint:NSLayoutConstraint!
    
    var index:Int = 0
    var links = [
        "http://sphinxat.com/",
        "https://www.facebook.com/",
    ]
    
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if !userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) {
            //            view.backgroundColor = .clear
            check()
        }else {
            //            view.backgroundColor = .white
        }
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpen ? .lightContent : .default
    }
    
    
    
    //MARK: -user methods
    
    
    
    fileprivate  func check()  {
        let welcome = WelcomeVC()
        let nav = UINavigationController(rootViewController: welcome)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
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
        
        index = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
        
        let vc = index == 0 || index == 1 ? DoctorHomeLeftMenuVC(index: index) : HomeLeftMenuVC(index: index)
        let dd = index < 2 ?  DoctorHomeVC(inde: index) : MainHomeVC(inde: index)
        
        rightViewController = UINavigationController(rootViewController: dd)
        let homeView = rightViewController.view!
        //        let menuVC = MenuVC()
        let menuVC =  vc//HomeLeftMenuVC(index: 2)
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
    
    
    
    fileprivate func handleEnded(gesture:UIPanGestureRecognizer)  {
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
    
    fileprivate func performRightViewCleanUp()  {
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
    
    fileprivate func resetAppLanguage(_ isArabic:Bool) {
        //reset language
        //        self.navigationController?.popViewController(animated: true)
        if isArabic {
            MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "ar")
        }else {
            MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "ar" ? "en" : "en")
        }
        MOLH.reset()
    }
    
    fileprivate func callNumber(phoneNumber:String) {
        if let phoneCallURL:URL = URL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:])
            }
        }
    }
    
    fileprivate func sendUsingWhats()  {
        let urlWhats = "whatsapp://send?text=\("Hello World")"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL)
                }
                else {
                    showToast(context: self, msg: "please install whatsapp".localized)
                }
            }
        }
    }
    
    fileprivate func takeSpecificAction(_ index:Int)  {
        if index == 2 {
            self.callNumber(phoneNumber: "0123666")
        }else if index == 3 {
            self.sendUsingWhats()
        }else {
            guard let url = URL(string: self.links[index]) else { return  }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        removeViewWithAnimation(vvv: customContactUsView)
        customMainAlertVC.dismiss(animated: true)
    }
    
    //TODO: -handle methods
    
    @objc func handleTapped()  {
        closeMenu()
    }
    
    @objc  func handlePaneed(gesture:UIPanGestureRecognizer)  {
        if MOLHLanguage.isRTLLanguage() {
            
            let transltaion = gesture.translation(in: view)
            //            if transltaion.x > 0 {
            //                return
            //            }
            var x = -transltaion.x
            x = isMenuOpen ? x+menuWidth : x
            x = min(menuWidth, x)
            x = max(0, x)
            redViewLeadingConstarint.constant = x
            darkCoverView.alpha = x / menuWidth
            if gesture.state == .ended {
                handleEnded(gesture: gesture)
            }
        }else {
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
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customContactUsView)
        removeViewWithAnimation(vvv: customAlertChooseLanguageView)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLanguages(sender:UIButton)  {
        switch sender.tag {
        case 0:
            //english
            print("english")
            !MOLHLanguage.isArabic() ? () :                resetAppLanguage(false)
            
            
        case 1:
            //arabic
            print("arabic")
            MOLHLanguage.isArabic() ? () :               resetAppLanguage(true)
            
            
        default:
            ()
        }
        removeViewWithAnimation(vvv: customAlertChooseLanguageView)
        customMainAlertVC.dismiss(animated: true)
        
    }
    
    
}
