//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI

struct LocationDetailView: View {
    var body: some View {
        VStack (spacing: 16) {
            Image("default-banner-asset")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            
            HStack {
                Label("1 S Market St Ste 40", systemImage: "mappin.and.ellipse")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Text("It's Chipotle. Enough said. It's Chipotle. Enough said. It's Chipotle. Enough said. It's Chipotle. Enough said. It's Chipotle. Enough said. ")
                .minimumScaleFactor(0.75)
                .lineLimit(3)
                .padding(.horizontal)
            
            CapsuleView()
            
            Text("Who's Here?")
                .bold()
                .font(.title2)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach (0..<12) { item in
                        FirstNameAvatarView(firstName: "Karikiteya1")
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Chipotle")
        .toolbar(content: {
            Button("Dismiss") {
                print("Dismiss")
            }
        })
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView()
            .preferredColorScheme(.dark)
    }
}

struct CapsuleView: View {
    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color(.secondarySystemBackground))
            
            HStack (spacing: 20) {
                Button  {
                    print("Location")
                } label: {
                    LocationActionButton(imageName: "location.fill", color: .brandPrimary)
                }
                
                Link(destination: URL(string: "https://www.apple.com")!) {
                    LocationActionButton(imageName: "globe", color: .brandPrimary)
                }
                
                Button  {
                    print("Phone")
                } label: {
                    LocationActionButton(imageName: "phone.fill", color: .brandPrimary)
                }
                
                Button  {
                    print("Uncheck")
                } label: {
                    LocationActionButton(imageName: "person.fill.xmark", color: Color(.systemPink))
                }
            }
        }
        .padding(.horizontal)
    }
}


struct LocationActionButton: View {
    
    let imageName: String
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
        }
    }
}


struct FirstNameAvatarView: View {
    
    let firstName: String
    
    var body: some View {
        VStack {
            AvatarView(size: 64)
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}
 
