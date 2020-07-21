////
////  HomeLeftMenuTableVC.swift
////  Doctoraak
////
////  Created by hosam on 3/25/20.
////  Copyright © 2020 Ahmad Eisa. All rights reserved.
////
//
//import UIKit
//
//class HomeLeftMenuCollcetionVC: BaseCollectionVC {
//    
//    var images:[UIImage] = [#imageLiteral(resourceName: "user"),#imageLiteral(resourceName: "calendar"),#imageLiteral(resourceName: "add"),#imageLiteral(resourceName: "info"),#imageLiteral(resourceName: "notification"),#imageLiteral(resourceName: "ic_chart"),#imageLiteral(resourceName: "phone-call"),#imageLiteral(resourceName: "global"),#imageLiteral(resourceName: "logout")]
//    var deatas = [["Profile".localized,"Calender".localized,"Add clinic".localized,"Clinic Info".localized,"Notification".localized,"Anaylicts".localized],["Contact Us".localized,"Language".localized,"Log Out".localized]]
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        images.forEach({$0.withRenderingMode(.alwaysTemplate)})
//        
//    }
//    
//    fileprivate let cellId = "cellId"
//    
//    var handleCheckedDocIndex:((IndexPath)->Void)?
//    
//    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return deatas.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let height:CGFloat = section == 0 ? 0 : 50
//        
//        return .init(width: view.frame.width, height: height)
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
//        sectionHeader.label.text = "Setting".localized
//        
//        return sectionHeader
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return section == 0 ? deatas[0].count : deatas[1].count
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DoctorLeftMenuCell
//        if indexPath.section == 0 {
//            cell.Image6.image = images[indexPath.item]
//        }else {
//            cell.Image6.image = images[indexPath.item+6]
//        }
//        cell.Label6.text = indexPath.section == 0 ? deatas[0][indexPath.item] : deatas[1][indexPath.item]
//        return cell
//    }
//    
//    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        handleCheckedDocIndex?(indexPath)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return .init(width: view.frame.width, height: 60)
//    }
//    
//    //TODO: -handle methods
//    
//    override func setupCollection() {
//        collectionView.backgroundColor = .white
//        collectionView.register(DoctorLeftMenuCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
//        
//    }
//}
