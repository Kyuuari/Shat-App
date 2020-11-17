//
//  User.swift
//  Shat-App
//
//  Created by Neil Sano on 2020-11-10.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User : Codable, Hashable{
    @DocumentID var uid = UUID().uuidString
    var email: String?
    var displayName: String?
    
    init(){}
    
    init(uid: String, name: String?, email: String?){
        self.uid = uid
        self.displayName = name
        self.email = email
    }
}
