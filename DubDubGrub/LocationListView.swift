//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI

struct LocationListView: View {
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(0..<10) { item in
                    NavigationLink(destination: LocationDetailView()) {
                        LocationCell()
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
        }
    }
}


struct AvatarView: View {
    
    let size: CGFloat
    
    var body: some View {
        Image("default-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .previewDevice("iPhone 11 Pro")
    }
}


