//
//  ExtensionsViews.swift
//  Doctoraak
//
//  Created by hosam on 3/23/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import RSSelectionMenu


extension UIViewController {
    
    func addGradientInSenderAndRemoveOther(sender:UIButton,vv:UIButton,index:Int? = 0)  {
        
        let leftColor = #colorLiteral(red: 0.4747212529, green: 0.2048208416, blue: 1, alpha: 1).cgColor
        let rightColor = #colorLiteral(red: 0.7187242508, green: 0.5294578671, blue: 0.9901599288, alpha: 1).cgColor
        sender.applyGradient(colors: [leftColor,rightColor], index: 0)
        
        vv.setTitleColor(.black, for: .normal)
        removeSublayer(vv, layerIndex: index ?? 0)
        vv.backgroundColor = ColorConstants.disabledButtonsGray
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
                removeSublayer(vv, layerIndex: 0)
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
    
    func showBottomSheet(fromBarButton barButton: UIButton) {
        let dataArray = ["Sachin Tendulkar", "Rahul Dravid", "Saurav Ganguli", "Virat Kohli", "Suresh Raina", "Ravindra Jadeja", "Chris Gyle", "Steve Smith", "Anil Kumble"]

        /// Register custom cell class
        
        let menu = RSSelectionMenu(dataSource: dataArray) { (cell, i, index) in
            print(cell,i,index)
        }
        
    
        // Unique property in BottomSheetAction
        menu.uniquePropertyName = "title"
        
        // on selection
      
        
        // customization
        menu.tableView?.rowHeight = 50
        menu.tableView?.isScrollEnabled = false
        
        // height
        menu.showBottomSheet(fromBarButton: barButton)
    }
}
