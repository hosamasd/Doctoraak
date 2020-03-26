//
//  ClinicPaymentVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class MainPaymentVC: CustomBaseViewVC {
    
    lazy var customClinicPaymentView:CustomMainPaymentView = {
        let v = CustomMainPaymentView()
        v.numberTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.codeTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.doneButton.addTarget(self, action: #selector(handleDonePayment), for: .touchUpInside)
        return v
    }()
    
      var index:Int = 0
    let paymentViewModel = PaymentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        paymentViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customClinicPaymentView.doneButton)
        }
        
        paymentViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        view.addSubview(customClinicPaymentView)
        customClinicPaymentView.fillSuperview()
        
    }
    
    @objc func textFieldDidChange(text: UITextField)  {
        paymentViewModel.index = index
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customClinicPaymentView.numberTextField {
                if  !texts.isValidPhoneNumber    {
                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
                    paymentViewModel.vodafoneVode = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    paymentViewModel.vodafoneVode = texts
                }
                
            }else
                if(texts.count < 6 ) {
                    floatingLabelTextField.errorMessage = "code must have 6 character".localized
                    paymentViewModel.fawryCode = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    paymentViewModel.fawryCode = texts
                    
            }
        }
    }
    
   @objc func handleDonePayment()  {
        print(999)
    }
}
