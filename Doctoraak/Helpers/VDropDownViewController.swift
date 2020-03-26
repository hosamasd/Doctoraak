//
//  VDropDownViewController.swift
//  Doctoraak
//
//  Created by hosam on 3/26/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//


import UIKit

protocol VDropDown {
    
    func VDropDownDidSelect(_ tableView:UITableView,View:UIView, Index:IndexPath, SelectedItem:String, MultipleSelectedItems:[String]?,isMulple:Bool)
    func VDropDownHide()
    
}

class VDropDownViewController: NSObject, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate {
    
    var tblView: UITableView!
    var delegate : VDropDown?
    private var openView: UIView!
    private var btnHideView = UIButton()
    private var viewController = UIViewController()
    
    private static var NIBDropDownViewCell = "DropDownViewCell"
    private static var SingleCellID = "idDropDownViewCellSingle"
    private static var NIBMultiPleCellID = "DropDownViewCellMultiple"
    private static var MultipleCellID = "idDropDownViewCellMultiple"
    
    private static var CellHeight:CGFloat = 30
    private var userdefault = UserDefaults.standard
    private var selectedIndexArray = [String]()
    private var viewCustom = UIView()
    //UserPassedData
    var mAryData = [String]()
    var mAryPassedData : NSMutableOrderedSet = NSMutableOrderedSet()
    var isMultipleSelectionAllow : Bool = Bool()
    var selectedData : [String]? = [String]()
    
    convenience init(_ ViewController : UIViewController,OnView:UIView,isMultipleSelectionAllow:Bool,mAryPassedData:NSMutableOrderedSet,selectedData:[String]?) {
        self.init()
        
        self.mAryPassedData = mAryPassedData
        self.selectedData = selectedData
        self.isMultipleSelectionAllow = isMultipleSelectionAllow
        ShowDropDown(ViewController, OnView: OnView)
    }
    
    //MARK: custom Method
    func ShowDropDown(_ viewController:UIViewController, OnView:UIView) -> Void {
        
        openView = OnView;
        let yPOS = calculateHeightAndDirectionOfTable(OnView)
        makeTableView(viewController, OnView: OnView, tuple: yPOS)
        self.DrawShadow()
    }
    
    func calculateHeightAndDirectionOfTable(_ OnView:UIView) -> (CGFloat,CGFloat) {
        mAryData = [String]()
        for strData in mAryPassedData {
            mAryData.append(strData as! String)
        }
        
        var height : CGFloat = 300.0
        var yPOS = CGFloat()
        if mAryData.count < 10 {
            height = CGFloat(mAryData.count) * VDropDownViewController.CellHeight
        }
        
        if viewController.view.frame.size.height - (OnView.frame.origin.y + OnView.frame.size.height) < height  {
            yPOS = OnView.frame.origin.y - height
        }else{
            yPOS = OnView.frame.origin.y + OnView.frame.size.height
        }
        return (yPOS,height)
    }
    
    func makeTableView(_ viewController : UIViewController, OnView:UIView,tuple:(CGFloat,CGFloat)) {
        tblView = UITableView()
        viewCustom.frame = CGRect.init(x: OnView.frame.origin.x, y: tuple.0, width: OnView.frame.size.width, height: tuple.1)
        tblView.frame = CGRect.init(x: 0, y: 0, width: viewCustom.frame.width, height: viewCustom.frame.height)
        tblView.delegate = self
        tblView.dataSource = self
        tblView.backgroundColor = UIColor.white
        tblView.register(UINib.init(nibName: VDropDownViewController.NIBDropDownViewCell, bundle: nil), forCellReuseIdentifier: VDropDownViewController.SingleCellID)
        tblView.register(UINib.init(nibName: VDropDownViewController.NIBMultiPleCellID, bundle: nil), forCellReuseIdentifier:VDropDownViewController.MultipleCellID)
        AddTap(vc: viewController)
        viewCustom.addSubview(tblView)
        UIView .animate(withDuration: 0.2) {
            self.viewCustom.alpha = 1.0
            viewController.view.addSubview(self.viewCustom)
        }
        self.tblView.reloadData()
    }
    
