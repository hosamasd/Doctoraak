//
//  HomeLeftMenuTableVC.swift
//  Doctoraak
//
//  Created by hosam on 3/25/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class HomeLeftMenuTableVC: BaseCollectionVC {
    
    var images:[UIImage] = [#imageLiteral(resourceName: "ic_language_24px"),#imageLiteral(resourceName: "ic_language_24px"),#imageLiteral(resourceName: "ic_language_24px"),#imageLiteral(resourceName: "ic_language_24px"),#imageLiteral(resourceName: "Group 4122"),#imageLiteral(resourceName: "ic_phone_24px"),#imageLiteral(resourceName: "ic_language_24px")]
    var deatas = ["Profile","Calender","Add clinic","Clinic information","Analysis","Contact Us","Language"]
    
    
    
    fileprivate let cellId = "cellId"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deatas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorLeftMenuCell
        cell.Image6.image = images[indexPath.item]
        cell.Label6.text = deatas[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 56 ) / 2
        
        return .init(width: view.frame.width, height: 100)
    }
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(DoctorLeftMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
}
