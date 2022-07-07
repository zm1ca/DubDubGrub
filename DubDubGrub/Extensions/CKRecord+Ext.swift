//
//  CKRecord+Ext.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 7.07.22.
//

import Foundation
import CloudKit

extension CKRecord {
    
    func convertToModel<T: RecordInitiatable>() -> T {
        T(record: self)
    }
}
