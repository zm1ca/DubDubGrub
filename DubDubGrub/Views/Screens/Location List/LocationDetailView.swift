//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI

struct LocationDetailView: View {
    
    let location: DDGLocation
    
    var body: some View {
        VStack (spacing: 16) {
            BannerView(image: location.createBannerImage())
            
            HStack {
                Label(location.address, systemImage: "mappin.and.ellipse")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding(.horizontal)
            
            DescriptionView(text: location.description)
            
            CapsuleView(location: location)
            
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
        .navigationTitle(location.name)
        .toolbar(content: {
            Button("Dismiss") {
                print("Dismiss")
            }
        })
    }
}


//MARK: - Elements
struct BannerView: View {
    
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(height: 120)
    }
} 


struct DescriptionView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .minimumScaleFactor(0.75)
            .lineLimit(3)
            .padding(.horizontal)
    }
}


struct CapsuleView: View {
    
    let location: DDGLocation
    
    var body: some View {
        HStack (spacing: 20) {
            Button  {
                print("Location")
            } label: {
                LocationActionButton(imageName: "location.fill", color: .brandPrimary)
            }
            
            Link(destination: URL(string: location.website)!) {
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
        .frame(width: 350, height: 80)
        .background(Capsule().foregroundColor(Color(.secondarySystemBackground)))
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
 

//MARK: - Preview
struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: DDGLocation(record: MockData.location))
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
        
        LocationDetailView(location: DDGLocation(record: MockData.location))
            .previewDevice("iPhone 13 mini")
            .preferredColorScheme(.dark)
    }
}


