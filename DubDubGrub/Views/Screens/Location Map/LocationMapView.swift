//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516,
                                                                                  longitude: -121.891054),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                          longitudeDelta: 0.01))
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea(.container, edges: .top)
            
            VStack {
                LogoView().shadow(radius: 10)
                Spacer()
            }
        }
    }
}

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
            .previewDevice("iPhone 11 Pro")
    }
}


