//
//  MainNewPassVC.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class MainNewPassVC: CustomBaseViewVC {
    
    lazy var customMainNewPassView:CustomMainNewPassView = {
        let v = CustomMainNewPassView()
        v.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(text:)), for: .editingChanged)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))

        v.doneButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
      init(indexx:Int) {
          self.index = indexx
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let newPassViewModel = NewPassViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        newPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customMainNewPassView.doneButton)
        }
        
        newPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
        view.addSubview(customMainNewPassView)
        customMainNewPassView.fillSuperview()
        
    }
    
      //TODO: -handle methods
    
    @objc func textFieldDidChange(text: UITextField)  {
        newPassViewModel.index = index
        guard let texts = text.text else { return  }
        if let floatingLabelTextField = text as? SkyFloatingLabelTextField {
            if text == customMainNewPassView.confirmPasswordTextField {
                if text.text != customMainNewPassView.passwordTextField.text {
                    floatingLabelTextField.errorMessage = "Passowrd should be same".localized
                    newPassViewModel.confirmPassword = nil
                }
                else {
                    newPassViewModel.confirmPassword = texts
                    floatingLabelTextField.errorMessage = ""
                }
            }else
            {
                if(texts.count < 8 ) {
                    floatingLabelTextField.errorMessage = "password must have 8 character".localized
                    newPassViewModel.password = nil
                }
                else {
                    floatingLabelTextField.errorMessage = ""
                    newPassViewModel.password = texts
                }
            }
            
            
        }
    }
    
    @objc func handleNext()  {
        let login = MainLoginsVC(indexx: index)
        navigationController?.pushViewController(login, animated: true)
        
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
