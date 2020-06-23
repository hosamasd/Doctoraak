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
        v.phy=phyOrder
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.okButton.addTarget(self, action: #selector(handleAcceptOrder), for: .touchUpInside)
        v.cancelButton.addTarget(self, action: #selector(handleCancelOrder), for: .touchUpInside)
        
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
    lazy var textView = UITextView(frame: CGRect.zero)
    
    
    fileprivate let index:Int!
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
    
    var labOrderss:LABOrderModel?{
           didSet{
               guard let lab = labOrderss else { return  }
            customSelectedPatientDataVC.patientCell.patientLab=lab.patient
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
               customSelectedPatientDataVC.patientCell.patient=lab.patient
           }
       }
    
    var labOrder:LABGetOrdersModel?{
        didSet{
            guard let lab = labOrder else { return  }
            customSelectedPatientDataVC.patientCell.patient=lab.patient
        }
    }
//    var phyOrder:PharmacyGetOrdersModel?{
//        didSet{
//            guard let phy = phyOrder else { return  }
//            customSelectedPatientDataVC.patientCell.patient=phy.patient
//        }
//    }
    var radOrder:RadGetOrdersModel?{
        didSet{
            guard let lab = radOrder else { return  }
            customSelectedPatientDataVC.patientCell.patient=lab.patient
        }
    }
    //    fileprivate let phy:PharmacyGetOrdersModel!
    //    fileprivate let pharmacy:PharamacyModel!
    init(inde:Int) {
        self.index = inde
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func checkDoctorLoginState()  {
        
    }
    
    func acceptPharmacyOrders()  {
        guard let pharmacy = phy,let  phy = phyOrder else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
        
        OrdersServices.shared.acceptPharmacyOrders(api_token: pharmacy.apiToken, pharmacy_id: phy.pharmacyID ?? 1, order_id: phy.pharmacyOrderID) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //                SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base else {return}
            SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
            self.customSelectedPatientDataVC.bottomStack.isHide(true)
        }
    }
    
    
    func acceptLABRADOrders(indexx:Int)  {
        var apiToekn:String
        var userId:Int
        var orderId:Int
        
        if indexx==2 {
            guard let pharmacy = lab,let  phyy = labOrder else { return  }
            apiToekn = pharmacy.apiToken
            userId=phyy.id
            orderId=phyy.labID
            
        }else {
            guard let pharmacy = rad,let  phyy = radOrder else { return  }
            apiToekn = pharmacy.apiToken
            userId=phyy.id
            orderId=phyy.radiologyID
            
        }
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder(cc: customMainAlertVC, v: customAlertMainLoodingView)
        
        OrdersServices.shared.acceptRADORLABOrders(index: indexx, api_token: apiToekn, user_id: userId, order_id: orderId) { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //                SVProgressHUD.dismiss()
            self.handleDismiss()
            self.activeViewsIfNoData()
            guard let user = base else {return}
            SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
            //            self.customSelectedPatientDataVC.bottomStack.isHide(true)
            //            self.customSelectedPatientDataVC.isAcceptOrRefused = true
        }
    }
    
    func createAlert(ind:Int)  {
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
    
    func makeActionForCancel(ind:Int,message:String)  {
        var apiToekn:String
               var userId:Int
               var orderId:Int
               
               if ind==2 {
                   guard let pharmacy = lab,let  phyy = labOrder else { return  }
                   apiToekn = pharmacy.apiToken
                   userId=phyy.id
                   orderId=phyy.labID
                   
               }else {
                   guard let pharmacy = rad,let  phyy = radOrder else { return  }
                   apiToekn = pharmacy.apiToken
                   userId=phyy.id
                   orderId=phyy.radiologyID
                   
               }
        //           guard let patient = patient else { return  }
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //        SVProgressHUD.show(withStatus: "looding...".localized)
        self.showMainAlertLooder(cc: customMainAlertVC, v: customAlertMainLoodingView)
        OrdersServices.shared.cancelRADORLABOrders(message: message, index: ind, api_token: apiToekn, user_id: userId, order_id: orderId) { (base, err) in
            if let err = err {
                           SVProgressHUD.showError(withStatus: err.localizedDescription)
                           self.handleDismiss()
                           self.activeViewsIfNoData();return
                       }
                       //                SVProgressHUD.dismiss()
                       self.handleDismiss()
                       self.activeViewsIfNoData()
                       guard let user = base else {return}
                       SVProgressHUD.showSuccess(withStatus: MOLHLanguage.isRTLLanguage() ? user.message : user.messageEn)
        }
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
    
    
    //TODO:-Handle methods
    
    
    
    @objc   func handleBack()  {
        self.customSelectedPatientDataVC.okButton.isHide(false)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc  func handleCancelOrder()  {
        
        self.createAlert(ind:2)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleAcceptOrder()  {
        index == 0 || index == 1 ? checkDoctorLoginState() : index == 4 ? acceptPharmacyOrders() :  acceptLABRADOrders(indexx:index)
        
        
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}


