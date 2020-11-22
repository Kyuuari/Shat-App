//
//  Message.swift
//  Shat-App
//
//  Created by Brendon H. on 2020-11-22.
//

import Foundation
import UIKit
import Firebase
import MessageKit

struct Message: Identifiable {
    
    var id: String = UUID().uuidString
    var content: String
    var created: String
    var senderID: String
    var senderName: String
    
}

func sended(){
    print("Hi")
}




