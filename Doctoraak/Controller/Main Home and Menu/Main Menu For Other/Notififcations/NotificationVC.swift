//
//  NotificationVC.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
import SVProgressHUD
import MOLH

class NotificationVC: CustomBaseViewVC {
    
    private let refreshControl = UIRefreshControl()
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator=false
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customNotificationView:CustomNotificationView = {
        let v = CustomNotificationView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.index=index
        v.handledisplayDOCNotification = {[unowned self] noty,index,display in
            if display {
                self.goTOdiSPLAYOrder(l: nil,r: nil,doc: noty.order)
                
            }else {
                self.makeDeleteDOCNotify(index: self.index, id: noty.id,index)
            }
            
        }
        v.handledisplayRADNotification = {[unowned self] noty,index ,display in
            if display {
                self.goTOdiSPLAYOrder(l: nil,r: noty.order)
            }else {
                self.makeDeleteDOCNotify(index: 3, id: noty.id,index)
            }  }
        v.handledisplayLABNotification = {[unowned self] noty,index ,display in
            if display {
                self.goTOdiSPLAYOrder(l: noty.order,r: nil)
            }else {
                self.makeDeleteDOCNotify(index: 2, id: noty.id,index)
            }
        }
        v.handledisplayPHYNotification = {[unowned self] noty,index ,display in
            if display {
                self.goTOdiSPLAYOrder(l: nil,r: nil,s: noty.order)
            }else {
                self.makeDeleteDOCNotify(index: 4, id: noty.id,index)
            }
        }
        v.handleRefreshCollection = {[unowned self] in
            self.getNotifications()
        }
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
    
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            customNotificationView.phy=phy
            
            //            userDefaults.bool(forKey: UserDefaultsConstants.isPHYNotificationChanged) ? getNotifications() : ()
            
        }
    }
    var doctor:DoctorModel?{
        didSet{
            guard let lab = doctor else { return  }
            customNotificationView.doctor=lab
            //            userDefaults.bool(forKey: UserDefaultsConstants.isDoctorNotificationChanged) ? getNotifications() : ()
        }
    }
//    var medicalCenter:DoctorModel?{
//        didSet{
//            guard let lab = medicalCenter else { return  }
//            customNotificationView.medicalCenter=lab
//            //            userDefaults.bool(forKey: UserDefaultsConstants.isMedicalCenterNotificationChanged) ? getNotifications() : ()
//        }
//    }
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
            customNotificationView.lab=lab
            //            userDefaults.bool(forKey: UserDefaultsConstants.isLABNotificationChanged) ? getNotifications() : ()
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            customNotificationView.rad=lab
            
            //            userDefaults.bool(forKey: UserDefaultsConstants.isRADNotificationChanged) ? getNotifications() : ()
            
        }
    }
    var isBeginFetchNotification = true
    
    fileprivate let isFromMenu:Bool!
    fileprivate let index:Int!
    init(index:Int,isFromMenu:Bool) {
        self.isFromMenu=isFromMenu
        self.index=index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getObjects()
        scrollView.delegate=self
        //        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        //
        //               scrollView.refreshControl = refreshControl
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isBeginFetchNotification.toggle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHide(true)
        //        getObjects()
        //        getNotifications()
    }
    
    //MARK: -user methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customNotificationView)
        customNotificationView.fillSuperview()
    }
    
    fileprivate func getObjects()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
            lab = cacheLABObjectCodabe.storedValue
            //            userDefaults.bool(forKey: UserDefaultsConstants.isLABNotificationChanged) ? getNotifications() : ()
            isBeginFetchNotification ? getNotifications() : ()
        }else if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
            rad = cachdRADObjectCodabe.storedValue
            //            userDefaults.bool(forKey: UserDefaultsConstants.isRADNotificationChanged) ? getNotifications() : ()
            isBeginFetchNotification ? getNotifications() : ()
            
        }else if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
            phy = cachdPHARMACYObjectCodabe.storedValue
            isBeginFetchNotification ? getNotifications() : ()
            
            //            userDefaults.bool(forKey: UserDefaultsConstants.isPHYNotificationChanged) ? getNotifications() : ()
        }else if userDefaults.bool(forKey: UserDefaultsConstants.DoctorPerformLogin) {
            doctor = cacheDoctorObjectCodabe.storedValue
            isBeginFetchNotification ? getNotifications() : ()
        }
            //            userDefaults.bool(forKey: UserDefaultsConstants.isDoctorNotificationChanged) ? getNotifications() : ()
