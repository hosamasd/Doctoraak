//
//  ViewController.swift
//  Doctoraak
//
//  Created by Ahmad Eisa on 3/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginBtn: CustomButton!
    @IBOutlet weak var signUpBtn: CustomButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barStyle = .black
        
    }
    
    


}

