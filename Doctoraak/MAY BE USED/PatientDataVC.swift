////
////  PatientDataVC.swift
////  Doctoraak
////
////  Created by hosam on 3/25/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//
////CustomDoctorDataView
//class PatientDataVC: CustomBaseViewVC {
//    
//    
//    lazy var scrollView: UIScrollView = {
//        let v = UIScrollView()
//        v.backgroundColor = .clear
//        v.showsVerticalScrollIndicator=false
//
//        return v
//    }()
//    lazy var mainView:UIView = {
//        let v = UIView(backgroundColor: .white)
//        v.constrainHeight(constant: 900)
//        v.constrainWidth(constant: view.frame.width)
//        return v
//    }()
//    lazy var customPatientDataView:CustomPatientDataView = {
//        let v = CustomPatientDataView()
//        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
//        return v
//    }()
//    
//    var patient:PatientModel?{
//        didSet{
//            guard let patient = patient else { return  }
//            customPatientDataView.patient=patient
//        }
//    }
//    
//    
//    fileprivate let index:Int!
//    init(inde:Int) {
//        self.index = inde
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        scrollView.delegate=self
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
//        mainView.addSubViews(views: customPatientDataView)
//        customPatientDataView.fillSuperview()
//        
//        
//        
//    }
//    
//    //TODO:-Handle methods
//    
//    @objc   func handleBack()  {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//extension PatientDataVC:UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let x = scrollView.contentOffset.y
//        self.scrollView.isScrollEnabled = x < -60 ? false : true
//    
//      }
//}
