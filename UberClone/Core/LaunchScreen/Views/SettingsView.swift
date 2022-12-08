//
//  SettingsView.swift
//  UberClone
//
//  Created by Tom Miller on 06/12/2022.
//

import SwiftUI
import Firebase
struct SettingsView: View {
    var username: String = Auth.auth().currentUser?.email ?? "User"
    @Binding var settingsOn: Bool
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea()
            
            VStack{
                Image("profile-picture")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .clipShape(Circle())
                    .background(
                    Circle()
                        .fill(.white)
                    )
                Text(username)
                    .foregroundColor(.white)
                    .font(.title)
                Text("Uber Rider")
                    .foregroundColor(.darkGray)
                
                    
                Spacer()
                
                Button{
                    do {
                        launchScreenManager.state = .first
                        try Auth.auth().signOut()
                        settingsOn.toggle()
                    }
                    catch{
                        print("Error signing out!")
                    }
                } label:{
                    Text("Sign Out")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                        )
                }
                .padding(.bottom, 50)
            }
            .padding(.top, 80)
            
            
            
                
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsOn: .constant(false))
    }
}
