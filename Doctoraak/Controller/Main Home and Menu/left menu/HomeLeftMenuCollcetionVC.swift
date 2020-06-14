//
//  HomeLeftMenuTableVC.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class HomeLeftMenuCollcetionVC: BaseCollectionVC {
    
    var images:[UIImage] = [#imageLiteral(resourceName: "icon"),#imageLiteral(resourceName: "icond"),#imageLiteral(resourceName: "ic_add_circle_outline_24px-1"),#imageLiteral(resourceName: "Union 1"),#imageLiteral(resourceName: "Group 4122"),#imageLiteral(resourceName: "ic_phone_24px"),#imageLiteral(resourceName: "ic_language_24px")]
    
    var deatas = ["Profile","Calender","Add clinic","Clinic information","Analysis","Contact Us","Language"]
    
    
    
    fileprivate let cellId = "cellId"
    
    var handleCheckedIndex:((IndexPath)->Void)?

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deatas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorLeftMenuCell
        cell.Image6.image = images[indexPath.item]
        cell.Label6.text = deatas[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCheckedIndex?(indexPath)
//        let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC
//               baseSlid?.didSelectItemAtIndex(indexx: indexPath)
//        handleCheckedIndex?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 60)
    }
    
     //TODO: -handle methods
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(DoctorLeftMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
}
