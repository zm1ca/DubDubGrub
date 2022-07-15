//
//  LogoView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 13.07.22.
//

import SwiftUI

struct LogoView: View {
    
    let frameWidth: CGFloat
    
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(frameWidth: 250)
    }
}
