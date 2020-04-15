//
//  MedicineCollectionVC.swift
//  Doctoraak
//
//  Created by hosam on 4/8/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MedicineCollectionVC: BaseCollectionVC {
    
    fileprivate let cellID = "cellID"
       var medicineArray = ["one","two","three","four","fifie"]
       
       
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return medicineArray.count
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MedicineCell
                   let med = medicineArray[indexPath.item]
           //
                   cell.med = med
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return .init(width: view.frame.width, height: 60)
       }
       
       //MARK:-User methods

       
       override func setupCollection() {
           collectionView.backgroundColor = .white
           collectionView.register(MedicineCell.self, forCellWithReuseIdentifier: cellID)
       }

}