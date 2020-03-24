//
//  Bindable.swift
//  Doctoraak
//
//  Created by hosam on 3/24/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//



import UIKit

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
    
}
