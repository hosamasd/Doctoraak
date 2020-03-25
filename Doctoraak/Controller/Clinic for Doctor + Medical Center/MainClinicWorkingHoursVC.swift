//
//  ClinicWorkingHoursVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

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
//       v.first2TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.first1TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.second1TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.second2TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.third1TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.third2TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//
//        v.forth1TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.forth2TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//
//        v.fifth1TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.fifth2TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//
//        v.sexth1TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.sexth2TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//
//        v.seventh1TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
//        v.seventh2TextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))
        [v.first2TextField,v.first1TextField,v.second1TextField,v.second2TextField,v.third1TextField,v.third2TextField,v.forth1TextField,v.forth2TextField,v.fifth1TextField,v.fifth2TextField,v.sexth1TextField,v.sexth2TextField,v.seventh2TextField,v.seventh1TextField].forEach({$0
            .addTarget(self, action:#selector(handleShowPicker), for: UIControl.Event.editingDidBegin)})
//            .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowPicker)))})
        

        return v
    }()
      var index:Int? = 0
       let timeSelector = TimeSelector()
    
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
    
    func updateTextField(text:UITextField,texts:String)  {

        switch text{
        case customClinicWorkingHoursView.first1TextField:
           customClinicWorkingHoursView.first1TextField.text = texts
        case customClinicWorkingHoursView.first2TextField:
            customClinicWorkingHoursView.first2TextField.text = texts
        case customClinicWorkingHoursView.second1TextField:
            customClinicWorkingHoursView.second1TextField.text = texts
        case customClinicWorkingHoursView.second2TextField:
             customClinicWorkingHoursView.second2TextField.text = texts
        case customClinicWorkingHoursView.third1TextField:
             customClinicWorkingHoursView.third1TextField.text = texts
        case customClinicWorkingHoursView.third2TextField:
            customClinicWorkingHoursView.third2TextField.text = texts
        case customClinicWorkingHoursView.forth1TextField:
            customClinicWorkingHoursView.forth1TextField.text = texts
        case customClinicWorkingHoursView.forth2TextField:
            customClinicWorkingHoursView.forth2TextField.text = texts
        case customClinicWorkingHoursView.fifth1TextField:
            customClinicWorkingHoursView.fifth1TextField.text = texts
        case customClinicWorkingHoursView.fifth2TextField:
            customClinicWorkingHoursView.fifth2TextField.text = texts
        case customClinicWorkingHoursView.sexth2TextField:
            customClinicWorkingHoursView.sexth2TextField.text = texts
        case customClinicWorkingHoursView.sexth1TextField:
            customClinicWorkingHoursView.sexth1TextField.text = texts
        case customClinicWorkingHoursView.seventh1TextField:
            customClinicWorkingHoursView.seventh1TextField.text = texts
        default:
            customClinicWorkingHoursView.seventh2TextField.text = texts
        }

    }
    
    func updateTextField(tag:Int,texts:String)  {

        switch tag{
        case 1:
            customClinicWorkingHoursView.first1TextField.text = texts
        case 11:
            customClinicWorkingHoursView.first2TextField.text = texts
        case 2:
            customClinicWorkingHoursView.second1TextField.text = texts
        case 22:
            customClinicWorkingHoursView.second2TextField.text = texts
        case 3:
            customClinicWorkingHoursView.third1TextField.text = texts
        case 33:
            customClinicWorkingHoursView.third2TextField.text = texts
        case 4:
            customClinicWorkingHoursView.forth1TextField.text = texts
        case 44:
            customClinicWorkingHoursView.forth2TextField.text = texts
        case 5:
            customClinicWorkingHoursView.fifth1TextField.text = texts
        case 55:
            customClinicWorkingHoursView.fifth2TextField.text = texts
        case 6:
            customClinicWorkingHoursView.sexth2TextField.text = texts
        case 66:
            customClinicWorkingHoursView.sexth1TextField.text = texts
        case 7:
            customClinicWorkingHoursView.seventh1TextField.text = texts
        default:
            customClinicWorkingHoursView.seventh2TextField.text = texts
        }

    }
    
//    @objc func handleShowPicker(tag:Int) {
//        var texts = ""
//        let cc = Calendar.current
//
//        setupTimeSelector(timeSelector)
//        timeSelector.timeSelected = {[unowned self] (timeSelector) in
//            print(timeSelector.date)
//            let dd = timeSelector.date
//
//            let hour = cc.component(.hour, from: dd)
//            let minute = cc.component(.minute, from: dd)
//            texts = "\(hour):\(minute)"
//            DispatchQueue.main.async {
//                //                self.customClinicWorkingHoursView.first1TextField.text = "\(hour):\(minute)"
//                                self.updateTextField(tag: tag, texts: texts)
////                self.updateTextField(text: textField, texts: texts)
//            }
//        }
//
//    }
    
    @objc func handleShowPicker(textField:UITextField) {
        var texts = ""
         let cc = Calendar.current

        setupTimeSelector(timeSelector)
        timeSelector.timeSelected = {[unowned self] (timeSelector) in
            print(timeSelector.date)
            let dd = timeSelector.date

            let hour = cc.component(.hour, from: dd)
            let minute = cc.component(.minute, from: dd)
            texts = "\(hour):\(minute)"
            DispatchQueue.main.async {
//                self.customClinicWorkingHoursView.first1TextField.text = "\(hour):\(minute)"
//                self.updateTextField(tag: textField.tag, texts: texts)
self.updateTextField(text: textField, texts: texts)
            }
        }

    }
}
