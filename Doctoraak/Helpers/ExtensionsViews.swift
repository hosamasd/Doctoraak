//
//  ExtensionsViews.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func addGradientInSenderAndRemoveOther(sender:UIButton,vv:UIButton,index:Int? = 0)  {
        
        let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
        let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
        sender.applyGradient(colors: [leftColor,rightColor])
        removeSublayer(vv, layerIndex: index ?? 0)
//        vv.applyGradient(colors: [UIColor.clear.cgColor])
    }
    
    // SWIFT 4 update
    func removeSublayer(_ view: UIView, layerIndex index: Int) {
        guard let sublayers = view.layer.sublayers else {
            print("The view does not have any sublayers.")
            return
        }
        if sublayers.count > index {
            view.layer.sublayers!.remove(at: index)
        } else {
            print("There are not enough sublayers to remove that index.")
        }
    }
}
