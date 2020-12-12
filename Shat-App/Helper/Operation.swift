//
//  Operation.swift
//  Shat-App
//
//  Created by Brendon H. on 2020-12-02.
//

import Foundation
import Firebase
import SwiftUI
import CoreLocation

typealias FirestoreCompletion = ((Error?) -> Void)?

struct Operation {
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            guard var users = snapshot?.documents.map({ User(dictionary: $0.data()) }) else { return }
            
            if let i = users.firstIndex(where: { $0.uid == Auth.auth().currentUser?.uid }) {
                users.remove(at: i)
            }
            
            completion(users)
        }
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchConversations(completion: @escaping([Conversation]) -> Void) {
        var conversations = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = Firestore.firestore().collection("users").document(uid).collection("recent-messages").order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                
                self.fetchUser(withUid: message.chatPartnerId) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
            })
        }
    }
    
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
                
        let query = Firestore.firestore().collection("users").document(currentUid).collection(user.uid).order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
            })
        }
    }
    
    static func uploadMessage(_ message: String, to user: User ,locationManager: LocationManager, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        var messageLat: Double = 0.0
        var messageLng: Double = 0.0
        messageLat = locationManager.lat
        messageLng = locationManager.lng
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date()),
                    "lat": messageLat,
                    "lng": messageLng ] as [String : Any]
        
        Firestore.firestore().collection("users").document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            Firestore.firestore().collection("users").document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
        Firestore.firestore().collection("users").document(currentUid).collection("recent-messages").document(user.uid).setData(data)
            
        Firestore.firestore().collection("users").document(user.uid).collection("recent-messages").document(currentUid).setData(data)
        }
    }
    
    static func updateUserData(user: User, completion: FirestoreCompletion) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = ["username": user.username,
                    "fullname": user.fullname]
        
        Firestore.firestore().collection("users").document(uid).updateData(data, completion: completion)
    }
    
    static func deleteMessages(withUser user: User, completion: FirestoreCompletion) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).collection(user.uid).getDocuments { snapshot, error in
            
            snapshot?.documents.forEach({ document in
                let id = document.documentID
                
                Firestore.firestore().collection("users").document(uid).collection(user.uid).document(id).delete()
            })
        }
        
        let ref = Firestore.firestore().collection("users").document(uid).collection("recent-messages").document(user.uid)
        ref.delete(completion: completion)
    }
    

}
