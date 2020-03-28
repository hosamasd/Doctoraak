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
            .addTarget(self, action:#selector(handleShowPicker), for: UIControl.Event.editingDidBegin)})
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
        choosedHours.append(texts)
    }
    
    
    
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
                self.updateTextField(text: textField, texts: texts)
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
