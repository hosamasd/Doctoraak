//
//  ChooseLocationVC.swift
//  Doctoraak
//
//  Created by hosam on 4/15/20.
//  Copyright © 2020 Ahmad Eisa. All rights reserved.
//




import UIKit
import SVProgressHUD
import MapKit

protocol ChooseLocationVCProtocol {
    func getLatAndLong(lat:Double,long:Double)
}
class ChooseLocationVC: CustomBaseViewVC {
    
    
    lazy var customChooseUserLocationView:CustomChooseUserLocationView = {
        let v = CustomChooseUserLocationView()
        
        v.mapView.delegate = self
        v.infoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInfo)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        //        i.
        return v
    }()
    private let locationManager = CLLocationManager()
    var delgate: ChooseLocationVCProtocol?
    var currentLat:Double?
    var currentLong:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lpgr = UILongPressGestureRecognizer(target: self,
                                                action:#selector(self.handleLongPress))
        lpgr.minimumPressDuration = 1
        lpgr.delaysTouchesBegan = true
        //        lpgr.delegate = self
        customChooseUserLocationView.mapView.addGestureRecognizer(lpgr)
        getUserLocation()
        setupViews()
    }
    
    
    
    //MARK:-User methods
    
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    fileprivate func getUserLocation()  {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //        locationManager.startUpdatingLocation()
        
    }
    
    func addAnnotation(coordinate:CLLocationCoordinate2D){
        customChooseUserLocationView.mapView.removeAnnotations(customChooseUserLocationView.mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        customChooseUserLocationView.mapView.addAnnotation(annotation)
    }
    
    //TODO:-Handle methods
    
    override func setupViews()  {
        view.backgroundColor = .white
        view.addSubview(customChooseUserLocationView)
        customChooseUserLocationView.fillSuperview()
    }
    
    func setupAnnotaiotn(coordinate:CLLocationCoordinate2D)  {
        let annote = MKPointAnnotation()
        annote.title = "your location"
        annote.coordinate = coordinate
        customChooseUserLocationView.mapView.addAnnotation(annote)
        
        
        customChooseUserLocationView.mapView.showAnnotations(customChooseUserLocationView.mapView.annotations, animated: true)
    }
    
    @objc fileprivate func handleInfo()  {
        SVProgressHUD.showInfo(withStatus: "Please press long to pick up location".localized)
    }
    
    @objc fileprivate func handleDismss()  {
        dismiss(animated: true) {[unowned self] in
            self.delgate?.getLatAndLong(lat: self.currentLat ?? 0.0, long: self.currentLong ?? 0.0)
        }
    }
    
    @objc func handleDone()  {
        self.delgate?.getLatAndLong(lat: self.currentLat ?? 0.0, long: self.currentLong ?? 0.0)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .ended{
            let locationInView = gestureRecognizer.location(in: customChooseUserLocationView.mapView)
            let tappedCoordinate = customChooseUserLocationView.mapView.convert(locationInView, toCoordinateFrom: customChooseUserLocationView.mapView)
            addAnnotation(coordinate: tappedCoordinate)
        }
        
    }
    
}

//MARK:-Extensions

extension ChooseLocationVC:MKMapViewDelegate  {
}

//MARK:-extension


extension ChooseLocationVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print("not active")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard  let userLocation = locations.last else {return}
        currentLat = userLocation.coordinate.latitude
        currentLong = userLocation.coordinate.longitude
        
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 0.2, longitudinalMeters: 0.2)
        customChooseUserLocationView.mapView.setRegion(region, animated: true)
        setupAnnotaiotn(coordinate: userLocation.coordinate)
        locationManager.stopUpdatingLocation()
    }
}

