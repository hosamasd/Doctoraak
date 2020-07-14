//
//  SelectedPatientDataVC.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

protocol SelectedPharmacyPatientDataProtocol{
    
    func deletePHY(indexPath:IndexPath,index:Int)
}

class SelectedPharmacyPatientDataVC: CustomBaseViewVC {
    
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
    lazy var customSelectedPatientDataVC:CustomSelectedPatientDataVC = {
        let v = CustomSelectedPatientDataVC()
        v.index = index
        v.phy=phyOrder
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.okButton.addTarget(self, action: #selector(handleAcceptOrder), for: .touchUpInside)
        v.cancelButton.addTarget(self, action: #selector(handleCancelOrder), for: .touchUpInside)
        v.sampleRosetaImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePreviewImage)))
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
    lazy var customAlertMainLoodingssView:CustomUpdateSserProfileView = {
        let v = CustomUpdateSserProfileView()
        v.handleLogoutTap = {[unowned self] in
            self.removeViewWithAnimation(vvv: self.customAlertMainLoodingssView)
            self.customMainAlertVC.dismiss(animated: true)
            self.makeAcceptOrder()
        }
        v.handleCancelTap = {[unowned self] in
            self.removeViewWithAnimation(vvv: self.customAlertMainLoodingssView)
            self.customMainAlertVC.dismiss(animated: true)
        }
        return v
    }()
    
    lazy var textView:UITextView = {
        let t = UITextView(frame: CGRect.zero)
        t.text = "Enter the reason for refuse"
        t.textColor = UIColor.lightGray
        t.delegate = self
        return t
    }()
    var delgate:SelectedPharmacyPatientDataProtocol?
    
