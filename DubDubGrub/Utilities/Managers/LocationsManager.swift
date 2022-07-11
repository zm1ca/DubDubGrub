//
//  LocationsManager.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 8.07.22.
//

import Foundation

final class LocationsManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
