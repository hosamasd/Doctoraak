//
//  NotificationsCollectionVC.swift
//  Doctoraak
//
//  Created by hosam on 6/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit

class NotificationsCollectionVC: BaseCollectionVC {
    
    fileprivate  let cellID = "cellID"
    var index = 0
    /// an enum of type TableAnimation - determines the animation to be applied to the tableViewCells
    var currentTableAnimation: CollectionAnimation = .fadeIn(duration: 0.85, delay: 0.03)
    
    var notificationPHYArray = [PharmacyNotificationModel]()
    var notificationLABArray = [LABNotificationModel]()
    var notificationDocArray = [DOCTORNotificationModel]()
    
    var notificationRADArray = [RadiologyNotificationModel]()
    
    var handledisplayDOCNotification:((DOCTORNotificationModel,IndexPath,Bool)->Void)?
    var handledisplayRADNotification:((RadiologyNotificationModel,IndexPath,Bool)->Void)?
    var handledisplayLABNotification:((LABNotificationModel,IndexPath,Bool)->Void)?
    var handledisplayPHYNotification:((PharmacyNotificationModel,IndexPath,Bool)->Void)?
    //        var handledisplayDOCNotification:((PatientNotificationModel,IndexPath)->Void)?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if index==0 || index == 1 {
            collectionView.noDataFound(notificationDocArray.count, text: "No Data Added Yet".localized)
            return notificationDocArray.count
        }else if index == 2 {
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let animation = currentTableAnimation.getAnimation()
        let animator = CollectionViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! NotificationCell
        if index == 0 || index == 1 {
            let epoisde = notificationDocArray[indexPath.row]
            cell.doc = epoisde
        }else if index == 2 {
            let epoisde = notificationLABArray[indexPath.row]
            cell.lab = epoisde
        }else if index == 3 {
            let epoisde = notificationRADArray[indexPath.row]
            cell.rad = epoisde
        }else {
            let epoisde = notificationPHYArray[indexPath.row]
            cell.phy = epoisde
        }
        
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if index == 0 || index == 1 {
            let dd = notificationDocArray[indexPath.item]
            makePostDOCAlert(post: dd, indexPath)
        }else if index == 2  {
            let dd = notificationLABArray[indexPath.item]
            makePostLABAlert(post: dd, indexPath)
        }else if index == 3  {
            let dd = notificationRADArray[indexPath.item]
            makePostRADAlert(post: dd, indexPath)
        }else   {
            let dd = notificationPHYArray[indexPath.item]
            makePostPHYAlert(post: dd, indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height:CGRect
        if index == 0 || index == 1 {
            let message = notificationDocArray[indexPath.item]
            height = message.messageEn.getFrameForText(text: message.messageEn)
        }else if index == 2  {
            let message = notificationLABArray[indexPath.item]
            height = message.messageEn.getFrameForText(text: message.messageEn)
        }else if index == 3  {
            let message = notificationRADArray[indexPath.item]
            height = message.messageEn.getFrameForText(text: message.messageEn)
        }else   {
            let message = notificationPHYArray[indexPath.item]
            height = message.messageEn.getFrameForText(text: message.messageEn)
        }
        return .init(width: view.frame.width, height: height.height+40)
        
    }
    
    
    //MARK:-User methods
    
    
    
    fileprivate func makePostDOCAlert(post:DOCTORNotificationModel,_ index:IndexPath)  {
        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { (_) in
            self.handledisplayDOCNotification?(post,index,false)
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        let show = UIAlertAction(title: "Display".localized, style: .default) { (_) in
            self.handledisplayDOCNotification?(post,index,true)
        }
        alert.addAction(show)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    fileprivate func makePostRADAlert(post:RadiologyNotificationModel,_ index:IndexPath)  {
        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { (_) in
            self.handledisplayRADNotification?(post,index,false)
            
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        let show = UIAlertAction(title: "Display".localized, style: .default) { (_) in
            self.handledisplayRADNotification?(post,index,true)
        }
        alert.addAction(show)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    fileprivate  func makePostLABAlert(post:LABNotificationModel,_ index:IndexPath)  {
        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { (_) in
            self.handledisplayLABNotification?(post,index,false)
            
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        let show = UIAlertAction(title: "Display".localized, style: .default) { (_) in
            self.handledisplayLABNotification?(post,index,true)
        }
        alert.addAction(show)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    fileprivate   func makePostPHYAlert(post:PharmacyNotificationModel,_ index:IndexPath)  {
        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { (_) in
            self.handledisplayPHYNotification?(post,index,false)
        }
        
        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        let show = UIAlertAction(title: "Display".localized, style: .default) { (_) in
            self.handledisplayPHYNotification?(post,index,true)
        }
        alert.addAction(show)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: cellID)
    }
}
