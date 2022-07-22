//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @State private var firstName    = ""
    @State private var lastName     = ""
    @State private var companyName  = ""
    @State private var bio          = ""
    @State private var avatar       = PlaceholderImage.avatar
    @State private var isShowingPhotoPicker = false
    @State private var alertItem: AlertItem?
    
    
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
                createProfile()
            } label: {
                DDGButton(title: "Create Profile")
            }
            .padding(.bottom)
        }
        .navigationTitle("Profile")
        .toolbar {
            Button  {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }

        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(image: $avatar)
        }
    }
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count < 100 else { return false }

        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        // create CKRecord from Profile View
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName]   = firstName
        profileRecord[DDGProfile.kLastName]    = lastName
        profileRecord[DDGProfile.kBio]         = bio
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kAvatar]      = avatar.convertToCKAsset()
        
        // get user id from container
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            // get userRecord from PublicDatabase
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                // create reference on UserRecord to DDGProfile we created
                userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
                
                // create CKOperation to save our User and Profile Records
                let operation = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
                    guard let savedRecords = savedRecords, error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    print(savedRecords)
                }
                
                CKContainer.default().publicCloudDatabase.add(operation)
            }
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
