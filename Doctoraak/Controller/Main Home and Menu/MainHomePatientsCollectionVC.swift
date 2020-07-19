//
//  MainHomePatientsCollectionVC.swift
//  Doctoraak
//
//  Created by hosam on 3/28/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MainHomePatientsCollectionVC: BaseCollectionVC     {
    
    lazy var refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.white
               refreshControl.tintColor = UIColor.black
        return refreshControl
        
    }()
    var handleRefreshCollection:(()->Void)?
    
    fileprivate let cellId = "cellId"
    var index:Int?{
        didSet{
            guard let index = index else { return  }
        }
    }
    var currentTableAnimation: CollectionAnimation = .fadeIn(duration: 0.85, delay: 0.03)
    
    var notificationPHYArray = [PharmacyGetOrdersModel]()
    var notificationLABArray = [LABGetOrdersModel]()
    
    var notificationRADArray = [RadGetOrdersModel]()
    
    var doctorPatientsArray = [DoctorGetPatientsFromClinicModel]()
    
    //    var handledisplayRADNotification:((RadGetOrdersModel)->Void)?
    //    var handledisplayLABNotification:((LABGetOrdersModel)->Void)?
    //    var handledisplayPHYNotification:((PharmacyGetOrdersModel)->Void)?
    var handleDoctorSelectedIndex:((IndexPath)->Void)?
    
    var handledisplayRADNotification:((RadGetOrdersModel,IndexPath)->Void)?
    var handledisplayLABNotification:((LABGetOrdersModel,IndexPath)->Void)?
    var handledisplayPHYNotification:((PharmacyGetOrdersModel,IndexPath)->Void)?
    
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let animation = currentTableAnimation.getAnimation()
        let animator = CollectionViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainHomePatientsCell
        
        if index == 0 || index == 1 {
            let pat = doctorPatientsArray[indexPath.item].patient
            cell.patient=pat
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
            handleDoctorSelectedIndex?(indexPath)
        }else  if index == 2  {
            let dd = notificationLABArray[indexPath.item]
            self.handledisplayLABNotification?(dd,indexPath)
            //            makePostLABAlert(post: dd)
        }else if index == 3  {
            let dd = notificationRADArray[indexPath.item]
            handledisplayRADNotification?(dd,indexPath)
            //            makePostRADAlert(post: dd)
        }else   {
            let dd = notificationPHYArray[indexPath.item]
            self.handledisplayPHYNotification?(dd,indexPath)
            //            makePostPHYAlert(post: dd)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let width = (view.frame.wid15th - 56 ) / 2
        
        return .init(width: view.frame.width, height: 110)
    }
    
    //MARK: -user methods
    
    //    fileprivate  func makePostRADAlert(post:RadGetOrdersModel)  {
    //        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
    //        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { (_) in
    //            self.handledisplayRADNotification?(post)
    //
    //        }
    //        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
    //            alert.dismiss(animated: true)
    //        }
    //        alert.addAction(delete)
    //        alert.addAction(cancel)
    //        present(alert, animated: true)
    //    }
    //
    //    fileprivate  func makePostLABAlert(post:LABGetOrdersModel)  {
    //        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
    //        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { (_) in
    //            self.handledisplayLABNotification?(post)
    //
    //        }
    //        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
    //            alert.dismiss(animated: true)
    //        }
    //        alert.addAction(delete)
    //        alert.addAction(cancel)
    //        present(alert, animated: true)
    //    }
    //
    //    fileprivate func makePostPHYAlert(post:PharmacyGetOrdersModel)  {
    //        let alert = UIAlertController(title: "Choose Options".localized, message: "What do you want to make?".localized, preferredStyle: .actionSheet)
    //        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { (_) in
    //            self.handledisplayPHYNotification?(post)
    //
    //        }
    //        let cancel = UIAlertAction(title: "Cancel".localized, style: .default) { (_) in
    //            alert.dismiss(animated: true)
    //        }
    //        alert.addAction(delete)
    //        alert.addAction(cancel)
    //        present(alert, animated: true)
    //    }
    
    override func setupCollection() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(MainHomePatientsCell.self, forCellWithReuseIdentifier: cellId)
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
    }
    
    @objc func didPullToRefresh()  {
//        refreshControl.endRefreshing()
        handleRefreshCollection?()
    }
}
