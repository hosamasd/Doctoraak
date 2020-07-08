//
//  SecondWelcomeVC.swift
//  Doctoraak
//
//  Created by hosam on 3/22/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class SecondWelcomeVC: CustomBaseViewVC {
    
    lazy var customSecondWelcomeView:CustomSecondWelcomeView = {
        let v = CustomSecondWelcomeView()
        v.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        v.registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        return v
    }()
    
    //check to go specific way
    fileprivate let index:Int!
    init(inde:Int) {
        self.index = inde
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    //MARK: -user methods
    
    override func setupViews() {
        view.addSubview(customSecondWelcomeView)
        customSecondWelcomeView.fillSuperview()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    fileprivate func goToLoginNextVC(index:Int) {
        let medical = MainLoginsVC(indexx: index)
        navigationController?.pushViewController(medical, animated: true)
    }
    
    fileprivate func goToRegisterNextVC(index:Int) {
        let doctor = DoctorRegisterVC(indexx: index)
        let medical = MainRegisterVC(indexx: index)
        let vc = index == 0 || index == 1 ? doctor : medical
        
        navigationController?.pushViewController( vc, animated: true)
    }
    
    //TODO: -handle methods
    
    @objc func handleLogin()  {
        goToLoginNextVC(index: index )
    }
    
    @objc func handleRegister()  {
        goToRegisterNextVC(index: index )
    }
    
    @objc func handleBack()  {
        
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
