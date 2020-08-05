//
//  ExtensionsViews.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar


extension UIViewController {
    
    func showToast(context ctx: UIViewController, msg: String) {
           let la = UILabel(text: msg, font: .systemFont(ofSize: 16), textColor: .white, textAlignment: .center, numberOfLines: 0)
           let height = msg.getFrameForText(text: msg)
           la.constrainHeight(constant: height.height+20)
           la.constrainWidth(constant: view.frame.width)
           la.layer.cornerRadius=12
           la.clipsToBounds=true
           la.backgroundColor = UIColor.black
           ctx.view.addSubview(la)
           la.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 16, right: 0))
           UIView.animate(withDuration: 10.0, delay: 0.2,
                          options: .curveEaseOut, animations: {
                           la.alpha = 0.0
           }, completion: {(isCompleted) in
               la.removeFromSuperview()
           })
       }
    
    func showMainAlertErrorMessages(vv:UIViewController,secondV:CustomAlertLoginView,text:String)  {
       
              vv.addCustomViewInCenter(views: secondV, height: 200)
           secondV.discriptionInfoLabel.text = text
              secondV.problemsView.loopMode = .loop
              present(vv, animated: true)
          }
    
    func addCustomViewInCenter(views:UIView,height:CGFloat)  {
           
           view.addSubview(views)
           views.centerInSuperview(size: .init(width: view.frame.width-64, height: height))
           views.transform = .init(translationX: -1000, y: 0)
           UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
               views.transform = .identity
           })
       }
    
     func showMainAlertLooder(cc:UIViewController,v:CustomAlertMainLoodingView)  {
          cc.addCustomViewInCenter(views: v, height: 200)
          v.problemsView.loopMode = .loop
          present(cc, animated: true)
      }
    
    func removeViewWithAnimation(vvv:UIView) {
       DispatchQueue.main.async {
           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
               vvv.transform = .init(translationX: 10000, y: 0)
           }) { (_) in
               
               vvv.removeFromSuperview()
           }
       }
    }
    
    func removeGradientInSender(sender:UIButton)  {
              
              
              sender.setTitleColor(.black, for: .normal)
              removeSublayer(sender)
              sender.backgroundColor = ColorConstants.disabledButtonsGray
          }
    
    func addGradientInSenderAndRemoveOtherss(sender:UIButton)  {
          
          let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
          let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
          sender.applyGradient(colors: [leftColor,rightColor], index: 0)
       }
    
    func creatMainSnackBar(message:String)  {
          let messages = MDCSnackbarMessage()
          messages.text = message
          MDCSnackbarManager.show(messages)
      }
    
    func activeViewsIfNoData()  {
           DispatchQueue.main.async {
               UIApplication.shared.endIgnoringInteractionEvents()
           }
       }
    
    func addGradientInSenderAndRemoveOther(sender:UIButton,vv:UIButton)  {
        
        let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
        let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
        sender.applyGradient(colors: [leftColor,rightColor], index: 0)
        
        vv.setTitleColor(.black, for: .normal)
        removeSublayer(vv)
        vv.backgroundColor = ColorConstants.disabledButtonsGray
    }
    
    func addGradientInSenderAndRemoveOtherss(sender:UIButton,vvv:[UIButton])  {
        
        if sender.backgroundColor == nil {
               }else {
        let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
        let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
        sender.applyGradient(colors: [leftColor,rightColor], index: 0)
            sender.setTitleColor(.white, for: .normal)
        
        
        vvv.forEach { (vv) in
            if vv.backgroundColor == nil {
                removeSublayer(vv)
                vv.backgroundColor = ColorConstants.disabledButtonsGray
            }else {
                vv.backgroundColor = ColorConstants.disabledButtonsGray
            }
            vv.setTitleColor(.black, for: .normal)
        }
    }
    }
    
    // SWIFT 4 update
    func removeSublayer(_ view: UIView) {
        guard let sublayers = view.layer.sublayers else {
            print("The view does not have any sublayers.")
            return
        }
        if sublayers.count > 0 {
            view.layer.sublayers!.remove(at: 0)
            
        } else {
            print("There are not enough sublayers to remove that index.")
        }
    }
    
    func removeAllSublayer(_ view: UIView, layerIndex index: Int) {
        guard let sublayers = view.layer.sublayers else {
            print("The view does not have any sublayers.")
            return
        }
        if sublayers.count > index {
            view.layer.sublayers!.removeAll()
        } else {
            print("There are not enough sublayers to remove that index.")
        }
    }
    func changeButtonState(enable:Bool,vv:UIButton)  {
        
        
        if enable {
             if vv.backgroundColor != nil {
                vv.applyGradient(colors: [ColorConstants.firstColorBangsegy,ColorConstants.secondColorBangsegy], index: 0)
                vv.setTitleColor(.black, for: .normal)
                vv.isEnabled = true
            }
            
        }else {
            if vv.backgroundColor == nil {
                removeSublayer(vv)
                vv.backgroundColor =  ColorConstants.disabledButtonsGray
                vv.setTitleColor(.black, for: .normal)
                 vv.isEnabled = false
            }else {
                vv.setTitleColor(.black, for: .normal)
                vv.backgroundColor =  ColorConstants.disabledButtonsGray
                vv.isEnabled = false
            }
        }
    }
    
  
}