//        }else if userDefaults.bool(forKey: UserDefaultsConstants.medicalCenterPerformLogin) {
//            medicalCenter = cacheMedicalObjectCodabe.storedValue
//            isBeginFetchNotification ? getNotifications() : ()
//
//            //            userDefaults.bool(forKey: UserDefaultsConstants.isMedicalCenterNotificationChanged) ? getNotifications() : ()
//        }
    }
    
    fileprivate func getNotifications()  {
        index == 0 || index == 1 ? getDoctNotifications() : index == 2 ? getLABtNotifications() : index == 3 ? getRADNotifications() : getPHYNotifications()
        //        customNotificationView.notificationsCollectionVC.refreshControl.endRefreshing()
    }
    
    fileprivate func getDoctNotifications()  {
        guard let phy = doctor else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        
        ProfileServices.shared.getNotificationsDOC(api_token: phy.apiToken, user_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.reloadDocData(user: user)
                //                self.customNotificationView.notificationsCollectionVC.refreshControl.endRefreshing()
            }
        }
    }
    
    fileprivate  func goTOdiSPLAYOrder(l:LABOrderModel? = nil , r:RadiologyOrderModel? = nil,s:PharmacyOrderModel? = nil,doc:DoctorOrderModel? = nil)  {
        let dd = SelectedPharmacyPatientDataVC(inde: index, isFromMain: false)
        dd.labOrderss=l
        dd.radOrderss = r
        dd.phyOrderss=s
        dd.docOrder=doc
        
        dd.lab=self.lab
        dd.rad=self.rad
        dd.phy=self.phy
        dd.doctor=self.doctor
//        dd.medicalCenter=self.medicalCenter
        
        navigationController?.pushViewController(dd, animated: true)
    }
    
    fileprivate func reloadDocData(user:[DOCTORNotificationModel])  {
        self.customNotificationView.notificationsCollectionVC.notificationDocArray=user
        DispatchQueue.main.async {
            self.customNotificationView.notificationsCollectionVC.collectionView.refreshControl?.beginRefreshing()
            self.customNotificationView.notificationsCollectionVC.collectionView.refreshControl?.endRefreshing()
            self.customNotificationView.notificationsCollectionVC.collectionView.reloadData()
        }
        let ind = index == 0 ? UserDefaultsConstants.isDoctorNotificationChanged : UserDefaultsConstants.isMedicalCenterNotificationChanged
        
        userDefaults.set(true, forKey: ind)
        userDefaults.synchronize()
    }
    
    
    fileprivate func getPHYNotifications()  {
        guard let phy = phy else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        
        ProfileServices.shared.getNotificationsPHY(api_token: phy.apiToken, user_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.reloadPHYData(user: user)
            }
        }
    }
    
    fileprivate  func reloadPHYData(user:[PharmacyNotificationModel])  {
        self.customNotificationView.notificationsCollectionVC.notificationPHYArray=user
        DispatchQueue.main.async {
            self.customNotificationView.notificationsCollectionVC.collectionView.refreshControl?.beginRefreshing()
            self.customNotificationView.notificationsCollectionVC.collectionView.refreshControl?.endRefreshing()
            self.customNotificationView.notificationsCollectionVC.collectionView.reloadData()
        }
        let ind = UserDefaultsConstants.isPHYNotificationChanged
        userDefaults.set(true, forKey: ind)
        userDefaults.synchronize()
    }
    
    fileprivate  func getLABtNotifications()  {
        guard let phy = lab else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        
        ProfileServices.shared.getNotificationsLAB(api_token: phy.apiToken, user_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            //            DispatchQueue.main.async {
            self.reloadLABData(user: user)
            //            }
        }
    }
    
    fileprivate  func reloadLABData(user:[LABNotificationModel])  {
        self.customNotificationView.notificationsCollectionVC.notificationLABArray=user
        DispatchQueue.main.async {
            self.customNotificationView.notificationsCollectionVC.collectionView.refreshControl?.beginRefreshing()
            self.customNotificationView.notificationsCollectionVC.collectionView.refreshControl?.endRefreshing()
            self.customNotificationView.notificationsCollectionVC.collectionView.reloadData()
        }
        let ind = UserDefaultsConstants.isLABNotificationChanged
        userDefaults.set(false, forKey: ind)
        userDefaults.synchronize()
    }
    
    fileprivate  func getRADNotifications()  {
        guard let phy = rad else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        
        ProfileServices.shared.getNotificationsRAD(api_token: phy.apiToken, user_id: phy.id) { (base, err) in
            if let  err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            
            DispatchQueue.main.async {
                self.reloadRADData(user: user)
            }
        }
    }
    
    fileprivate  func reloadRADData(user:[RadiologyNotificationModel])  {
        self.customNotificationView.notificationsCollectionVC.notificationRADArray=user
        DispatchQueue.main.async {
            self.customNotificationView.notificationsCollectionVC.collectionView.refreshControl?.beginRefreshing()
            self.customNotificationView.notificationsCollectionVC.collectionView.refreshControl?.endRefreshing()
            self.customNotificationView.notificationsCollectionVC.collectionView.reloadData()
        }
        let ind = UserDefaultsConstants.isRADNotificationChanged
        userDefaults.set(true, forKey: ind)
        userDefaults.synchronize()
    }
    
    fileprivate  func showMainAlertLooder()  {
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 200)
        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
    }
    
    //rEMOVE NOTIFICATION
    
    fileprivate   func makeDeleteDOCNotify(index:Int,id:Int,_ indexx:IndexPath)  {
        UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
        self.showMainAlertLooder()
        ProfileServices.shared.removeNotification(notification_id: id) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                
                self.activeViewsIfNoData();return
            }
            self.handleDismiss()
            
            //            SVProgressHUD.dismiss()
            self.activeViewsIfNoData()
            guard let user = base else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            DispatchQueue.main.async {
                if index == 0 || index == 1 {
                    self.customNotificationView.notificationsCollectionVC.notificationDocArray.remove(at: indexx.item)
                }else if index == 2 {
                    self.customNotificationView.notificationsCollectionVC.notificationLABArray.remove(at: indexx.item)
                }else if index == 3 {
                    self.customNotificationView.notificationsCollectionVC.notificationRADArray.remove(at: indexx.item)
                }else {
                    self.customNotificationView.notificationsCollectionVC.notificationPHYArray.remove(at: indexx.item)
                }
                //                self.customNotificationView.notificationsCollectionVC.notificationDocArray.remove(at: indexx.item)
                self.customNotificationView.notificationsCollectionVC.collectionView.reloadData()
                self.showToast(context: self, msg: MOLHLanguage.isRTLLanguage() ? "تمت العملية بنجاح" :  user.messageEn)//"Deleted successfully...".localized)
            }
        }
    }
    
    //    fileprivate func setDefaults() {
    //        //        userDefaults.set(true, forKey: UserDefaultsConstants.isWelcomeVCAppear)
    //        userDefaults.set(true, forKey: UserDefaultsConstants.isLABNotificationChanged)
    //        userDefaults.set(true, forKey: UserDefaultsConstants.isRADNotificationChanged)
    //        userDefaults.set(true, forKey: UserDefaultsConstants.isPHYNotificationChanged)
    //        userDefaults.set(true, forKey: UserDefaultsConstants.isDoctorNotificationChanged)
    //        userDefaults.set(true, forKey: UserDefaultsConstants.isMedicalCenterNotificationChanged)
    //        userDefaults.synchronize()
    //    }
    
    //MARK: -Handle methods
    
    
    @objc func handleBack()  {
        if isFromMenu {
            dismiss(animated: true)
        }else {
            dismiss(animated: true)
        }
        //        setDefaults()
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK:-EXtension

extension NotificationVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.y
        self.scrollView.isScrollEnabled = x < -60 ? false : true
        
    }
}
