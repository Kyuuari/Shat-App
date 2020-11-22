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
    
    func sendData(){
        db.collection("Messages").add({
            content: "Tokyo",
            created: "Today",
            senderID: "01",
            senderName: "Brendon"
        });
    }
    

    
    
    
  }
