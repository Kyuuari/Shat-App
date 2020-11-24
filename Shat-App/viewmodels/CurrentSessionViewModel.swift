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
    
    private var displayName = ""
    private var email = ""
    
    var handle: AuthStateDidChangeListenerHandle?
    func listen(){
        handle = Auth.auth().addStateDidChangeListener{ (auth, user) in
            if let user = user {
                print("User retrieved: \(user)")
                return self.currentUser = User(
                    uid: user.uid,
                    displayName : user.displayName,
                    email: user.email
                )
            }else{
                return self.currentUser = nil
            }
        }
    }
    
    
    func insertUser(newUser : User){
        db.collection(DB_NAME).document(newUser.uid).setData([
            "displayName" : newUser.displayName!,
            "email" : newUser.email!,
            "uid" : newUser.uid
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
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
    
    func loadUser() -> Void {
        let user = Auth.auth().currentUser

        let docRef = db.collection("Users").document("\(user!.uid)")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.displayName = "\(document.get("displayName")!)"
                self.email = "\(document.get("email")!)"
                print(self.displayName)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func getUserName() -> String?{
        return displayName
    }
    
    func getUserEmail() -> String?{
        return email
    }
}
