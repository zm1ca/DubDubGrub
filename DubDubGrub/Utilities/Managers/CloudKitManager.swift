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
        
        CKContainer.default().publicCloudDatabase.fetch(withQuery: query) { result in
            switch result {
            case .success((let matchResults, _)):
                var locations: [DDGLocation] = []
                
                for result in matchResults {
                    switch result.1 {
                    case .success(let record):
                        locations.append(record.convertToModel())
                    case .failure(let error):
                        completed(.failure(error)) // is that desired behavior?
                    }
                }
                
                completed(.success(locations))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
}