    private func AddTap(vc:UIViewController) -> Void {
        btnHideView = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: vc.view.frame.size.width, height: vc.view.frame.size.height))
        btnHideView.addTarget(self, action: #selector(Handletap), for: .touchUpInside)
        btnHideView.backgroundColor = UIColor.clear
        vc.view.addSubview(btnHideView)
    }
    
    
    @objc private func Handletap() -> Void {
        HideDropDown()
    }
    
    private func HideDropDown() -> Void {
        UIView.animate(withDuration: 0.2, animations: {
            self.btnHideView.removeFromSuperview()
            self.viewCustom.alpha = 0.0
        }, completion: { (finished) in
            if finished {
                self.viewCustom.removeFromSuperview()
                self.delegate?.VDropDownHide()
            }
        })
    }
    
    private func DrawShadow() -> Void {
        viewCustom.layer.borderColor = UIColor.lightGray.cgColor
        viewCustom.layer.borderWidth = 0.5
        viewCustom.layer.cornerRadius = 3.0
        let shadowPath = UIBezierPath(roundedRect: tblView.bounds, cornerRadius: 2.0)
        viewCustom.layer.masksToBounds = false
        viewCustom.layer.shadowColor = UIColor.black.cgColor
        viewCustom.layer.shadowOffset = CGSize(width: 1.0, height: 1.0);
        viewCustom.layer.shadowOpacity = 0.5
        viewCustom.layer.shadowPath = shadowPath.cgPath
    }
    
    
    //MARK: Tableview Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mAryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !isMultipleSelectionAllow {
            let tblCell = tableView.dequeueReusableCell(withIdentifier: VDropDownViewController.SingleCellID) as! VTableViewCell
            tblCell.lblTitle.text = mAryData[indexPath.row]
            if userdefault.value(forKey: "SelectedSingle") != nil {
                if mAryData[indexPath.row] == userdefault.value(forKey: "SelectedSingle") as! String
                {
                    tblCell.imgTickMark.isHidden = false
                }else{
                    tblCell.imgTickMark.isHidden = true
                }
            }else{
                tblCell.imgTickMark.isHidden = true
            }
            return tblCell
        }else{
            let tblCell = tableView.dequeueReusableCell(withIdentifier: VDropDownViewController.MultipleCellID) as! VTableViewCell
            tblCell.lblTitle.text = mAryData[indexPath.row]
            
            if (selectedData?.count)! > 0{
                if (selectedData?.contains(mAryData[indexPath.row]))!
                {
                    tblCell.btnMultipleSelection.isSelected = true
                }else{
                    tblCell.btnMultipleSelection.isSelected = false
                }
            }
            return tblCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isMultipleSelectionAllow {
            let strSelectedItem = mAryData[indexPath.row]
            userdefault.set(strSelectedItem, forKey: "SelectedSingle")
            self.delegate?.VDropDownDidSelect(tableView,View:openView, Index: indexPath, SelectedItem: strSelectedItem, MultipleSelectedItems:nil,isMulple:isMultipleSelectionAllow)
            HideDropDown()
        }else{
            let tblCell = tableView.cellForRow(at: indexPath) as! VTableViewCell
            tblCell.btnMultipleSelection.isSelected = !tblCell.btnMultipleSelection.isSelected
            let strData = mAryData[indexPath.row]
            let SelectedOriginalValueArray = isDataAvailabel(data: strData)
            self.delegate?.VDropDownDidSelect(tableView,View:openView, Index: indexPath, SelectedItem: "", MultipleSelectedItems:SelectedOriginalValueArray,isMulple:isMultipleSelectionAllow)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(VDropDownViewController.CellHeight)
    }
    
    
    private func isDataAvailabel(data : String) -> [String]? {
        if (selectedData?.contains(data))! {
            if let index = selectedData?.index(of: data) {
                selectedData?.remove(at: index)
            }
        }else{
            selectedData?.append(data)
        }
        return (selectedData)!
    }
}
