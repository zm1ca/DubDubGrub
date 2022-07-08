//
//  AlertItem.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 8.07.22.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

//TODO: Switch to alert(_:isPresented:presenting:actions:message:)
struct AlertContext {
    
    //MARK: - MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                                message: Text("Unable to retrieve locations at this time. Please try again."),
                                                dismissButton: .default(Text("Ok")))
}

