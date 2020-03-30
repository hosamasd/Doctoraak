//
//  MainHomePatientsCollectionVC.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MainHomePatientsCollectionVC: BaseCollectionVC     {
    
    fileprivate let cellId = "cellId"
     var handleSelectedIndex:((IndexPath)->Void)?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainHomePatientsCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleSelectedIndex?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let width = (view.frame.wid15th - 56 ) / 2
        
        return .init(width: view.frame.width, height: 110)
    }
    
      //MARK: -user methods
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(MainHomePatientsCell.self, forCellWithReuseIdentifier: cellId)
    }
}
