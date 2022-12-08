//
//  AuthViewModel.swift
//  UberClone
//
//  Created by Tom Miller on 06/12/2022.
//

import Firebase

class AuthViewModel: ObservableObject{
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    @Published var errorMessage: String?
    
    
    func register(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                print("ERROR: \(err.localizedDescription)")
                self.errorMessage = err.localizedDescription
            }
            Auth.auth().currentUser?.sendEmailVerification{ error in
                //we send email verif
            }
            
        }
    }
    
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let result = result{
                
                print("signed in \(result)")
            }
        }
    }
}
