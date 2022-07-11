//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 8.07.22.
//

import MapKit

final class LocationMapViewModel: ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516,
                                                                                  longitude: -121.891054),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                          longitudeDelta: 0.01))
    @Published var alertItem: AlertItem?
    
    
    func getLocations(for locationsManager: LocationsManager) {
        CloudKitManager.getLocations { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    locationsManager.locations = locations
                    print(locations)
                case .failure(_):
                    self.alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
}
