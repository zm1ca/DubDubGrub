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
    @Published var alertItem: AlertItem?
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <=  100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        // create CKRecord from Profile View
        let profileRecord = createProfileRecord()
        
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
    
    
    func getProfile() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                let profileReference = userRecord["userProfile"] as! CKRecord.Reference
                let profileRecordID = profileReference.recordID
                
                CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileRecordID) { profileRecord, error in
                    guard let profileRecord = profileRecord, error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    DispatchQueue.main.async { [self] in
                        let profile = DDGProfile(record: profileRecord)
                        firstName   = profile.firstName
                        lastName    = profile.lastName
                        companyName = profile.companyName
                        bio         = profile.bio
                        avatar      = profile.createAvatarImage() //unsafe
                    }
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
}