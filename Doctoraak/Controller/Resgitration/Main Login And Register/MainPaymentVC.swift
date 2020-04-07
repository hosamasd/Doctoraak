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
        v.index = index
        v.doneButton.addTarget(self, action: #selector(handleDonePayment), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
//        [v.firstScrollButton,v.secondScrollButton].forEach({$0.addTarget(self, action: #selector(handleChoosedButton), for: .touchUpInside)})
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
      init(indexx:Int) {
          self.index = indexx
          super.init(nibName: nil, bundle: nil)
      }
    
   
//    let paymentViewModel = PaymentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customClinicPaymentView.paymentViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customClinicPaymentView.doneButton)
        }
        
        customClinicPaymentView.paymentViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
    
//    func hideOrUnhide(tag:Int)  {
//        DispatchQueue.main.async {[unowned self] in
//            
//            
//            self.customClinicPaymentView.vodafoneImage.isHide(tag == 1 ? false : true)
//            self.customClinicPaymentView.fawryImage.isHide(tag == 1 ? true : false)
//            self.customClinicPaymentView.numberTextField.isHide(tag == 1 ? false : true)
//            self.customClinicPaymentView.codeTextField.isHide(tag == 1 ? true : false)
//            //            self.num.rightViewMode = tag == 1 ? .always : .never
//        }
//    }
    
    //TODO: -handle methods
    
//    @objc func textFieldDidChange(text: UITextField)  {
//        paymentViewModel.index = index
//        guard let texts = text.text else { return  }
//        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
//            if text == customClinicPaymentView.numberTextField {
//                if  !texts.isValidPhoneNumber    {
//                    floatingLabelTextField.errorMessage = "Invalid   Phone".localized
//                    paymentViewModel.vodafoneVode = nil
//                }
//                else {
//                    floatingLabelTextField.errorMessage = ""
//                    paymentViewModel.vodafoneVode = texts
//                }
//
//            }else
//                if(texts.count < 6 ) {
//                    floatingLabelTextField.errorMessage = "code must have 6 character".localized
//                    paymentViewModel.fawryCode = nil
//                }
//                else {
//                    floatingLabelTextField.errorMessage = ""
//                    paymentViewModel.fawryCode = texts
//
//            }
//        }
//    }
    
    @objc func handleDonePayment()  {
        print(999)
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
    
//    @objc func handleChoosedButton(sender:UIButton)  {
//        [customClinicPaymentView.firstScrollButton,customClinicPaymentView.secondScrollButton].forEach({$0.setImage(#imageLiteral(resourceName: "Ellipse 129"), for: .normal)})
//        
//        sender.setImage( #imageLiteral(resourceName: "Ellipse 128"), for: .normal)
//        switch sender.tag {
//        case 1:
//            hideOrUnhide(tag: 1)
//        default:
//            hideOrUnhide(tag: 2)
//        }
//        [customClinicPaymentView.codeTextField,customClinicPaymentView.numberTextField].forEach({$0.text = ""})
//        customClinicPaymentView.paymentViewModel.fawryCode = nil
//        customClinicPaymentView.paymentViewModel.vodafoneVode = nil
//    }
    
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
