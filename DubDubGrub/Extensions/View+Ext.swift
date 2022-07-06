//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 6.07.22.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameStyle())
    }
}
