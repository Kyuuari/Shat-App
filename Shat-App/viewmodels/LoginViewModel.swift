//
//  LoginViewModel.swift
//  Shat-App
//
//  Created by Brendon H. on 2020-11-25.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    
}
