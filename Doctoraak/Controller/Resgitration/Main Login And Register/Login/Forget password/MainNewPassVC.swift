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
        v.index = index
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelObserver()
    }
    
    //MARK:-User methods
    
    func setupViewModelObserver()  {
        customMainNewPassView.newPassViewModel.bindableIsFormValidate.bind { [unowned self] (isValidForm) in
            guard let isValid = isValidForm else {return}
            //            self.customLoginView.loginButton.isEnabled = isValid
            
            self.changeButtonState(enable: isValid, vv: self.customMainNewPassView.doneButton)
        }
        
        customMainNewPassView.newPassViewModel.bindableIsLogging.bind(observer: {  [unowned self] (isReg) in
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
    
  
    
    @objc func handleNext()  {
        let login = MainLoginsVC(indexx: index)
        navigationController?.pushViewController(login, animated: true)
        
    }
    
    @objc func handleBack()  {
        navigationController?.popViewController(animated: true)
    }
}
