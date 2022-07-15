//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @EnvironmentObject private var locationsManager: LocationsManager
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true,
                annotationItems: locationsManager.locations) { location in
                MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
            }
            .accentColor(.grubRed)
            .ignoresSafeArea(.container, edges: .top)
            
            VStack {
                LogoView(frameWidth : 125).shadow(radius: 10)
                Spacer()
            } 
        }
        .sheet(isPresented: $viewModel.isShowingOnboardingView, onDismiss: viewModel.checkIfLocationServicesAreEnabled) {
            OnboardingView(isShowingOnboaringView: $viewModel.isShowingOnboardingView)
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .onAppear {
            viewModel.runStartupChecks()
            
            if locationsManager.locations.isEmpty {
                viewModel.getLocations(for: locationsManager)
            }
        }
    }
} 

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
            .previewDevice("iPhone 11 Pro")
    }
}


