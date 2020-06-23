////
////  DoctorProfileVC.swift
////  Doctoraak
////
////  Created by hosam on 3/28/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//import SkyFloatingLabelTextField
//
//class DoctorProfileVC: CustomBaseViewVC {
//    
//    
//    lazy var scrollView: UIScrollView = {
//        let v = UIScrollView()
//        v.backgroundColor = .clear
//        
//        return v
//    }()
//    lazy var mainView:UIView = {
//        let v = UIView(backgroundColor: .white)
//        v.constrainHeight(constant: 900)
//        v.constrainWidth(constant: view.frame.width)
//        return v
//    }()
//    lazy var customDoctorProfileView:CustomDoctorProfileView = {
//        let v = CustomDoctorProfileView()
//        v.cvView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenFiles)))
//        v.doctorEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenGallery)))
//        return v
//    }()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViewModelObserver()
//    }
//    
//    //MARK:-User methods
//    
//    func setupViewModelObserver()  {
//        customDoctorProfileView.doctorEdirProfileViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
//            guard let isValid = isValidForm else {return}
//            //            self.customLoginView.loginButton.isEnabled = isValid
//            
//            self.changeButtonState(enable: isValid, vv: self.customDoctorProfileView.nextButton)
//        }
//        
//        customDoctorProfileView.doctorEdirProfileViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
//            if isReg == true {
//                //                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
//                //                SVProgressHUD.show(withStatus: "Login...".localized)
//                
//            }else {
//                //                SVProgressHUD.dismiss()
//                //                self.activeViewsIfNoData()
//            }
//        })
//    }
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
//        //        mainView.fillSuperview()
//        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
//        mainView.addSubViews(views: customDoctorProfileView)
//        customDoctorProfileView.fillSuperview()
//        
//        
//        
//    }
//    
//    //TODO: -handle methods
//    
//    
//    @objc func handleOpenGallery()  {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true)
//    }
//    
//    @objc  func handleOpenFiles()  {
//        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
//        
//        documentPicker.delegate = self
//        present(documentPicker, animated: true, completion: nil)
//    }
//    
//}
//
//
////MARK:-Extension
//
//extension DoctorProfileVC : UIDocumentPickerDelegate {
//    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//        
//        let cico = url as URL
//        print(cico)
//        print(url)
//        
//        print(url.lastPathComponent)
//        
//        self.customDoctorProfileView.cvLabel.text = url.lastPathComponent
//        print(url.pathExtension)
//        
//    }
//}
//
//
//extension DoctorProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//        if let img = info[.originalImage]  as? UIImage   {
//            customDoctorProfileView.doctorEdirProfileViewModel.image = img
//            customDoctorProfileView.doctorProfileImage.image = img
//        }
//        if let img = info[.editedImage]  as? UIImage   {
//            customDoctorProfileView.doctorEdirProfileViewModel.image = img
//            customDoctorProfileView.doctorProfileImage.image = img
//        }
//        
//        
//        dismiss(animated: true)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        customDoctorProfileView.doctorEdirProfileViewModel.image = nil
//        dismiss(animated: true)
//    }
//    
//    
//}
