//
//  ChatRoomView.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-11-05.
//  Modified by brendon 01

import SwiftUI
/*
struct ChatMessage : Hashable {
    var id = UUID()
    var message: String
    var avatar: String
    var color: Color
    var isMe: Bool = false
}


struct ChatRow : View {
   
    // we will need to access and represent the chatMessages here
    @ObservedObject var chatModel = ChatViewModel()
    var chatMessage: ChatMessage
    var body: some View {
        Group {
            if !chatMessage.isMe {
                HStack {
                    Group {
                        Text(chatMessage.avatar)
                        Text(chatMessage.message)
                            .bold()
                            .padding(12)
                            .foregroundColor(Color.white)
                            .background(chatMessage.color)
                            .cornerRadius(10)
                        Spacer()
                    }.padding(.vertical)
                }
            } else {
                HStack {
                    Group {
                        Spacer()
                        Text(chatMessage.message)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(12)
                            .background(chatMessage.color)
                            .cornerRadius(10)
                        Text(chatMessage.avatar)
                    }.padding(.vertical)
                }
            }
        }
    }
}

struct ChatRoomView: View {
    // @State here is necessary to make the composedMessage variable accessible from different views
    @EnvironmentObject var chat : ChatViewModel
    @State var composedMessage: String = ""
    @State var messages = [
        ChatMessage(message: "Hello world",avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Hello world", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Hi", avatar: "Tom", color: .blue),
        ChatMessage(message: "Yo Wats up this is a very long message", avatar: "Tom", color: .blue),
        ChatMessage(message: "Im here", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Im here 1", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Im here 2 ", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Yo Wats this a very long message", avatar: "Tom", color: .blue),
        ChatMessage(message: "Im here 3", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Im here 4", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Im here 5", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Yo up this is a very long message", avatar: "Tom", color: .blue),
        ChatMessage(message: "Im here 5", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Im here 5", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Im here 5", avatar: "Me", color: .green, isMe: true),
        ChatMessage(message: "Im here 5", avatar: "Me", color: .green, isMe: true),
    ]

                    
    
    var body: some View {
        
//        NavigationView{
            
            VStack{
                ScrollView {
                    
                    LazyVStack {
                        ForEach(messages, id: \.self) { msg in
                            ChatRow(chatMessage: msg)
                        }
                    }
                    .padding()
                    
                }
                
                
                HStack() {
                    // this textField generates the value for the composedMessage @State var
                    TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                    Button(action:{
                        self.sendMessage()
                    }) {
                        Text("Send")
                    }
                }.frame(minHeight: CGFloat(60)).padding()

                
                
            }//VStack
            .navigationBarTitle("Chat",displayMode: .inline)
            .font(.headline)
//        }//NavigationView
//                .navigationBarHidden(true)
        
    }
    
          func sendMessage() {
            messages.append(ChatMessage(message: composedMessage, avatar: "Me", color: .green, isMe: true))
              composedMessage = ""

          }
        
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView()
    }
}
 */
