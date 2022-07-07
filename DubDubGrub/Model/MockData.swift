//
//  MockData.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 7.07.22.
//

import CloudKit

struct MockData {
    static var location: CKRecord {
        let record = CKRecord(recordType: "DDGLocation")
        record[DDGLocation.kName]        = "Sean's Bar and Grill"
        record[DDGLocation.kAddress]     = "123 Main Street"
        record[DDGLocation.kDescription] = "This is a test description. Isn't it awesome. Not sure how long to make it to test 3 lines without compression."
        record[DDGLocation.kWebsite]     = "https://www.apple.com"
        record[DDGLocation.kLocation]    = CLLocation(latitude: 37.311516, longitude: -121.891054)
        record[DDGLocation.kPhone]       = "111-111-1111"
        
        return record
    }
}
