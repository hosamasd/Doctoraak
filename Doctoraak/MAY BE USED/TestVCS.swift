//
//  TestVCS.swift
//  Doctoraak
//
//  Created by hosam on 3/26/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import UIMultiPicker
//import sca

class TestVCS: CustomBaseViewVC {
    
    lazy var customAlertMainLoodingView:CustomUpdateSserProfileView = {
             let v = CustomUpdateSserProfileView()
             return v
         }()
         
         lazy var customMainAlertVC:CustomMainAlertVC = {
             let t = CustomMainAlertVC()
             t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
             t.modalTransitionStyle = .crossDissolve
             t.modalPresentationStyle = .overCurrentContext
             return t
         }()
    
    lazy var Image6:UIImageView = {
         let i = UIImageView(image: #imageLiteral(resourceName: "lego(1)"))
         i.constrainWidth(constant: 120)
         i.constrainHeight(constant: 120)
        
        i.layer.cornerRadius=60
        i.clipsToBounds=true
        i.layer.borderWidth=3
        i.layer.borderColor = UIColor.white.cgColor
         return i
     }()
    
    override func setupViews() {
        view.backgroundColor = .red
        view.addSubview(Image6)
        Image6.centerInSuperview()
//        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 250)
//                 present(customMainAlertVC, animated: true)
    }
    
    override func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "asd", style: .plain, target: self, action: #selector(handleLL))
    }
    
    @objc func selected(_ sender: UIMultiPicker) {
        print(sender.isMultipleTouchEnabled)
    }
    
    @objc func handleDismiss()  {
//        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
//            self.dismiss(animated: true, completion: nil)
        }
    }
    
  @objc func handleLL()  {
        print(999)
    }
}
