//
//  Session.swift
//  Shat-App
//
//  Created by Neil Sano on 2020-11-10.
//

import Foundation
import Firebase
import SwiftUI

class CurrentSessionViewModel: ObservableObject{
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?
    func listen(){
        handle = Auth.auth().addStateDidChangeListener{ (auth, user) in
            if let user = user {
                print("User retrieved: \(user)")
                self.session = User(
                    uid: user.uid,
                    name: user.displayName,
                    email: user.email
                )
            }else{
                self.session = nil
            }
        }
    }
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    func signOut () {
        do{
            try Auth.auth().signOut()
            self.session = nil
        }catch{
            return
        }
    }
    
    func unbind() {
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