    var indexPath:IndexPath?
    
    
    
    
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
        }
    }
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            
        }
    }
    var medicalCenter:DoctorModel?{
        didSet{
            guard let lab = medicalCenter else { return  }
            //            userDefaults.bool(forKey: UserDefaultsConstants.isMedicalCenterNotificationChanged) ? getNotifications() : ()
        }
    }
    var doctor:DoctorModel?{
        didSet{
            guard let lab = doctor else { return  }
            //            userDefaults.bool(forKey: UserDefaultsConstants.isMedicalCenterNotificationChanged) ? getNotifications() : ()
        }
    }
    
    
    var phyOrder:PharmacyGetOrdersModel?{
        didSet{
            guard let phy = phyOrder else { return  }
            customSelectedPatientDataVC.patientCell.patient=phy.patient
        }
    }
    var phyOrderss:PharmacyOrderModel?{
        didSet{
            guard let phy = phyOrder else { return  }
            //                  customSelectedPatientDataVC.patientCell.patient=phy.patient
        }
    }
    var radOrderss:RadiologyOrderModel?{
        didSet{
            guard let lab = radOrderss else { return  }
            //            lab.details.first?.rays.
            customSelectedPatientDataVC.patientCell.patient=lab.patient
        }
    }
    
    var labOrder:LABGetOrdersModel?{
        didSet{
            guard let lab = labOrder else { return  }
            customSelectedPatientDataVC.lab=lab
            
            //            customSelectedPatientDataVC.patientCell.patient=lab.patient
        }
    }
    var labOrderss:LABOrderModel?{
        didSet{
            guard let lab = labOrderss else { return  }
            customSelectedPatientDataVC.labOrder=lab
            //                customSelectedPatientDataVC.patientCell.patientLab=lab.patient
        }
    }
    var radOrder:RadGetOrdersModel?{
        didSet{
            guard let lab = radOrder else { return  }
            //            customSelectedPatientDataVC.patientCell.patient=lab.patient
            customSelectedPatientDataVC.rad=lab
        }
    }
    
    var docOrder:DoctorOrderModel?{
        didSet{
            guard let lab = docOrder else { return  }
            customSelectedPatientDataVC.patientCell.patient=lab.patient
            //               customSelectedPatientDataVC.doc=lab
        }
    }
    
    fileprivate let index:Int!
    fileprivate let isFromMain:Bool!
    init(inde:Int,isFromMain:Bool) {
        self.index = inde
        self.isFromMain = isFromMain
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getObjects()
        getArrayDefaults()
    }
    
    fileprivate func getArrayDefaults()  {
        if let doc = userDefaults.value(forKey: UserDefaultsConstants.acceptArrayDoc) as? [Int] {
            customSelectedPatientDataVC.accepetArrayDOC=doc.count > 0 ? doc.uniques : nil
        }
        if let doc = userDefaults.value(forKey: UserDefaultsConstants.acceptArrayRAD) as? [Int] {
            customSelectedPatientDataVC.accepetArrayRAD=doc.count > 0 ? doc.uniques : nil
        }
        if let doc = userDefaults.value(forKey: UserDefaultsConstants.acceptArrayLAB) as? [Int] {
            customSelectedPatientDataVC.accepetArrayLAB=doc.count > 0 ? doc.uniques : nil
        }
        if let doc = userDefaults.value(forKey: UserDefaultsConstants.acceptArrayPHY) as? [Int] {
            customSelectedPatientDataVC.accepetArrayPHY=doc.count > 0 ? doc.uniques : nil
        }
        if let doc = userDefaults.value(forKey: UserDefaultsConstants.acceptArrayMedicalCenter) as? [Int] {
            customSelectedPatientDataVC.accepetArrayMEDICALCENTER=doc.count > 0 ? doc.uniques : nil
        }
    }
    
    fileprivate func getObjects()  {
        if userDefaults.bool(forKey: UserDefaultsConstants.labPerformLogin) {
            lab = cacheLABObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.radiologyPerformLogin) {
            rad = cachdRADObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.pharamacyPerformLogin) {
            phy = cachdPHARMACYObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.DoctorPerformLogin) {
            doctor = cacheDoctorObjectCodabe.storedValue
        }else if userDefaults.bool(forKey: UserDefaultsConstants.medicalCenterPerformLogin) {
            medicalCenter = cacheMedicalObjectCodabe.storedValue
        }
    }
    
    //MARK:-User methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customSelectedPatientDataVC)
        customSelectedPatientDataVC.fillSuperview()
        
        
        
    }
    
    fileprivate func checkDoctorLoginState(indexx:Int,isAccept:Bool,message:String? = nil)  {
        var apiToekn:String
        var userId:Int
        var orderId:Int
        
        if isFromMain {
            
            if indexx==2 {
                guard let pharmacy = cachdPHARMACYObjectCodabe.storedValue ,let  phyy = phyOrder else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }else {
                guard let pharmacy = rad,let  phyy = radOrder else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }
        }else {
            
            if indexx==2 {
                guard let pharmacy = cachdPHARMACYObjectCodabe.storedValue ,let  phyy = phyOrderss else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }else {
                guard let pharmacy = rad,let  phyy = radOrder else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }
        }
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
        
        OrdersServices.shared.acceptPharmacyOrders(api_token: apiToekn, pharmacy_id: userId , order_id: orderId) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //                SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base else {return}
            
            DispatchQueue.main.async {
                SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
                self.makeAction(orderId)
                self.performBack(self.isFromMain,message)
            }
            //            SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
            //            self.customSelectedPatientDataVC.bottomStack.isHide(true)
            //            self.makeAction(phy.pharmacyOrderID)
            
        }
    }
    
    
    fileprivate  func acceptPharmacyOrders(indexx:Int,isAccept:Bool,message:String? = nil)  {
        
        var apiToekn:String
        var userId:Int
        var orderId:Int
        
        if isFromMain {
            
            if indexx==2 {
                guard let pharmacy = cachdPHARMACYObjectCodabe.storedValue ,let  phyy = phyOrder else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }else {
                guard let pharmacy = rad,let  phyy = radOrder else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }
        }else {
            
            if indexx==2 {
                guard let pharmacy = cachdPHARMACYObjectCodabe.storedValue ,let  phyy = phyOrderss else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }else {
                guard let pharmacy = rad,let  phyy = radOrder else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }
        }
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
        
        OrdersServices.shared.acceptPharmacyOrders(api_token: apiToekn, pharmacy_id: userId , order_id: orderId) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //                SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base else {return}
            
            DispatchQueue.main.async {
                SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
                self.makeAction(orderId)
                self.performBack(self.isFromMain,message)
            }
            //            SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
            //            self.customSelectedPatientDataVC.bottomStack.isHide(true)
            //            self.makeAction(phy.pharmacyOrderID)
            
        }
    }
    
    
    fileprivate func acceptLABRADOrders(indexx:Int,isAccept:Bool,message:String? = nil)  {
        var apiToekn:String
        var userId:Int
        var orderId:Int
        
        if isFromMain {
            
            if indexx==2 {
                guard let pharmacy = cacheLABObjectCodabe.storedValue ,let  phyy = labOrder else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }else {
                guard let pharmacy = cachdRADObjectCodabe.storedValue,let  phyy = radOrder else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }
        }else {
            
            if indexx==2 {
                guard let pharmacy = cacheLABObjectCodabe.storedValue ,let  phyy = labOrderss else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }else {
                guard let pharmacy = cachdRADObjectCodabe.storedValue,let  phyy = radOrderss else { return  }
                apiToekn = pharmacy.apiToken
                userId=pharmacy.id
                orderId=phyy.id
                
            }
        }
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder(cc: customMainAlertVC, v: customAlertMainLoodingView)
        
        OrdersServices.shared.acceptRADORLABOrders(message:message,isAccept: isAccept, index: indexx, api_token: apiToekn, user_id: userId, order_id: orderId) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //                SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base else {return}
            
            DispatchQueue.main.async {
                SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
                self.makeAction(orderId)
                self.performBack(self.isFromMain,message)
            }
        }
    }
    
    func performBack(_ main:Bool,_ message:String? = nil)  {
        if message != nil {
            delgate?.deletePHY(indexPath: indexPath!, index: index)
            navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func makeAction(_ id:Int)  {
        if index==1 {
            customSelectedPatientDataVC.accepetArrayMEDICALCENTER?.append(id)
        }  else      if index==0 {
            customSelectedPatientDataVC.accepetArrayDOC?.append(id)
        }else      if index==2 {
            customSelectedPatientDataVC.accepetArrayLAB?.append(id)
        }else      if index==3 {
            customSelectedPatientDataVC.accepetArrayRAD?.append(id)
        }else    {
            customSelectedPatientDataVC.accepetArrayPHY?.append(id)
        }
        
        saveDefaULTS()
        
        //        DispatchQueue.main.async {
        self.customSelectedPatientDataVC.bottomStack.isHide(true)
        //        }
    }
    
    fileprivate func saveDefaULTS()  {
        userDefaults.set(customSelectedPatientDataVC.accepetArrayDOC, forKey: UserDefaultsConstants.acceptArrayDoc)
        userDefaults.set(customSelectedPatientDataVC.accepetArrayLAB, forKey: UserDefaultsConstants.acceptArrayLAB)
        userDefaults.set(customSelectedPatientDataVC.accepetArrayRAD, forKey: UserDefaultsConstants.acceptArrayRAD)
        userDefaults.set(customSelectedPatientDataVC.accepetArrayPHY, forKey: UserDefaultsConstants.acceptArrayPHY)
        userDefaults.set(customSelectedPatientDataVC.accepetArrayMEDICALCENTER, forKey: UserDefaultsConstants.acceptArrayMedicalCenter)
        userDefaults.synchronize()
    }
    
    fileprivate  func createAlert(ind:Int)  {
        let alertController = UIAlertController(title: "Feedback \n\n\n\n\n".localized, message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "Cancel".localized, style: .default) { (action) in
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Submit".localized, style: .default) { (action) in
            let enteredText = self.textView.text
            self.makeActionForCancel(ind:ind,message:enteredText ?? "")
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(saveAction)
        
        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        textView.backgroundColor = UIColor.white
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        alertController.view.addSubview(self.textView)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func makeActionForCancel(ind:Int,message:String)  {
        index == 0 || index == 1 ? checkDoctorLoginState(indexx: index, isAccept: false,message: message) : index == 4 ? acceptPharmacyOrders(indexx: index, isAccept: false,message: message) :  acceptLABRADOrders(indexx:index, isAccept: false,message: message)
        
        //        self.acceptLABRADOrders(indexx: index, isAccept: false,message:message)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin: CGFloat = 8
                let xPos = rect.origin.x + margin
                let yPos = rect.origin.y + 54
                let width = rect.width - 2 * margin
                let height: CGFloat = 90
                
                textView.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            }
        }
    }
    
    func makeAcceptOrder()  {
        index == 0 || index == 1 ? checkDoctorLoginState(indexx: index, isAccept: true) : index == 4 ? acceptPharmacyOrders(indexx: index, isAccept: true) :  acceptLABRADOrders(indexx:index, isAccept: true)
    }
    
    
    
    //TODO:-Handle methods
    
    @objc  func handlePreviewImage()  {
        
        let img:UIImage = customSelectedPatientDataVC.sampleRosetaImage.image ?? #imageLiteral(resourceName: "G4-G5 Sample Rx")
        
        let zoom = ZoomUserImageVC(img: img)
        navigationController?.pushViewController(zoom, animated: true)
        
    }
    
    
    @objc   func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc  func handleCancelOrder()  {
        
        self.createAlert(ind:index)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleAcceptOrder()  {
        
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingssView, height: 250)
        customAlertMainLoodingssView.discriptionInfoLabel.text = "Are You Sure You Want To Accept Order?\n"
        customAlertMainLoodingssView.okButton.setTitle("Accept", for: .normal)
        present(customMainAlertVC, animated: true)
        //        index == 0 || index == 1 ? checkDoctorLoginState() : index == 4 ? acceptPharmacyOrders() :  acceptLABRADOrders(indexx:index)
        
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SelectedPharmacyPatientDataVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter the reason for refuse"
            textView.textColor = UIColor.lightGray
        }
    }
}
