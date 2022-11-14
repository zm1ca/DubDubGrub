//
//  OnboardingView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 13.07.22.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var isShowingOnboaringView: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button {
                    isShowingOnboaringView = false
                } label: {
                    XDismissButtonView()
                        .padding()
                }
            }
            
            Spacer()
            
            LogoView(frameWidth: 250)
                .padding(.bottom)
            
            VStack (alignment: .leading, spacing: 24) {
                OnboardingTipView(imageSystemName: "building.2.crop.circle",
                                  title: "Restaurant Locations",
                                  description: "Find places to dine around the convention center")
                
                OnboardingTipView(imageSystemName: "checkmark.circle",
                                  title: "Check In",
                                  description: "Let other iOS Devs know where you are")
                
                OnboardingTipView(imageSystemName: "person.2.circle",
                                  title: "Find Friends",
                                  description: "See where other iOS Devs are and join party")
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
    }
}

struct OnboardingTipView: View {
    
    let imageSystemName: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageSystemName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
                
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title).bold()
                Text(description)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isShowingOnboaringView: .constant(true))
            .preferredColorScheme(.dark)
    }
}
