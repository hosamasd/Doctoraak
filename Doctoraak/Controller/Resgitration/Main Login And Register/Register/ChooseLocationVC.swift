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
import GooglePlaces
import GoogleMaps

protocol ChooseLocationVCProtocol {
    func getLatAndLong(lat:Double,long:Double)
}
class ChooseLocationVC: CustomBaseViewVC {
    
    
    
    lazy var customChooseUserLocationView:CustomChooseUserLocationView = {
        let v = CustomChooseUserLocationView()
        
        v.mapView.delegate = self
        v.infoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInfo)))
        v.doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        v.searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showGooglePlaces)))
        return v
    }()
    private let locationManager = CLLocationManager()
    var delgate: ChooseLocationVCProtocol?
    var currentLat:Double?
    var currentLong:Double?
    
    var phy:PharamacyModel?{
        didSet{
            guard let phy = phy,let lat=phy.latt?.toDouble(),let lng=phy.lang?.toDouble() else { return  }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            setupAnnotaiotn(coordinate: coordinate)
        }
    }
    //       var doctor:DoctorModel?{
    //           didSet{
    //                guard let phy = phy,let lat=phy.latt?.toDouble(),let lng=phy.lang?.toDouble() else { return  }
    //                          let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
    //                          setupAnnotaiotn(coordinate: coordinate)
    //                          }
    //          }
    //       }
    //       var medicalCenter:DoctorModel?{
    //           didSet{
    //               guard let phy = phy,let lat=phy.latt?.toDouble(),let lng=phy.lang?.toDouble() else { return  }
    //                          let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
    //                          setupAnnotaiotn(coordinate: coordinate)
    //                          }
    //           }
    //       }
    var lab:LabModel?{
        didSet{
            guard let phy = lab,let lat=phy.latt.toDouble(),let lng=phy.lang.toDouble() else { return  }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            setupAnnotaiotn(coordinate: coordinate)
        }
    }
    
    var rad:RadiologyModel?{
        didSet{
            guard let phy = rad,let lat=phy.latt.toDouble(),let lng=phy.lang.toDouble() else { return  }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            setupAnnotaiotn(coordinate: coordinate)
        }
    }
    
    var isGetLocation = false
    
    fileprivate let isFromUpdate:Bool!
    
    init( isFromUpdate:Bool) {
        self.isFromUpdate=isFromUpdate
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        !isGetLocation ? () : getUserLocation()
        
        //        isFromUpdate ? () : getUserLocation()
        setupViews()
    }
    
    
    
    //MARK:-User methods
    
    func appearAutoComplete()  {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    override func setupNavigation() {
        navigationController?.navigationBar.isHide(true)
    }
    
    fileprivate func getUserLocation()  {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        isGetLocation=true
        
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
        isGetLocation=true
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
    
    @objc func showGooglePlaces()  {
        appearAutoComplete()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:-Extensions

extension ChooseLocationVC : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        customChooseUserLocationView.mapView.clear()
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 13.0)
        currentLat = coordinate.latitude
        currentLong = coordinate.longitude
        customChooseUserLocationView.mapView.camera = camera
        
        let marker = GMSMarker()
        marker.title = "Your Location"
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.map = customChooseUserLocationView.mapView
    }
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
    
    
    fileprivate func getYourLocation(_ userLocation: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                              longitude: userLocation.coordinate.longitude, zoom: 13.0)
        customChooseUserLocationView.mapView.camera = camera
        let marker = GMSMarker()
        marker.title = "Your Location"
        
        marker.position = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        marker.map = customChooseUserLocationView.mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard  let userLocation = locations.last else {return}
        currentLat = userLocation.coordinate.latitude
        currentLong = userLocation.coordinate.longitude
        
        getYourLocation(userLocation)
        
        locationManager.stopUpdatingLocation()
    }
}



extension ChooseLocationVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let co = place.coordinate
        let placesss = CLLocation(latitude: co.latitude, longitude: co.longitude)
        
        getYourLocation(placesss)
        customChooseUserLocationView.searchLabel.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
        
    }
}
