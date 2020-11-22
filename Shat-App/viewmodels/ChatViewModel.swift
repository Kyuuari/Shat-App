//
//  ChatViewModel.swift
//  Shat-App
//
//  Created by Brendon H. on 2020-11-21.
//


import Foundation
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
      db.collection("Messages").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }

          self.messages = documents.map { queryDocumentSnapshot -> Message in
          let data = queryDocumentSnapshot.data()
          let content = data["content"] as? String ?? ""
          let created = data["created"] as? String ?? ""
          let senderID = data["senderID"] as? String ?? ""
          let senderName = data["senderName"] as? String ?? ""

            return Message(id: .init(), content: content, created: created, senderID: senderID,senderName: senderName)
        }
        
       
      }
    }
    
    let msg = Message(content: "123",created: "2 Nov",senderID:"001",senderName:"Brendon")
    
    
    func sendData(){
        do {
            try db.collection("Message").document("test").setData(from: msg)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    

    
    
    
  }
