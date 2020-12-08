//
//  WidgetMessageViewModel.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-12-08.
//

import Foundation
import WidgetKit

class WidgetMessageViewModel : ObservableObject{
//    @Published var missionList = [Mission]()
    @Published var mission = WidgetMessage()
    @Published var text = String()
//    var apiURLString = "https://api.spacexdata.com/v3/launches?limit=50&offset=50"
    var apiURLString = "https://firestore.googleapis.com/v1/projects/shat-app-892ae/databases/(default)/documents/users/prhxYjTNj0bX5IlEkGvC9M0rlwO2/recent-messages"
    
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
                            
//                            let decodedList = try decoder.decode([Mission].self, from: jsonData)
                            let decoded = try decoder.decode(WidgetMessage.self, from: jsonData)
                            //you cannot publish any changes from the background thread
                            DispatchQueue.main.async {
                                self.mission = decoded
                                self.text = self.mission.documents?[0].textValue ?? "unavailable"
//                                self.missionList = decodedList
//                                print(self.mission)
                                print(#function, self.mission)
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
        
        //update Widget when data is available
        WidgetCenter.shared.reloadTimelines(ofKind: "com.caric.SpaceXJSON.ShatAppWidget")
        
//        print(#function, "StockPriceList: \(text)")
    }
}
