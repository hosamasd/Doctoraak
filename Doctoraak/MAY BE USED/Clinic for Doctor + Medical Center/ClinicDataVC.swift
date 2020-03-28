//
//  ClinicDataVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
class ClinicDataVC: CustomBaseViewVC {
    
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1000)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    lazy var customClinicDataView:CustomClinicDataView = {
        let v = CustomClinicDataView()
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        
        v.clinicWorkingHoursTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChooseWorkingHours)))
        //        v.cityDrop.addTarget(self, action: #selector(handleMulti), for: .touchUpInside)
        return v
    }()
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customClinicDataView.clinicWorkingHoursTextField.inputAccessoryView = UIView()
    }
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        //        mainView.fillSuperview()
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customClinicDataView)
        customClinicDataView.fillSuperview()
        
        
        
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDone()  {
        let payment = MainPaymentVC()
        payment.index = index
        navigationController?.pushViewController(payment, animated: true)
    }
    
    @objc func handleChooseWorkingHours()  {
        let payment = MainClinicWorkingHoursVC()
        payment.delgate = self
        payment.index = index
        navigationController?.pushViewController(payment, animated: true)
    }
}

extension ClinicDataVC: MainClinicWorkingHoursProtocol {
    
    func getHoursChoosed(hours: [String]) {
        let texts = hours.map{$0}.joined(separator: ",")
        
        customClinicDataView.waitingHoursTextField.text = texts
    }
    
    
    
}
