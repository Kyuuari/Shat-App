//
//  SignUpView.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-11-05.
//

import SwiftUI
import FirebaseAuth
/*
struct SignUpView: View {
    @EnvironmentObject var session : CurrentSessionViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name:String = ""
    @State private var email:String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var rememberMe: Bool = true
    @State private var selection: Int? = nil
    @State private var invalidLogin: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                
                Section{
                    Form{
                        
                        Section(header:Text("Information")){
                            TextField("Name", text: self.$name)
                            TextField("Email", text: self.$email)
                                .autocapitalization(.none)
//                            SecureField("Password", text: self.$password)
//                            SecureField("Renter Password", text: self.$confirmPassword)
                            TextField("Password", text: self.$password)
                            TextField("Renter Password", text: self.$confirmPassword)
                        }
                        
                        
                        Button(action: {
                            session.signUp(email: email, password: password){ (result, error) in
                                if error != nil {
                                    print(#function, "Error: ", error!)
                                }else{
                                    session.insertUser(newUser: User(uid: result!.user.uid, displayName: name, email: result!.user.email))
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                
                                
                            }
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
 */
