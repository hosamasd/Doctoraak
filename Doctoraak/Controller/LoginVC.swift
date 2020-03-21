//
//  LoginVC.swift
//  Doctoraak
//
//  Created by Ahmad Eisa on 3/11/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {


    @IBOutlet weak var phoneNumbre: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    
    
    func setUPPasswordTextField(){
        

        
    }
    
    
    @IBAction func hideShowPassword(_ sender: Any) {
        
        if passwordTxt.isSecureTextEntry {
            
            passwordTxt.isSecureTextEntry = false
        }else{
            passwordTxt.isSecureTextEntry = true
        }
        
        
        
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
      
        
    }
    

}
