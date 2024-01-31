//
//  MapVC.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 03/01/2024.
//

import UIKit
import MapKit
import CoreLocation
class MapVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        checkAutharization()
            
    }
    
    func isLocationServiceEnabled() -> Bool{
        return CLLocationManager.locationServicesEnabled()
    }
    
    func checkAutharization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            if isLocationServiceEnabled() {
                locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
            } else {
                showAlert(title: "Alert", message: "Location services are not enabled.")
            }
        case .denied:
            showAlert(title: "Alert", message: "Please authorize the location access")
        case .restricted:
            showAlert(title: "Alert", message: "Authorization restricted")
        default:
            print("Default.... ")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last?.coordinate {
            print("Location \(userLocation)")

            // Update map view with the user's location
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:
            showAlert(title: "Alert", message: "please authorize the location access")
            break

        default:
            print("default.... ")
            break
        }
    }

}
