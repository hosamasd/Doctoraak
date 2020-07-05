//
//  DoctorProfileVC.swift
//  Doctoraak
//
//  Created by hosam on 6/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SVProgressHUD
import MOLH

class DoctorProfileVC:   CustomBaseViewVC {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .clear
        
        return v
    }()
    lazy var mainView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.constrainHeight(constant: 1200)
        v.constrainWidth(constant: view.frame.width)
        return v
    }()
    
    lazy var customDoctorProfileView:CustomDoctorProfileView = {
        let v = CustomDoctorProfileView()
        
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        v.userEditProfileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createAlertForChoposingImage)))
        v.nextButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        v.cvView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUpload)))
        return v
    }()
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    
    var doc:DoctorModel?{
        didSet{
            guard let phy = doc else { return  }
            customDoctorProfileView.doc=phy
        }
    }
    
    
    fileprivate let index:Int!
    init(index:Int) {
        self.index=index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
        
    }
    
    //TODO: -User methods
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    
    
    override func setupViews()  {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(mainView)
        mainView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,padding: .init(top: -60, left: 0, bottom: 0, right: 0))
        mainView.addSubViews(views: customDoctorProfileView)
        customDoctorProfileView.fillSuperview()
        
    }
    
    fileprivate func setupViewModelObserver()  {
        customDoctorProfileView.edirProfileViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customDoctorProfileView.nextButton)
        }
        
        customDoctorProfileView.edirProfileViewModel.bindableIsResgiter.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                //                SVProgressHUD.show(withStatus: "Login...".localized)
                self.showMainAlertLooder(cc: self.customMainAlertVC, v: self.customAlertMainLoodingView)
                
            }else {
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
            }
        })
    }
    
    fileprivate func handleOpenGallery(sourceType:UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    
    fileprivate func cachedATA(_ patient:DoctorModel? = nil)  {
        patient != nil ?    cacheDoctorObjectCodabe.save(patient!) : ()
    }
    
    fileprivate  func checkRadLoginState()  {
        
        
        
        customDoctorProfileView.edirProfileViewModel.performUpdating { (base, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                               self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //            SVProgressHUD.dismiss()
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
            self.cachedATA(user)
            DispatchQueue.main.async {
                self.showToast(context: self, msg: "your information updated...".localized)
            }
        }
    }
    
    fileprivate func uploadCV()  {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
        
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    fileprivate func handleDownload()  {
        guard let doc = doc else { return  }
        let urlString = doc.cv
        guard let url = URL(string: urlString) else { return  }
        self.showMainAlertLooder(cc: customMainAlertVC, v: customAlertMainLoodingView)
        DownloadCVServices.shared.loadAndDownloadCVFile(url: url) { (path, err) in
            if let err = err {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                //                               self.showMainAlertErrorMessages(vv: self.customMainAlertVC, secondV: self.customAlertLoginView, text: err.localizedDescription)
                self.handleDismiss()
                self.activeViewsIfNoData();return
            }
            //            SVProgressHUD.dismiss()
            self.handleDismiss()
            
            self.activeViewsIfNoData()
            guard let path = path else {return}
            DispatchQueue.main.async {
                self.showToast(context: self, msg: path)
            }
        }
        
    }
    
    //TODO: -handle methods
    
    @objc func createAlertForChoposingImage()  {
        let alert = UIAlertController(title: "Choose Image".localized, message: "Choose image fROM ".localized, preferredStyle: .alert)
        let camera = UIAlertAction(title: "Camera".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .camera)
            
        }
        let gallery = UIAlertAction(title: "Open From Gallery".localized, style: .default) {[unowned self] (_) in
            self.handleOpenGallery(sourceType: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_) in
            alert.dismiss(animated: true)
        }
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func handleBack()  {
        dismiss(animated: true)
        //        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleSave()  {
        checkRadLoginState()
    }
    
    
    @objc func handleUpload()  {
        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Upload".localized, style: .destructive) { (_) in
            self.uploadCV()
        }
        
        let download = UIAlertAction(title: "Download".localized, style: .default) { (_) in
            self.handleDownload()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(delete)
        alert.addAction(download)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

//MARK:-extension

extension DoctorProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let img = info[.originalImage]  as? UIImage   {
            customDoctorProfileView.edirProfileViewModel.image = img
            customDoctorProfileView.userProfileImage.image = img
        }
        if let img = info[.editedImage]  as? UIImage   {
            customDoctorProfileView.edirProfileViewModel.image = img
            customDoctorProfileView.userProfileImage.image = img
        }
        
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        customDoctorProfileView.edirProfileViewModel.image = nil
        dismiss(animated: true)
    }
    
    
    
    
}

//MARK:-extension


extension DoctorProfileVC : UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let cico = url as URL
        
        self.customDoctorProfileView.cvLabel.text = url.lastPathComponent
        self.customDoctorProfileView.edirProfileViewModel.cvName = url.lastPathComponent
        do {
            //                let imageData = try Data(contentsOf: cico as URL)
            try  self.customDoctorProfileView.edirProfileViewModel.cvFile = Data(contentsOf: cico)
        } catch {
            print("Unable to load data:".localized+" \(error)")
        }
    }
}
