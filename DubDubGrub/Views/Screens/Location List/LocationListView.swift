//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationsManager: LocationsManager
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(locationsManager.locations, id: \.id) { location in
                    NavigationLink(destination: LocationDetailView(location: location)) {
                        LocationCell(location: location)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationsManager())
            .previewDevice("iPhone 11 Pro")
    }
}


