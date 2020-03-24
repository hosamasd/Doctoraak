//
//  WelcomeMainSecondVC.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class WelcomeMainSecondVC: CustomBaseViewVC {
    
    
    
    lazy var customWelcomeMainSecondView:CustomWelcomeMainSecondView = {
        let v = CustomWelcomeMainSecondView()
        v.mainFirstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMedicalCenter)))
         v.main2View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDoctor)))
         v.main3View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLab)))
         v.main4View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRadiology)))
         v.main5View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePharamacy)))
        return v
    }()
    
    override func setupViews() {
        
        view.addSubview(customWelcomeMainSecondView)
        customWelcomeMainSecondView.fillSuperview()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
   @objc func handleMedicalCenter()  {
    let secondwelcome = SecondWelcomeVC()
    secondwelcome.index = 0
    navigationController?.pushViewController(secondwelcome, animated: true)
    }
    
    @objc func handleDoctor()  {
        let secondwelcome = SecondWelcomeVC()
        secondwelcome.index = 1
        navigationController?.pushViewController(secondwelcome, animated: true)
    }
    
    @objc func handleLab()  {
        let secondwelcome = SecondWelcomeVC()
        secondwelcome.index = 2
        navigationController?.pushViewController(secondwelcome, animated: true)
    }
    
    @objc func handlePharamacy()  {
        let secondwelcome = SecondWelcomeVC()
        secondwelcome.index = 4
        navigationController?.pushViewController(secondwelcome, animated: true)
    }
    
    @objc func handleRadiology()  {
        let secondwelcome = SecondWelcomeVC()
        secondwelcome.index = 3
        navigationController?.pushViewController(secondwelcome, animated: true)
    }
}
