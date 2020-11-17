//
//  UserProfileView.swift
//  Shat-App
//
//  Created by Neil Sano on 2020-11-15.
//

import SwiftUI

struct UserProfileView: View {
    let gradient = Gradient(colors: [.gray,.purple])
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                VStack{
                    //Eventually Have an Image that will use the Camera or Photo Library
                    Text("User Profile").padding() // plan to use the user's actual name
                    Section(header: Text("User Options")){
                        Button(action: {
                            print("Edit User Pressed")
                        }, label: {
                            Text("Edit User")
                        })
                        .padding()
                        Button(action:{
                            print("Delete User Pressed")
                            //todo: send out an alert asking if the user's surely wants to delete account
                        }, label:{
                            Text("Delete User").foregroundColor(.red)
                        }).padding()
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea()
        .navigationTitle("Your Profile")
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
