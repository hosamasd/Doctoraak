//
//  MainForgetPasswordVC.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class MainForgetPasswordVC: CustomBaseViewVC {
    
    
    
    lazy var customMainForgetPassView:CustomMainForgetPassView = {
        let v = CustomMainForgetPassView()
        v.numberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.nextButton.addTarget(self, action: #selector(handleDonePayment), for: .touchUpInside)
        return v
    }()
    
    var index:Int = 0
    let forgetPassViewModel = ForgetPassViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        forgetPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customMainForgetPassView.nextButton)
        }
        
        forgetPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        view.addSubview(customMainForgetPassView)
        customMainForgetPassView.fillSuperview()
        
    }
    
    //TODO: -handle methods
    
    @objc func textFieldDidChange(text: UITextField)  {
        forgetPassViewModel.index = index
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if  !texts.isValidPhoneNumber    {
                floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                forgetPassViewModel.phone = nil
            }
            else {
                floatingLabelTextField.errorMessage = ""
                forgetPassViewModel.phone = texts
            }
            
            
        }
    }
    
    @objc func handleDonePayment()  {
        let verifiy = MainVerificationVC()
        verifiy.index = index
        verifiy.isFromForgetPassw = true
        navigationController?.pushViewController(verifiy, animated: true)
        
        print(999)
    }
}
