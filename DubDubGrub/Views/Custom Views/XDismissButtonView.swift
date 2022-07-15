//
//  XDismissButtonView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 15.07.22.
//

import SwiftUI

struct XDismissButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.brandPrimary)
            
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .imageScale(.small)
                .frame(width: 44, height: 44)
        }
    }
}

struct XDismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButtonView()
    }
}
