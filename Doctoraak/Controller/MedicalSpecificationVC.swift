//
//  BestDoctors.swift
//  Doctoraak
//
//  Created by Ahmad Eisa on 3/11/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//

import UIKit

class MedicalSpecificationVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionData = [SpecificationModel]()
    var MedicalSpecificationModelArray = [SpecificationModel]()
    var medicalSpecificationApi = MedicalSpecificationApi()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let nibCell = UINib(nibName: "MedicalSpecificationCellCollectionVC", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "MedicalSpecificationCell")
        
        setUPView()
    }
    
    func setUPView(){
//        medicalSpecificationApi.getMedicalSpecification(onSuccess: { (medicalSpecification) -> (Void) in
//            if let medicalSpecification = medicalSpecification {
//                self.collectionData = [medicalSpecification]
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//        }) { (error) in
//            print(error)
//        }
        medicalSpecificationApi.getMedicalSpecification(onSuccess: { (medicalSpecification) -> (Void) in
            if let medicalSpecification = medicalSpecification?.data{
                self.collectionData = medicalSpecification
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }) { (error) in
            print(error)
        }
        
        }


}

extension MedicalSpecificationVC: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicalSpecificationCell", for: indexPath) as! MedicalSpecificationCell {
//
//            return cell
//        }
//        return UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicalSpecificationCell", for: indexPath) as? MedicalSpecificationCollectionVC {
             let medicalSpecificationPart = collectionData[indexPath.item]
          cell.configureMedicalSpecificationCell(with: medicalSpecificationPart)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 40) / 3
        
        return CGSize(width: width, height: width)
    }
    
}
