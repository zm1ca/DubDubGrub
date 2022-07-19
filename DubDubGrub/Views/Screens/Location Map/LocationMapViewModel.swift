//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 8.07.22.
//

import MapKit

final class LocationMapViewModel: NSObject, ObservableObject  {
    
    @Published var isShowingOnboardingView = false
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516,
                                                                                  longitude: -121.891054),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                          longitudeDelta: 0.01))
    
    
    var deviceLocationManager: CLLocationManager?
    
    let kHasSeenOnboardingView = "hasSeenOnboardingView"
    var hasSeenOnboardingView: Bool {
        return UserDefaults.standard.bool(forKey: kHasSeenOnboardingView) //default is false
    }
    
    func runStartupChecks() {
        if !hasSeenOnboardingView {
            isShowingOnboardingView = true
            UserDefaults.standard.set(true, forKey: kHasSeenOnboardingView)
        } else {
            checkIfLocationServicesAreEnabled()
        }
    }
    
    func checkIfLocationServicesAreEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
            deviceLocationManager!.delegate = self
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }
    
    private func checkLocationAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }
        switch deviceLocationManager.authorizationStatus {
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func getLocations(for locationsManager: LocationsManager) {
        CloudKitManager.getLocations { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    locationsManager.locations = locations
                case .failure(_):
                    self.alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
}

extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
