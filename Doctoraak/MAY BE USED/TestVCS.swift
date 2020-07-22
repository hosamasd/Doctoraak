//
//  TestVCS.swift
//  Doctoraak
//
//  Created by hosam on 3/26/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import UIMultiPicker
import SwiftUI
//import sca

class TestVCS: CustomBaseViewVC {
    
     lazy var mainDrop3View:UIView =  {
          
          let view =
            makeMainSubViewWithAppendView(vv: [bookSegmentedView])
//          l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseInsurance)))
        view.hstack(bookSegmentedView)
        view.layer.cornerRadius = 30
               view.layer.borderWidth = 1.0
               view.layer.masksToBounds = true
//               view.layer.shadowOpacity = 0.7

                         view.clipsToBounds=true
          return view
      }()
    lazy var bookSegmentedView:UISegmentedControl = {
           let items = ["Vodafone cash".localized,"Fawry".localized,"Visa card".localized]
           let view = UISegmentedControl(items: items)
          
           view.selectedSegmentIndex=0
           view.layer.cornerRadius = 30
                         view.layer.borderWidth = 1.0
                         view.layer.masksToBounds = true
        
//        view.constrainHeight(constant: 60)
//           view.addTarget(self, action: #selector(handleChoosedSegment), for: .valueChanged)
           return view
       }()
    
    func makeMainSubViewWithAppendView(vv:[UIView]) ->UIView {
          let l = UIView(backgroundColor: .white)
          l.layer.cornerRadius = 8
          l.layer.borderWidth = 1
          l.layer.borderColor = #colorLiteral(red: 0.4835817814, green: 0.4836651683, blue: 0.4835640788, alpha: 1).cgColor
          l.constrainHeight(constant: 60)
          vv.forEach { (v) in
              l.addSubViews(views: v)
          }
          return l
      }
    
    lazy var customAlertMainLoodingView:CustomAlertLoginView = {
             let v = CustomAlertLoginView()
        v.setupAnimation(name: "26048-info-bounce")
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        customMainAlertVC.addCustomViewInCenter(views: customAlertMainLoodingView, height: 250)
//                        present(customMainAlertVC, animated: true)
    }
    
    override func setupViews() {
        view.backgroundColor = .white
        view.addSubview(mainDrop3View)
        mainDrop3View.centerInSuperview(size: .init(width: view.frame.width-64, height: 60))
       
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
            self.dismiss(animated: true, completion: nil)
        }
    }
    
  @objc func handleLL()  {
        print(999)
    }
}


struct InfoVCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: TestVCS, context: Context) {
        // leave this empty
    }
    
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> TestVCS {
        TestVCS()
    }
}

struct TestVCS_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
      InfoVCRepresentable()
    }
}
