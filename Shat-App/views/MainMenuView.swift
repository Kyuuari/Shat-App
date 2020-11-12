//
//  MainMenuView.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-11-05.
//

import SwiftUI

struct ChatHistory : Hashable {
    var id = UUID()
    var avatar: String
    var partner: String
    var message: String
}

struct HistoryRow : View {
    var chatHistory: ChatHistory
    var body: some View {
        Group {
            HStack{
                //Image of Users?
                Circle()
                    .fill(Color.white)
                    .frame(width: 50, height: 50)
                    .padding(.leading)
                
                VStack(alignment:.leading){
                    Text(chatHistory.partner)
                        .padding(.leading)
                    
                    Text(chatHistory.message)
                        .bold()
                        .padding(.leading)
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                }
                
                Spacer()
                Text("Oct 15")
                    .padding(.trailing)
                
            }
            .padding(.vertical)
            .background(Color.blue)
            
        }
        .cornerRadius(25)
    }
}

struct MainMenuView: View {
    @EnvironmentObject var session : CurrentSessionViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selection: Int? = nil
    
    @State var history = [
        ChatHistory(avatar: "Tim",partner: "Tom",message: "Hello"),
        ChatHistory(avatar: "Tim",partner: "Bob",message: "My name is Bob I'm looking to work with you"),
        ChatHistory(avatar: "Tim",partner: "Alex",message: "$5 for the GoPro"),
        //        ChatHistory(avatar: "Tim",partner: "Alex",message: "Hello world"),
        //        ChatHistory(avatar: "Tim",partner: "Alex",message: "Hello world"),
        //        ChatHistory(avatar: "Tim",partner: "Alex",message: "Hello world"),
        //        ChatHistory(avatar: "Tim",partner: "Alex",message: "Hello world"),
        //        ChatHistory(avatar: "Tim",partner: "Alex",message: "Hello world"),
        //        ChatHistory(avatar: "Tim",partner: "Alex",message: "Hello world"),
        //        ChatHistory(avatar: "Tim",partner: "Alex",message: "Hello world"),
        //        ChatHistory(avatar: "Tim",partner: "Alex",message: "Hello world"),
    ]
    
    
    var body: some View {
//        NavigationView{
            
            VStack{
                ScrollView {
                    NavigationLink(destination: ChatRoomView(), tag: 2, selection: $selection){}
                    
                    LazyVStack {
                        ForEach(history, id: \.self) { log in
                            HistoryRow(chatHistory: log)
                                .onTapGesture{
                                    self.selection = 2
//                                    print("Pressed")
                                }
                            
                        }
                    }
                    .padding()
                    
                }
                // that's the height of the HStack
                .navigationBarTitle("")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Menu{
                            Button("Sign Out", action: self.logout)
                        }label:{
                            Image(systemName: "gear")
                        }
                    }
                }
                
                
            }//VStack
            .navigationBarTitle("Chat History")
            .navigationBarBackButtonHidden(true)
            
//        }//NavigationView

    }
    func logout(){
        self.session.signOut()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
