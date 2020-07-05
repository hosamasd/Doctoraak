//
//  MainHomeVC.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class MainHomeVC: CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 900)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customMainHomeView:CustomMainHomeView = {
        let v = CustomMainHomeView()
        v.index=index
        v.listImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenMenu)))
        v.notifyImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenNotifications)))
        v.handledisplayRADNotification = {[unowned self] noty in
            guard let phy=self.rad else {return}
            let patient = SelectedPharmacyPatientDataVC(inde: self.index)//SelectedPharmacyPatientDataVC(inde: self.index, phy: noty, pharmacy: phy)
            patient.delgate = self
            patient.radOrder = noty
            patient.rad=self.rad
            self.navigationController?.pushViewController(patient, animated: true)
        }
        v.handledisplayLABNotification = {[unowned self] noty in
            guard let phy=self.lab else {return}
            let patient = SelectedPharmacyPatientDataVC(inde: self.index)//SelectedPharmacyPatientDataVC(inde: self.index, phy: noty, pharmacy: phy)
            patient.delgate = self
            patient.labOrder = noty
            patient.lab=self.lab
            
            self.navigationController?.pushViewController(patient, animated: true)
        }
        v.handledisplayPHYNotification = {[unowned self] noty in
            guard let phy=self.phy else {return}
            let patient = SelectedPharmacyPatientDataVC(inde: self.index)//SelectedPharmacyPatientDataVC(inde: self.index, phy: noty, pharmacy: phy)
            patient.phy = phy
            patient.phyOrder=noty
            patient.delgate = self
            self.navigationController?.pushViewController(patient, animated: true)
        }
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    lazy var customAlertLoginView:CustomAlertLoginView = {
        let v = CustomAlertLoginView()
        v.setupAnimation(name: "4970-unapproved-cross")
        v.handleOkTap = {[unowned self] in
            self.handleDismiss()
        }
        return v
    }()
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
            customMainHomeView.topMainHomeCell.lab=lab
            //            fetchOrders()
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedLAB) ? () : fetchOrders()
        }
    }
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            customMainHomeView.topMainHomeCell.phy=phy
            //            fetchOrders()
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedPHY) ? () : fetchOrders()
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            customMainHomeView.topMainHomeCell.rad=lab
            //            fetchOrders()
            userDefaults.bool(forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedRAD) ? () : fetchOrders()
        }
    }
    fileprivate let index:Int!
    init(inde:Int) {
        self.index = inde
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        fetchOrders()
        if userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) {
            getObjects()
        }else {}  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        if userDefaults.bool(forKey: UserDefaultsConstants.isWelcomeVCAppear) {
        //            getObjects()
        //        }else {}  }
    }
    //MARK: -user methods
    
    func getObjects()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
            lab = cacheLABObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
            rad = cachdRADObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
            phy = cachdPHARMACYObjectCodabe.storedValue
        }
    }
    
    func fetchOrders()  {
        index == 2 ? fetchOrdersLAB() : index == 3 ? fetchOrdersRAD() : fetchOrdersPHY()
    }
    
    func fetchOrdersLAB()  {
        guard let phy = lab else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        OrdersServices.shared.fetchLABOrders(api_token: phy.apiToken, lab_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedLAB)
            userDefaults.synchronize()
            DispatchQueue.main.async {
                self.customMainHomeView.mainHomePatientsCollectionVC.notificationLABArray=user
                self.customMainHomeView.topMainHomeCell.reservation = user.count > 0 ?  user.count : 0
                
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
            }
        }
    }
    
    func fetchOrdersRAD()  {
        guard let phy = rad else { return  }
        //        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        OrdersServices.shared.fetchRADOrders(api_token: phy.apiToken, radiology_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedRAD)
            userDefaults.synchronize()
            self.customMainHomeView.mainHomePatientsCollectionVC.notificationRADArray=user
            
            DispatchQueue.main.async {
                self.customMainHomeView.topMainHomeCell.reservation = user.count > 0 ?  user.count : 0
                
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
            }
        }
    }
    
    func fetchOrdersPHY()  {
        guard let phy = phy else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        OrdersServices.shared.fetchPharmacyOrders(api_token: phy.apiToken, pharmacy_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            userDefaults.set(true, forKey: UserDefaultsConstants.isAllMainHomeObjectsFetchedPHY)
            userDefaults.synchronize()
            DispatchQueue.main.async {
                self.customMainHomeView.mainHomePatientsCollectionVC.notificationPHYArray=user
                self.customMainHomeView.topMainHomeCell.reservation = user.count > 0 ?  user.count : 0
                self.customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
            }
        }
        
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubview(customMainHomeView)
        customMainHomeView.fillSuperview()
        
    }
    
    func goToSpecifyIndex(_ indexx:IndexPath)  {
        print(indexx.item)
        let patient = PatientDataVC(inde: index)
        navigationController?.pushViewController(patient, animated: true)
        
    }
    
    func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    //TODO:-Hnadle methods
    
    @objc func handleOpenMenu()  {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleOpenNotifications()  {
        let mainIndex = userDefaults.integer(forKey: UserDefaultsConstants.MainLoginINDEX)
        //        if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
        phy = cachdPHARMACYObjectCodabe.storedValue
        //            guard let phy = phy else { return  }
        let notify = NotificationVC( index: mainIndex, isFromMenu: false)
        notify.phy=phy
        notify.rad=rad
        notify.lab=lab
        let nav = UINavigationController(rootViewController: notify)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        //        }
    }
    
    @objc func handleDismiss()  {
        
        
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

//MARK:-extension


extension MainHomeVC: SelectedPharmacyPatientDataProtocol {
    
    func deletePHY(indexPath: IndexPath, index: Int) {
        if index == 2 {
            customMainHomeView.mainHomePatientsCollectionVC.notificationLABArray.remove(at: indexPath.item)
        }else if index == 3 {
            customMainHomeView.mainHomePatientsCollectionVC.notificationRADArray.remove(at: indexPath.item)
        }else if index == 4 {
            customMainHomeView.mainHomePatientsCollectionVC.notificationPHYArray.remove(at: indexPath.item)
        }
        customMainHomeView.mainHomePatientsCollectionVC.collectionView.reloadData()
    }
}
