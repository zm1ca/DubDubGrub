//
//  CloudKitManager.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 7.07.22.
//

import CloudKit

struct CloudKitManager {
    
    static func getLocations(completed: @escaping (Result<[DDGLocation], Error>) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescriptor]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completed(.failure(error))
                return
            }
            
            guard let records = records else { return }
            
            let locations: [DDGLocation] = records.map { $0.convertToModel() }
            completed(.success(locations))
        }
    }
}
