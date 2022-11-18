//
//  LoadingView.swift
//  DubDubGrub
//
//  Created by Dzmitry Fedchanka on 18.11.22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
                .ignoresSafeArea()
            
            ProgressView()
                .tint(Color.brandPrimary)
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .offset(y: -40)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
