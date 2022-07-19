//
//  ProfileHeaderView.swift
//  DubDubGrub
//
//  Created by Źmicier Fiedčanka on 6.07.22.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @Binding var firstName:   String
    @Binding var lastName:    String
    @Binding var companyName: String
    @Binding var avatar:      UIImage
    @Binding var isShowingPhotoPicker: Bool
    
    var body: some View {
        HStack {
            ZStack {
                AvatarView(size: 84, image: avatar).padding()
                EditImageView().offset(y: 30)
            }
            .onTapGesture {
                isShowingPhotoPicker = true
            }
            
            VStack (alignment: .leading, spacing: 1) {
                TextField("First Name", text: $firstName)
                    .font(.system(size: 32, weight: .bold))
                
                TextField("Last Name", text: $lastName)
                    .font(.system(size: 32, weight: .bold))
                
                TextField("YouTuber & Indie Dev", text: $companyName)
            }
            .profileNameStyle()
            .padding(.trailing, 16)
            
            Spacer()
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(firstName: .constant("Sean"),
                          lastName: .constant("Allen"),
                          companyName: .constant("YouTuber & iOS Developer"),
                          avatar: .constant(PlaceholderImage.avatar),
                          isShowingPhotoPicker: .constant(false)
        )
    }
}
