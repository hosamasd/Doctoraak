//
//  ClinicDataVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class MainClinicDataVC: CustomBaseViewVC {
    
    
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
        v.index = index
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
       
//        v.clinicWorkingHoursTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChooseWorkingHours)))
        v.clinicEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
        
        v.handleChooseHours = {[unowned self] in
            self.handleChooseWorkingHours()
        }
        //        v.cityDrop.addTarget(self, action: #selector(handleMulti), for: .touchUpInside)
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
      init(indexx:Int) {
          self.index = indexx
          super.init(nibName: nil, bundle: nil)
      }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
//        customClinicDataView.clinicWorkingHoursTextField.inputAccessoryView = UIView()
        
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customClinicDataView.clinicDataViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customClinicDataView.doneButton)
        }
        
        customClinicDataView.clinicDataViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                
            }else {
                //                SVProgressHUD.dismiss()
                //                self.activeViewsIfNoData()
            }
        })
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
    
    //TODO: -handle methods
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDone()  {
        
        
        let payment = MainPaymentVC(indexx: index)
        navigationController?.pushViewController(payment, animated: true)
    }
    
     func handleChooseWorkingHours()  {
        let payment = DoctorClinicWorkingHoursVC()
        payment.delgate = self
        navigationController?.pushViewController(payment, animated: true)
    }
    
    @objc func handleOpenGallery()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
   
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
}

//MARK:-Extension


extension MainClinicDataVC: MainClinicWorkingHoursProtocol {
    func getDays(indexs: [Int], days: [String]) {
        print(indexs,"              ",days)
    }
    
    func getHoursChoosed(hours: [[String : Any]]) {
        print(hours)
        customClinicDataView.clinicDataViewModel.workingArrayHours = hours
    }
    
    
//    func getHoursChoosed(hours: [String]) {
//        let texts = hours.map{$0}.joined(separator: ",")
//
//        customClinicDataView.clinicWorkingHoursTextField.text = texts
//    }
    
    
    
}



extension MainClinicDataVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customClinicDataView.clinicDataViewModel.image = img
            customClinicDataView.clinicProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customClinicDataView.clinicDataViewModel.image = img
            customClinicDataView.clinicProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customClinicDataView.clinicDataViewModel.image = nil
        dismiss(animated: true)
    }
    
    
}
