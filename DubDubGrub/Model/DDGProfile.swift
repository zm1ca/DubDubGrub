//
//  DDGProfile.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 7.07.22.
//

import CloudKit
import UIKit

struct DDGProfile: RecordInitiatable {
    
    static let kFirstName   = "firstName"
    static let kLastName    = "lastName"
    static let kAvatar      = "avatar"
    static let kBio         = "bio"
    static let kCompanyName = "companyName"
    static let kIsCheckedIn = "isCheckedIn"
    
    let ckRecordID: CKRecord.ID
    let firstName: String
    let lastName: String
    let avatar: CKAsset!
    let bio: String
    let companyName: String
    let isCheckedIn: CKRecord.Reference? = nil
    
    init(record: CKRecord) {
        ckRecordID  = record.recordID
        firstName   = record[DDGProfile.kFirstName] as? String ?? "N/A"
        lastName    = record[DDGProfile.kLastName] as? String ?? "N/A"
        avatar      = record[DDGProfile.kAvatar] as? CKAsset
        bio         = record[DDGProfile.kBio] as? String ?? "N/A"
        companyName = record[DDGProfile.kCompanyName] as? String ?? "N/A"
    }
    
    func createAvatarImage() -> UIImage {
        guard let avatar = avatar else { return PlaceholderImage.avatar }
        return avatar.convertToUIImage(in: .square)
    }
}
 
