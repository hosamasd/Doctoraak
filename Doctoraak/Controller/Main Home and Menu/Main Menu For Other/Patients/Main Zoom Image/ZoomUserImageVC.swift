//
//  ZoomUserImageVC.swift
//  Doctoraak
//
//  Created by Hossam on 7/11/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit

class ZoomUserImageVC: CustomBaseViewVC {
    
    lazy var mainImageView:UIImageView = {
        let i = UIImageView(image: img)
        i.contentMode = .scaleAspectFill
        i.enableZoom()
        return i
    }()
    fileprivate let img:UIImage!
    
    init(img:UIImage) {
        self.img = img
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(false)
        let label = UILabel(text: "Preview".localized, font: .systemFont(ofSize: 20), textColor: .black)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "×-2").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleClose))
    }
    
    override func setupViews()  {
        view.backgroundColor = .white
        
        view.addSubViews(views: mainImageView)
        
        mainImageView.centerInSuperview(size: .init(width: view.frame.width, height: 250))
    }
    
    
    
    //TODO:-Hnadle methods
    
    @objc  func handleClose()  {
        navigationController?.popViewController(animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
