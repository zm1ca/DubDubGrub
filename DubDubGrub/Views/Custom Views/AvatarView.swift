//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 6.07.22.
//

import SwiftUI

struct AvatarView: View {
    
    let size: CGFloat
    
    var body: some View {
        Image("default-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(size: 90)
    }
}
