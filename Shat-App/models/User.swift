//
//  User.swift
//  Shat-App
//
//  Created by Neil Sano on 2020-11-10.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class User: Codable {
    
    let uid: String
    let profileImageUrl: String
    var username: String
    var fullname: String
    var email: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
