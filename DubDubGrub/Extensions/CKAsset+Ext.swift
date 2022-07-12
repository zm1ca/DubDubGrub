//
//  CKAsset+Ext.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 11.07.22.
//

import CloudKit
import UIKit

extension CKAsset {
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        let placeholder = dimension.placeholderImage
        
        guard let fileURL = self.fileURL else { return placeholder }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
