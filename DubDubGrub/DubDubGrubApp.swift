//
//  DubDubGrubApp.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 4.07.22.
//

import SwiftUI

@main
struct DubDubGrubApp: App {
    
    let locationsManager = LocationsManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(locationsManager)
        }
    }
}
