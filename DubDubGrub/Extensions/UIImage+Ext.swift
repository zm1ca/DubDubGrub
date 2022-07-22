//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 21.07.22.
//

import UIKit
import CloudKit

extension UIImage {
    
    func convertToCKAsset() -> CKAsset? {
        // Get apps base document directory url
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document Directory url came back nil")
            return nil
        }
        
        // Append unique id for profile image
        let fileURL = urlPath.appendingPathComponent("selectedAvatarImage")
        
        
        // Write the image data to the ocation the address points to
        // Then create our CKAsset with that fileURL
        guard let imageData = jpegData(compressionQuality: 0.25) else {
            print("Failed with image compression")
            return nil
        }
        
        do {
            try imageData.write(to: fileURL)
            return CKAsset(fileURL: fileURL)
        } catch {
            print("Failed writing image to url")
            return nil
        }
    }
}
