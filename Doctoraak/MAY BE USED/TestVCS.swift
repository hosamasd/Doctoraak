//
//  TestVCS.swift
//  Doctoraak
//
//  Created by hosam on 3/26/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit
import UIMultiPicker

class TestVCS: CustomBaseViewVC {
    
     let TASTES = [
        "Sweet",
        "Sour",
        "Bitter",
        "Salty",
        "Umami"
    ];
    
    lazy var tests:UIMultiPicker = {
       let v = UIMultiPicker(backgroundColor: .white)
        v.options = TASTES
        v.selectedIndexes = [0,2]
        v.color = .gray
        v.tintColor = .green
        v.font = .systemFont(ofSize: 30, weight: .bold)
        
        v.highlight(2, animated: true) // centering "Bitter"
        return v
    }()
    
    override func setupViews() {
        view.backgroundColor = .red
        view.addSubview(tests)
        tests.addTarget(self, action: #selector(selected), for: .valueChanged)

        tests.centerInSuperview(size: .init(width: view.frame.width, height: 200))
        
    }
    
    override func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "asd", style: .plain, target: self, action: #selector(handleLL))
    }
    
    @objc func selected(_ sender: UIMultiPicker) {
        print(sender.isMultipleTouchEnabled)
    }
    
  @objc func handleLL()  {
        print(999)
    }
}
