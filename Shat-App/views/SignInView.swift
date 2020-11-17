//
//  SignInView.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-11-03.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var session : CurrentSessionViewModel
    @State private var email:String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = true
    @State private var selection: Int? = nil
    @State private var invalidLogin: Bool = false
    @State private var signUpPressed: Bool = false
    
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
                            session.signIn(email: email, password: password){ (result, error) in
                                if error != nil {
                                    print(#function, "Error: ", error!)
                                }else{
                                    UserDefaults.standard.setValue(self.rememberMe, forKey: "COM_SHATAPP")
                                    if(self.rememberMe){
                                        UserDefaults.standard.setValue(self.email, forKey: "KEY_EMAIL")
                                        UserDefaults.standard.setValue(self.password, forKey: "COM_SHATAPP_PASSWORD")
                                    }else{
                                        UserDefaults.standard.removeObject(forKey: "KEY_EMAIL")
                                        UserDefaults.standard.removeObject(forKey: "COM_SHATAPP_PASSWORD")
                                    }
                                    self.email = ""
                                    self.password = ""
                                    self.selection = 1
                                }
                                
                            }
                        }){
                            Text("Sign In")
                        }
                        
                        Button(action: {
                            self.signUpPressed = true
                            print("SignUp Button pressed")
                        }){
                            Text("Sign Up")
                        }.sheet(isPresented: $signUpPressed){
                            SignUpView()
                        }
                    }//Form
                }
            }//Vstack
            .onAppear(){
                self.email = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
                self.password = UserDefaults.standard.string(forKey: "COM_SHATAPP_PASSWORD") ?? ""
                self.rememberMe = UserDefaults.standard.bool(forKey: "COM_SHATAPP")
            }
            .navigationBarTitle("Shat-App", displayMode: .inline)
            
        }//NavigationView
        
    }//View
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
