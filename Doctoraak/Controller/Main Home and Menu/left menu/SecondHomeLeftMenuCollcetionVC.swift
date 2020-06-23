//
//  SecondHomeLeftMenuCollcetionVC.swift
//  Doctoraak
//
//  Created by hosam on 6/14/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class SecondHomeLeftMenuCollcetionVC: BaseCollectionVC {
    
    var images:[UIImage] = [#imageLiteral(resourceName: "icon"),#imageLiteral(resourceName: "icond"),#imageLiteral(resourceName: "ic_add_circle_outline_24px-1"),#imageLiteral(resourceName: "Union 1"),#imageLiteral(resourceName: "Group 4122"),#imageLiteral(resourceName: "ic_phone_24px"),#imageLiteral(resourceName: "ic_language_24px")]
    var deatas = [["Profile","Calender","Notification","Analysis"],["Contact Us","Language","Log Out"]]

    
    
    
    fileprivate let cellId = "cellId"
    
    var handleCheckedIndex:((IndexPath)->Void)?
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return deatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height:CGFloat = section == 0 ? 0 : 50
        
        return .init(width: view.frame.width, height: height)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? deatas[0].count : deatas[1].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        sectionHeader.label.text = "Setting"
        
        return sectionHeader
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorLeftMenuCell
        cell.Image6.image = images[indexPath.item]
        
        cell.Label6.text = indexPath.section == 0 ? deatas[0][indexPath.item] : deatas[1][indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCheckedIndex?(indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 60)
    }
    
    //TODO: -handle methods
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.register(DoctorLeftMenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
    }
}


class SectionHeader: UICollectionReusableView {
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
