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
    
    lazy var views = [
     customWelcomeMainSecondView.main2View,customWelcomeMainSecondView.main3View,customWelcomeMainSecondView.main4View,customWelcomeMainSecondView.main5View,customWelcomeMainSecondView.mainFirstView
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    
    //MARK: -user methods
    
    override func setupViews() {
        
        view.addSubview(customWelcomeMainSecondView)
        customWelcomeMainSecondView.fillSuperview()
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    fileprivate func setupAnimation()  {
        views.forEach({$0.alpha = 1})
        let translateButtons = CGAffineTransform.init(translationX: -1000, y: 0)
         let translatesButtons = CGAffineTransform.init(translationX: 1000, y: 0)
        [customWelcomeMainSecondView.mainFirstView,customWelcomeMainSecondView.main3View,customWelcomeMainSecondView.main5View].forEach({$0.transform = translateButtons})
       [customWelcomeMainSecondView.main2View,customWelcomeMainSecondView.main4View].forEach({$0.transform = translatesButtons})
        UIView.animate(withDuration: 0.7, delay: 0.6 * 1.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.views.forEach({$0.transform = .identity})
        
        })
    }
    
    //TODO: -handle methods
    
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
