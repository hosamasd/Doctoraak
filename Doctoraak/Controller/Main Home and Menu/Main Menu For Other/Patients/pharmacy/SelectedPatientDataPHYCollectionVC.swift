//
//  SelectedPatientDataPHYCollectionVC.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class SelectedPatientDataPHYCollectionVC: BaseCollectionVC {
    
    var index = 0
    
    fileprivate  let cellID = "cellID"
    
    var notificationPHYArray = [PharmacyDetailModel]()
    var notificationRADArray = [RADDetailModel]()
    var notificationLABArray = [RADDetailModel]()
    
    //        var handledisplayDOCNotification:((PatientNotificationModel,IndexPath)->Void)?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if index == 2 {
            collectionView.noDataFound(notificationLABArray.count, text: "No Data Added Yet".localized)
            return notificationLABArray.count
        }else if index == 3 {
            collectionView.noDataFound(notificationRADArray.count, text: "No Data Added Yet".localized)
            return notificationRADArray.count
        }else {
            collectionView.noDataFound(notificationPHYArray.count, text: "No Data Added Yet".localized)
            return notificationPHYArray.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SelectedPatientDataPHYCell
        if index == 2 {
            let epoisde = notificationLABArray[indexPath.row]
            cell.orderLAB = epoisde
        }else if index == 3 {
            let epoisde = notificationRADArray[indexPath.row]
            cell.orderRAD = epoisde
        }else {
            let epoisde = notificationPHYArray[indexPath.row]
            cell.order = epoisde
        }
        
        [cell.countLabel,cell.typeLabel].forEach({$0.isHide(index == 4 ? false : true)})
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
