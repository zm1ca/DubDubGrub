//
//  ProfileViewModel.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 25.07.22.
//

import SwiftUI
import CloudKit

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName    = ""
    @Published var lastName     = ""
    @Published var companyName  = ""
    @Published var bio          = ""
    @Published var avatar       = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var isLoading    = false
    @Published var alertItem: AlertItem?
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }

        let profileRecord = createProfileRecord()
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }

        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        
        showLoadingView()
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            DispatchQueue.main.async { [self]
                self.hideLoadingView()
                
                switch result {
                case .success(_):
                    self.alertItem = AlertContext.createProfileSuccess

                    break
                case .failure(_):
                    self.alertItem = AlertContext.createProfileFailure
                    break
                }
            }
        }
    }
    
    
    func getProfile() {
        guard let userRecord = CloudKitManager.shared.userRecord else {
            alertItem = AlertContext.noUserRecord
            return
        }
        
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
        
        let profileRecordID = profileReference.recordID

        showLoadingView()
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success(let profileRecord):
                    let profile = DDGProfile(record: profileRecord)
                    firstName   = profile.firstName
                    lastName    = profile.lastName
                    companyName = profile.companyName
                    bio         = profile.bio
                    avatar      = profile.createAvatarImage() //unsafe
                    
                case .failure(_):
                    alertItem = AlertContext.unableToGetProfile
                    break
                }
            }
        }
    }
    
    
    private func createProfileRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName]   = firstName
        profileRecord[DDGProfile.kLastName]    = lastName
        profileRecord[DDGProfile.kBio]         = bio
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kAvatar]      = avatar.convertToCKAsset()
        return profileRecord
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}
