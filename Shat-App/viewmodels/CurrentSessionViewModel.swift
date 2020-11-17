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
    @Published var currentUser: User?
    private var db = Firestore.firestore()
    private let DB_NAME = "Users"
    var handle: AuthStateDidChangeListenerHandle?
    func listen(){
        handle = Auth.auth().addStateDidChangeListener{ (auth, user) in
            if let user = user {
                print("User retrieved: \(user)")
                return self.currentUser = User(
                    uid: user.uid,
                    name : user.displayName,
                    email: user.email
                )
            }else{
                return self.currentUser = nil
            }
        }
    }
    func insertUser(newUser : User){
        do{
            _ = try db.collection(DB_NAME).addDocument(from: newUser)
        }catch let error as NSError {
            print(#function,"Error Creating Document: \(error.localizedDescription)")
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
            self.currentUser = nil
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
