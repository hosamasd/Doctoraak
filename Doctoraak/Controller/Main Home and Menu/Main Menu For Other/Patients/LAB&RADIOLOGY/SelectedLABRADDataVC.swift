////
////  SelectedLABRADDataVC.swift
////  Doctoraak
////
////  Created by hosam on 6/20/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//
//
//class SelectedLABRADDataVC: CustomBaseViewVC {
//    
// lazy var scrollView: UIScrollView = {
//        let v = UIScrollView()
//        v.backgroundColor = .clear
//        
//        return v
//    }()
//    lazy var mainView:UIView = {
//        let v = UIView(backgroundColor: .white)
//        v.constrainHeight(constant: 900)
//        v.constrainWidth(constant: view.frame.width)
//        return v
//    }()
//    lazy var customSelectedLABRADDataVC:CustomSelectedLABRADDataVC = {
//        let v = CustomSelectedLABRADDataVC()
//        v.phy=phy
//        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
//        v.okButton.addTarget(self, action: #selector(handleAcceptOrder), for: .touchUpInside)
//        return v
//    }()
//    lazy var customMainAlertVC:CustomMainAlertVC = {
//        let t = CustomMainAlertVC()
//        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
//        t.modalTransitionStyle = .crossDissolve
//        t.modalPresentationStyle = .overCurrentContext
//        return t
//    }()
//    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
//        let v = CustomAlertMainLoodingView()
//        v.setupAnimation(name: "heart_loading")
//        return v
//    }()
//    
//    fileprivate let index:Int!
//    fileprivate let phy:PharmacyGetOrdersModel!
//    fileprivate let pharmacy:PharamacyModel!
//    init(inde:Int,phy:PharmacyGetOrdersModel,pharmacy:PharamacyModel) {
//        self.pharmacy=pharmacy
//        self.phy=phy
//        self.index = inde
//        super.init(nibName: nil, bundle: nil)
//    }
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
//        mainView.addSubViews(views: customSelectedLABRADDataVC)
//        customSelectedLABRADDataVC.fillSuperview()
//        
//        
//        
//    }
//    
//    //TODO:-Handle methods
//    
//    @objc   func handleBack()  {
//        self.customSelectedPatientDataVC.okButton.isHide(false)
//
//        navigationController?.popViewController(animated: true)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    @objc func handleAcceptOrder()  {
//        UIApplication.shared.beginIgnoringInteractionEvents()
//        self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
//
//        OrdersServices.shared.acceptPharmacyOrders(api_token: pharmacy.apiToken, pharmacy_id: phy.pharmacyID, order_id: phy.pharmacyOrderID) { (base, err) in
//            if let err = err {
//                SVProgressHUD.showError(withStatus: err.localizedDescription)
//                self.handleDismiss()
//                self.activeViewsIfNoData();return
//            }
//            //                SVProgressHUD.dismiss()
//            self.handleDismiss()
//            self.activeViewsIfNoData()
//            guard let user = base else {return}
//            SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
//            self.customSelectedPatientDataVC.okButton.isHide(true)
//        }
//    }
//    
//    @objc func handleDismiss()  {
//        removeViewWithAnimation(vvv: customAlertMainLoodingView)
//        DispatchQueue.main.async {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//    
//}
//
//
//
