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
    
    var uid : String
    var email: String?
    var displayName: String?
    
    
    init(uid: String, displayName: String?, email: String?){
        self.uid = uid
        self.displayName = displayName
        self.email = email
    }
}
