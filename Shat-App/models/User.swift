//
//  User.swift
//  Shat-App
//
//  Created by Neil Sano on 2020-11-10.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var name: String?
    
    init(uid: String, name: String?, email: String?){
        self.uid = uid
        self.name = name
        self.email = email
    }
}
