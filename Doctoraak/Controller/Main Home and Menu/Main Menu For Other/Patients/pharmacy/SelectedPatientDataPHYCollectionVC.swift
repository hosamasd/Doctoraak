//
//  SelectedPatientDataPHYCollectionVC.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class SelectedPatientDataPHYCollectionVC: BaseCollectionVC {
    
    fileprivate  let cellID = "cellID"
       
       var notificationPHYArray = [PharmacyDetailModel]()
       //        var handledisplayDOCNotification:((PatientNotificationModel,IndexPath)->Void)?
       
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notificationPHYArray.count
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SelectedPatientDataPHYCell
        let dd = notificationPHYArray[indexPath.item]
        
        cell.order = dd
        
           return cell
           
       }
       
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
           return .init(width: view.frame.width, height: 100)
           
       }
       
       
       //MARK:-User methods
       
      
       
       override func setupCollection() {
           collectionView.backgroundColor = .white
           collectionView.register(SelectedPatientDataPHYCell.self, forCellWithReuseIdentifier: cellID)
       }
}
