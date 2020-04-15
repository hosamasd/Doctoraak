//
//  ClinicWorkingHoursVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

protocol MainClinicWorkingHoursProtocol {
    func getHoursChoosed(hours:[String])
}

class MainClinicWorkingHoursVC: CustomBaseViewVC {
    
    
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
    lazy var customClinicWorkingHoursView:CustomMainClinicWorkingHoursView = {
        let v = CustomMainClinicWorkingHoursView()
        [v.first2TextField,v.first1TextField,v.second1TextField,v.second2TextField,v.third1TextField,v.third2TextField,v.forth1TextField,v.forth2TextField,v.fifth1TextField,v.fifth2TextField,v.sexth1TextField,v.sexth2TextField,v.seventh2TextField,v.seventh1TextField].forEach({$0
            .addTarget(self, action:#selector(handleShowPicker), for: .touchUpInside)})
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
       

        return v
    }()
    var index:Int? = 0
    let timeSelector = TimeSelector()
    var delgate:MainClinicWorkingHoursProtocol?
    var choosedHours = [String]()
    
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customClinicWorkingHoursView)
        customClinicWorkingHoursView.fillSuperview()
        
        
        
    }
    
    
    fileprivate func setupTimeSelector(_ timeSelector: TimeSelector) {
        timeSelector.overlayAlpha = 0.8
        timeSelector.clockTint = timeSelector_rgb(0, 230, 0)
        timeSelector.minutes = 30
        timeSelector.hours = 5
        timeSelector.isAm = false
        timeSelector.presentOnView(view: self.view)
    }
    
    func updateTextField(tag:Int,texts:String)  {
           
           switch tag{
           case 1:
            customClinicWorkingHoursView.first1TextField.setTitle(texts, for: .normal)
           case 11:
               customClinicWorkingHoursView.first2TextField.setTitle(texts, for: .normal)
           case 2:
               customClinicWorkingHoursView.second1TextField.setTitle(texts, for: .normal)
           case 22:
               customClinicWorkingHoursView.second2TextField.setTitle(texts, for: .normal)
           case 3:
               customClinicWorkingHoursView.third1TextField.setTitle(texts, for: .normal)
           case 33:
               customClinicWorkingHoursView.third2TextField.setTitle(texts, for: .normal)
           case 4:
               customClinicWorkingHoursView.forth1TextField.setTitle(texts, for: .normal)
           case 44:
               customClinicWorkingHoursView.forth2TextField.setTitle(texts, for: .normal)
           case 5:
               customClinicWorkingHoursView.fifth1TextField.setTitle(texts, for: .normal)
           case 55:
               customClinicWorkingHoursView.fifth2TextField.setTitle(texts, for: .normal)
           case 6:
               customClinicWorkingHoursView.sexth2TextField.setTitle(texts, for: .normal)
           case 66:
               customClinicWorkingHoursView.sexth1TextField.setTitle(texts, for: .normal)
           case 7:
               customClinicWorkingHoursView.seventh1TextField.setTitle(texts, for: .normal)
           default:
               customClinicWorkingHoursView.seventh2TextField.setTitle(texts, for: .normal)
           }
           choosedHours.append(texts)
       }
    
    @objc func handleShowPicker(sender:UIButton) {
           var texts = ""
           let cc = Calendar.current
           var ppp = "am"
           
           setupTimeSelector(timeSelector)
           timeSelector.timeSelected = {[unowned self] (timeSelector) in
               print(timeSelector.date)
               let dd = timeSelector.date
               
               var hour = cc.component(.hour, from: dd)
                ppp = hour > 12 ? "pm" : "am"
               hour =   hour > 12 ? hour - 12 : hour
              
               let minute = cc.component(.minute, from: dd)
               texts = "\(hour):\(minute) \(ppp)"
               DispatchQueue.main.async {
                self.updateTextField(tag: sender.tag, texts: texts)
               }
           }
       }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDone()  {
        delgate?.getHoursChoosed(hours: choosedHours)
        navigationController?.popViewController(animated: true)
    }
}
