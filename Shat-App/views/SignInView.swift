//
//  SignInView.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-11-03.
//

import SwiftUI

struct SignInView: View {
    
    
    @State private var email:String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = true
    @State private var selection: Int? = nil
    @State private var invalidLogin: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                Section{
                    NavigationLink(destination: MainMenuView(), tag: 1, selection: $selection){}
                    Form{
                        
                        Section{
                            TextField("Email", text: self.$email)
                                .autocapitalization(.none)
                            SecureField("Password", text: self.$password)
                            
                            VStack(alignment: .trailing, spacing: 10){
                                Toggle(isOn: self.$rememberMe, label: {
                                    Text("Remember my credentials")
                                })
                            }
                        }
                        
                        
                        Button(action: {
                            self.selection = 1
                        }){
                            Text("Sign In")
                        }
                        
                        Button(action: {
                            
                        }){
                            Text("Sign Up")
                        }
                    }//Form
                }
            }//Vstack
            .navigationBarTitle("Shat-App", displayMode: .inline)
            
        }//NavigationView
        
    }//View
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
