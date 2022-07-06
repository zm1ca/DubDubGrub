//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName    = ""
    @State private var lastName     = ""
    @State private var companyName  = ""
    @State private var bio          = ""
    
    
    var body: some View {
        VStack (spacing: 16) {
            ZStack {
                Color(.secondarySystemBackground)
                
                HStack {
                    ZStack {
                        AvatarView(size: 84)
                            .padding()
                        
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.white)
                            .offset(y: 30)
                    }
                    
                    VStack (alignment: .leading, spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                            .foregroundColor(.white)
                        
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                            .foregroundColor(.white)
                        
                        TextField("YouTuber & Indie Dev", text: $companyName)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 16)
                    
                    Spacer()
                }
            }
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
            
            HStack {
                Text("Bio: ")
                    .font(.callout)
                    .foregroundColor(.secondary)
                +
                Text("\(100 - bio.count)")
                    .bold()
                    .font(.callout)
                    .foregroundColor(bio.count <= 100 ? .brandPrimary : Color(.systemPink))
                +
                Text(" characters remain")
                    .font(.callout)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button {
                    print("Check Out")
                } label: {
                    ZStack {
                        Color(.systemPink)
                        
                        Label("Check Out", systemImage: "mappin.and.ellipse")
                            .foregroundColor(.white)
                    }
                    .frame(width: 140, height: 28)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            
            TextEditor(text: $bio)
                .accentColor(.brandPrimary)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1))
                .padding(.horizontal)
            
            Spacer()
            
            Button {
                print("Save")
            } label: {
                Text("Save Profile")
                    .bold()
                    .frame(width: 280, height: 44)
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
        .preferredColorScheme(.dark)
        .previewDevice("iPhone 11 Pro")
    }
}
