//
//  WidgetMessageViewModel.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-12-08.
//

import Foundation
import WidgetKit

class WidgetMessageViewModel : ObservableObject{

    @Published var message = WidgetMessage()
    @Published var text = String()

    var apiURLString = "https://firestore.googleapis.com/v1/projects/shat-app-892ae/databases/(default)/documents/users/sP2vtpXrewZMq8ePmz9Q2UzuSz03/recent-messages"
    
    func fetchDataFromAPI(){
        guard let apiURL = URL(string: apiURLString) else{
            return
        }
        
        URLSession.shared.dataTask(with: apiURL){
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let er = error{
                print(#function, "Error \(er.localizedDescription)")
            }else{
                //received data or response
                DispatchQueue.global().async {
                    do{
                        if let jsonData = data{
                            //we received data in JSON
                            
                            //start decoding
                            let decoder = JSONDecoder()
                            
                            let decoded = try decoder.decode(WidgetMessage.self, from: jsonData)
                            //you cannot publish any changes from the background thread
                            DispatchQueue.main.async {
                                self.message = decoded
                                self.text = self.message.documents?[0].textValue ?? "unavailable"
                                print(#function, self.message)
                            }
                            
                            
                        }else{
                            print(#function, "JSON data is empty")
                        }
                    }catch let error{
                        print(#function, "Error decoding the data \(error.localizedDescription)")
                    }
                }
            }
            
        }.resume()
        
        WidgetCenter.shared.reloadTimelines(ofKind: "com.caric.SpaceXJSON.ShatAppWidget")
        
    }
}
