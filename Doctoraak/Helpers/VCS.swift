//
//  VCS.swift
//  MapKitSwiftUI
//
//  Created by hosam on 6/21/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit
import MapKit

extension UICollectionView{
    
   func noDataFound(_ dataCount:Int,text:String){
           if dataCount <=  0 {
               
               let label = UILabel()
               label.frame = self.frame
               label.frame.origin.x = 0
               label.frame.origin.y = 0
               label.textAlignment = .center
               label.textColor = .black
               label.text =  text
               self.backgroundView = label
           }else{
               self.backgroundView = nil
           }
       }
    
}


extension UIViewController {
    
    func convertLatLongToAddress(latitude: Double, longitude: Double, completion: @escaping (_ answer: String?) -> Void) {
              
              let coordinates = CLLocation(latitude: latitude, longitude: longitude)
              
              CLGeocoder().reverseGeocodeLocation(coordinates, completionHandler: {(placemarks, error) -> Void in
                  guard let   placeMark = placemarks?[0] else {return }
                  guard  let street = placeMark.subLocality, let city = placeMark.administrativeArea, let country = placeMark.country else { completion(placeMark.locality );return }
                  let ans =  street+" - "+city+" - "+country
                  completion(ans)
              })
           }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
    
    func getStack(views: UIView...,spacing:CGFloat,distribution:UIStackView.Distribution,axis:NSLayoutConstraint.Axis) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.spacing = spacing
        stack.distribution = distribution
        stack.axis = axis
        return stack
        
    }
}
