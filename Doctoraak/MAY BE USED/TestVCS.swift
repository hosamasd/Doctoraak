//
//  TestVCS.swift
//  Doctoraak
//
//  Created by hosam on 3/26/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import UIMultiPicker

class TestVCS: CustomBaseViewVC {
    
    lazy var customAlertMainLoodingView:CustomUpdateSserProfileView = {
             let v = CustomUpdateSserProfileView()
//             v.setupAnimation(name: "heart_loading")
             return v
         }()
         
         lazy var customMainAlertVC:CustomMainAlertVC = {
             let t = CustomMainAlertVC()
             t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
             t.modalTransitionStyle = .crossDissolve
             t.modalPresentationStyle = .overCurrentContext
             return t
         }()
    
    override func setupViews() {
        view.backgroundColor = .white
        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 250)
//        customAlertMainLoodingView.problemsView.loopMode = .loop
        present(customMainAlertVC, animated: true)
//        view.addSubview(tests)
//        tests.addTarget(self, action: #selector(selected), for: .valueChanged)
//
//        tests.centerInSuperview(size: .init(width: view.frame.width, height: 200))
        
    }
    
    override func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "asd", style: .plain, target: self, action: #selector(handleLL))
    }
    
    @objc func selected(_ sender: UIMultiPicker) {
        print(sender.isMultipleTouchEnabled)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
  @objc func handleLL()  {
        print(999)
    }
}
