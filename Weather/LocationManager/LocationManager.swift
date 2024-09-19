//
//  LocationManager.swift
//  Weather
//
//  Created by Mac on 18/09/24.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    private let clLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        clLocationManager.delegate = self
        clLocationManager.requestWhenInUseAuthorization()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            clLocationManager.requestLocation()
        default:
            print("access denied")
        }
        
    }

}
