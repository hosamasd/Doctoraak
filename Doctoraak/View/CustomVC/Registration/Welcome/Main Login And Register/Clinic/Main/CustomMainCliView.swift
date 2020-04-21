//
//  CustomMainCliView.swift
//  Doctoraak
//
//  Created by hosam on 4/21/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class CustomMainCliView: CustomBaseView {
    
    lazy var first1TextField = createHoursButtons(tags: 1)
       lazy var first2TextField = createHoursButtons(tags: 11)
       
       lazy var second1TextField = createHoursButtons(tags: 2)
       lazy var second2TextField = createHoursButtons(tags: 22)
       
       lazy var third1TextField = createHoursButtons(tags: 3)
       lazy var third2TextField = createHoursButtons(tags: 33)
       
       lazy var forth1TextField = createHoursButtons(tags: 4)
       lazy var forth2TextField = createHoursButtons(tags: 44)
       
       lazy var fifth1TextField = createHoursButtons(tags: 5)
       lazy var fifth2TextField = createHoursButtons(tags: 55)
       
       lazy var sexth1TextField = createHoursButtons(tags: 6)
       lazy var sexth2TextField = createHoursButtons(tags: 66)
       
       lazy var seventh1TextField = createHoursButtons(tags: 7)
       lazy var seventh2TextField = createHoursButtons(tags: 77)
    
//    lazy var first1TextField = createHoursButtons(tags: 21)
//    lazy var first2TextField = createHoursButtons(tags: 211)
//
//    lazy var second1TextField = createHoursButtons(tags: 22)
//    lazy var second2TextField = createHoursButtons(tags: 222)
//
//    lazy var third1TextField = createHoursButtons(tags: 23)
//    lazy var third2TextField = createHoursButtons(tags: 233)
//
//    lazy var forth1TextField = createHoursButtons(tags: 24)
//    lazy var forth2TextField = createHoursButtons(tags: 244)
//
//    lazy var fifth1TextField = createHoursButtons(tags: 25)
//    lazy var fifth2TextField = createHoursButtons(tags: 255)
//
//    lazy var sexth1TextField = createHoursButtons(tags: 26)
//    lazy var sexth2TextField = createHoursButtons(tags: 266)
//
//    lazy var seventh1TextField = createHoursButtons(tags: 27)
//    lazy var seventh2TextField = createHoursButtons(tags: 277)
    
    
    override func setupViews() {
        [first2TextField,first1TextField].forEach({$0.isEnabled = true})

        let text12Stack = getStack(views: first1TextField,first2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text22Stack = getStack(views: second1TextField,second2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text32Stack = getStack(views: third1TextField,third2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text42Stack = getStack(views: forth1TextField,forth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text52Stack = getStack(views: fifth1TextField,fifth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text62Stack = getStack(views: sexth1TextField,sexth2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let text72Stack = getStack(views: seventh1TextField,seventh2TextField, spacing: 16, distribution: .fillEqually, axis: .horizontal)
        
        let mainSecondStack = getStack(views: text12Stack,text22Stack,text32Stack,text42Stack,text52Stack,text62Stack,text72Stack, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        
        addSubview(mainSecondStack)
        mainSecondStack.fillSuperview()
        //              mainSecondStack.isHide(true)
        
    }
    
    func createHoursButtons(tags:Int) -> UIButton {
        let t = UIButton()
        t.layer.borderWidth = 1
        t.layer.backgroundColor = UIColor.gray.cgColor
        t.layer.cornerRadius = 16
        t.clipsToBounds = true
        t.setTitleColor(.black, for: .normal)
        t.backgroundColor = .white
        t.setTitle("00:00", for: .normal)
        t.constrainHeight(constant: 50)
        t.tag = tags
        t.isEnabled = false
        
        return t
    }
    
    
}
