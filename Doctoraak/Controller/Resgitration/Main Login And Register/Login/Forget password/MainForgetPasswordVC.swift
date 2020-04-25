//
//  MainForgetPasswordVC.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SVProgressHUD
import MOLH

class MainForgetPasswordVC: CustomBaseViewVC {
    
    
    
    lazy var customMainForgetPassView:CustomMainForgetPassView = {
        let v = CustomMainForgetPassView()
        v.index = index
        v.nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
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
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customMainForgetPassView.forgetPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customMainForgetPassView.nextButton)
        }
        
        customMainForgetPassView.forgetPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
            if isReg == true {
                                UIApplication.shared.beginIgnoringInteractionEvents() // disbale all events in the screen
                                SVProgressHUD.show(withStatus: "Checking Phone...".localized)
                
            }else {
                                SVProgressHUD.dismiss()
                                self.activeViewsIfNoData()
            }
        })
    }
    
    override  func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(customMainForgetPassView)
        customMainForgetPassView.fillSuperview()
        
    }
    
    func goToNext()  {
        let verifiy = MainVerificationVC(indexx: index,isFromForgetPassw: true, phone: customMainForgetPassView.forgetPassViewModel.phone ?? "")
               navigationController?.pushViewController(verifiy, animated: true)
               
               print(999)
    }
    
    //TODO: -handle methods
    
   
    @objc func handleNext()  {
                customMainForgetPassView.forgetPassViewModel.performLogging { [unowned self] (base,err) in
                if let err = err {
                    SVProgressHUD.showError(withStatus: err.localizedDescription)
                    self.activeViewsIfNoData();return
                }
                SVProgressHUD.dismiss()
                self.activeViewsIfNoData()
                    guard let user = base?.data else {SVProgressHUD.showError(withStatus: MOLHLanguage.isRTLLanguage() ? base?.message : base?.messageEn); return}
        //        self.saveToken(token: user.apiToken)
                
                DispatchQueue.main.async {
                    self.goToNext()
                }
                }
     }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
}
