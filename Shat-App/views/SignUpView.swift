//
//  SignUpView.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-11-05.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email:String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = true
    @State private var selection: Int? = nil
    @State private var invalidLogin: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                
                Section{
                    Form{
                        
                        Section(header:Text("Information")){
                            TextField("Name", text: self.$email)
                            TextField("Email", text: self.$email)
                                .autocapitalization(.none)
                            SecureField("Password", text: self.$password)
                            SecureField("Renter Password", text: self.$password)
                        }
                        
                        
                        Button(action: {
                            
                        }){
                            Text("Submit")
                        }
    
                    }//Form
                }//Section
            }//Vstack
            .navigationBarTitle("Register Account", displayMode: .inline)
            
        }//NavigationView

    }//View
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
