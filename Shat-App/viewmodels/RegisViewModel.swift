//
//  RegisViewModel.swift
//  Shat-App
//
//  Created by Brendon H. on 2020-11-25.
//

import Foundation

struct RegisViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
    }
}
