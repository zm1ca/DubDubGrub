//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack (spacing: 16) {
                ProfileHeaderView(firstName: $viewModel.firstName,
                                  lastName: $viewModel.lastName,
                                  companyName: $viewModel.companyName,
                                  avatar: $viewModel.avatar,
                                  isShowingPhotoPicker: $viewModel.isShowingPhotoPicker)
                .frame(height: 130)
                .padding(.horizontal)
                
                HStack {
                    CharactersRemainView(currentCount: viewModel.bio.count)
                    
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
                
                TextEditor(text: $viewModel.bio)
                    .accentColor(.brandPrimary)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    viewModel.profileContext == .create ?  viewModel.createProfile() : viewModel.updateProfile()
                } label: {
                    DDGButton(title: viewModel.profileContext == .create ? "Create Profile" : "Update Profile")
                }
                .padding(.bottom)
            }
            
            if viewModel.isLoading { LoadingView() }
        }
        .navigationTitle("Profile")
        .toolbar {
            Button  {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        } //TODO: Hide this button when keyboard isn't presented
        .onAppear { viewModel.getProfile() }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
                .ignoresSafeArea(.all)
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
        .environmentObject(LocationsManager())
        .preferredColorScheme(.dark)
        .previewDevice("iPhone 11 Pro")
    }
}
