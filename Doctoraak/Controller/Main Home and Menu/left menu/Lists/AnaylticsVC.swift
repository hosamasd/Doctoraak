//
//  AnaylticsVC.swift
//  Doctoraak
//
//  Created by hosam on 6/17/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit
import WebKit
import MOLH

//let web = "http://doctoraak.com/public/mobile/mobile/radiology?radiology=$id&lang=$lang"
//let web2 = "http://doctoraak.com/public/mobile/mobile/lab?lab=$id&lang=$lang"
//let web3 = "http://doctoraak.com/public/mobile/mobile/pharmacy?pharmacy=$id&lang=$lang"
//let web4 = "http://doctoraak.com/public/mobile/doctor?doctor=$id&lang=$lang"
class AnaylticsVC: CustomBaseViewVC {
    
    
    lazy var customAnaylticsView:CustomAnaylticsView = {
        let v = CustomAnaylticsView()
        v.mainWebView.navigationDelegate = self
        v.backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        return v
    }()
    lazy var customAlertMainLoodingView:CustomAlertMainLoodingView = {
        let v = CustomAlertMainLoodingView()
        v.setupAnimation(name: "heart_loading")
        return v
    }()
    
    lazy var customMainAlertVC:CustomMainAlertVC = {
        let t = CustomMainAlertVC()
        t.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        t.modalTransitionStyle = .crossDissolve
        t.modalPresentationStyle = .overCurrentContext
        return t
    }()
    
    var doctor:DoctorModel?{
        didSet{
            guard let lab = doctor else { return  }
            let id = lab.id
            let url = "http://doctoraak.com/public/mobile/doctor?doctor=\(id)&lang="
            loadWebView(v: customAnaylticsView.mainWebView, url: url)
        }
    }
    var medicalCenter:DoctorModel?{
        didSet{
            guard let lab = medicalCenter else { return  }
            let id = lab.id
            let url = "http://doctoraak.com/public/mobile/doctor?doctor=\(id)&lang="
            loadWebView(v: customAnaylticsView.mainWebView, url: url)
        }
    }
    
    
    var lab:LabModel?{
        didSet{
            guard let lab = lab else { return  }
            customAnaylticsView.lab=lab
            let id = lab.id
            let url = "http://doctoraak.com/public/mobile/lab?lab=\(id)&lang="
            loadWebView(v: customAnaylticsView.mainWebView, url: url)
        }
    }
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy else { return  }
            customAnaylticsView.phy=phy
            
            let id = phy.id
            let url = "http://doctoraak.com/public/mobile/pharmacy?pharmacy=\(id)&lang="
            loadWebView(v: customAnaylticsView.mainWebView, url: url)
        }
    }
    var rad:RadiologyModel?{
        didSet{
            guard let lab = rad else { return  }
            customAnaylticsView.rad=lab
            
            let id = lab.id
            let url = "http://doctoraak.com/public/mobile/radiology?radiology=\(id)&lang="
            loadWebView(v: customAnaylticsView.mainWebView, url: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.showMainAlertLooder(cc: customMainAlertVC, v: customAlertMainLoodingView)
    }
    
    override func setupNavigation()  {
        navigationController?.navigationBar.isHide(true)
    }
    
    override func setupViews()  {
        view.addSubview(customAnaylticsView)
        customAnaylticsView.fillSuperview()
        
    }
    
    fileprivate func loadWebView(v:WKWebView,url:String)  {
        let urls = MOLHLanguage.isRTLLanguage()  ? "\(url)ar" : "\(url)en"
        
        if  let myURL =   URL(string:urls.toSecrueHttps()) {
            let myRequest = URLRequest(url: myURL )
            v.load(myRequest)
        }
    }
    
    //TODO: -handle methods
    
    
    @objc func handleBack()  {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDismiss()  {
        removeViewWithAnimation(vvv: customAlertMainLoodingView)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK:-extension


extension AnaylticsVC :WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        handleDismiss();self.activeViewsIfNoData()
    }
}
