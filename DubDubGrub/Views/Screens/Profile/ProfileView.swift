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
    @State private var avatar       = PlaceholderImage.avatar
    @State private var isShowingPhotoPicker = false
    
    
    var body: some View {
        VStack (spacing: 16) {
            ProfileHeaderView(firstName: $firstName, lastName: $lastName, companyName: $companyName, avatar: $avatar, isShowingPhotoPicker: $isShowingPhotoPicker)
                .frame(height: 130)
                .padding(.horizontal)
            
            HStack {
                CharactersRemainView(currentCount: bio.count)
                
                Spacer()
                
                Button {
                    print("Check Out")
                } label: {
                    Label("Check Out", systemImage: "mappin.and.ellipse")
                        .frame(width: 140, height: 28)
                        .background(Color(.systemPink))
                        .cornerRadius(8)
                        .foregroundColor(.white)
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
                DDGButton(title: "Save Profile")
            }
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(image: $avatar)
        }
    }
}

//MARK: - Elements
struct CharactersRemainView: View {
    
    let currentCount: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundColor(.secondary)
        +
        Text("\(100 - currentCount)")
            .bold()
            .font(.callout)
            .foregroundColor(currentCount <= 100 ? .brandPrimary : Color(.systemPink))
        +
        Text(" characters remain")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}

struct EditImageView: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundColor(.white)
    }
}

//MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
        .preferredColorScheme(.dark)
        .previewDevice("iPhone 11 Pro")
    }
}
