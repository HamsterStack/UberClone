//
//  LaunchScreen.swift
//  UberClone
//
//  Created by Tom Miller on 05/12/2022.
//

import SwiftUI
import Firebase

struct LaunchScreen: View {
    @EnvironmentObject var launchScreenManager : LaunchScreenManager
    @EnvironmentObject var AuthViewModel: AuthViewModel
    
    
    
    
    
    @State private var firstPhaseIsAnimating: Bool = false
    @State private var secondPhaseIsAnimating: Bool = false
    
    @State private var email : String = ""
    @State private var password: String = ""
    
    @State private var userIsLoggedIn = false
    
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack{
            
            Color("LaunchScreenBackground")
                .ignoresSafeArea()
            VStack{
                Image("logo")
                    .scaleEffect(firstPhaseIsAnimating ? 1 : 1)
                    .scaleEffect(secondPhaseIsAnimating ? UIScreen.main.bounds.size.height / 4 : 1)
                    .padding(48)
                Spacer()
                
            }
            
            VStack(){
                if let msg = AuthViewModel.errorMessage{
                    Text(msg)
                        .foregroundColor(.white)
                        .font(.title)
                }
                TextField("", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty){
                        Text("Email")
                            .foregroundColor(.white)
                    }
                    .frame(width: 280)
                    .padding()
                    .background(Color.theme.launchScreenTextColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                SecureField("", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty){
                        Text("Password")
                            .foregroundColor(.white)
                    }
                    .frame(width: 280)
                    .padding()
                    .background(Color.theme.launchScreenTextColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Button{
                    AuthViewModel.login(email: email, password: password)

                } label: {
                    Text("Log in")
                        .bold()
                        .frame(width: 200, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.lightGray, .darkGray], startPoint: .top, endPoint: .bottomTrailing))
                            
                        )
                        .foregroundColor(.white)
                        .shadow(radius :3)
                }
                .padding(.top, 16)
                
                
                Button{
                    AuthViewModel.register(email: email, password: password)
                } label:{
                    Text("Don't have an account? Sign up!")
                        .frame(width: 300, height: 35)
                        .foregroundColor(.white)
                        
                }
                .padding(.top, 24)
                
                
                
                
                
            }
            
            
        }
        .onAppear{
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil{
                    launchScreenManager.dismiss()
                    
                }
            }
        }
        .onReceive(timer){ input in
            switch launchScreenManager.state {
            case .first:
                withAnimation(.spring()) {
                    firstPhaseIsAnimating.toggle()
                }
            case .second:
                withAnimation(.easeInOut) {
                    secondPhaseIsAnimating.toggle()
                }
            default:
                break
            }
        }
        
        .opacity(secondPhaseIsAnimating ? 0 : 1)
    }
    
    
    
    
    
    
    
    
    
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
