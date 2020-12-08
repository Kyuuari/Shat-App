//
//  WidgetMessage.swift
//  Shat-App
//
//  Created by Chester Cari on 2020-12-08.
//

import Foundation

struct Document:Codable{
    let name: String
    let textValue: String
    let fromId: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fields = "fields"
        case text = "text"
        case stringValue = "stringValue"
        case fromId = "fromId"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let fields = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .fields)
        
        let text = try fields.nestedContainer(keyedBy: CodingKeys.self, forKey: .text)
        let from = try fields.nestedContainer(keyedBy: CodingKeys.self, forKey: .fromId)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.textValue  = try text.decode(String.self, forKey: .stringValue)
        self.fromId  = try from.decode(String.self, forKey: .stringValue)
    }
    func encode(to encoder: Encoder) throws {

    }
}

//Codable type will allow encoding-decoding from custom types; JSON in our case
struct WidgetMessage: Codable{
    var documents: [Document]?
    init() {
        documents = []
    }
    
    enum CodingKeys: String, CodingKey{
        case names = "name"
        case documents = "documents"
    }
    
    init(from decoder: Decoder) throws {
        
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.documents = try response.decodeIfPresent([Document].self, forKey: .documents)
        print("Working")
    }
    
    func encode(to encoder: Encoder) throws {
        //Nothing to encode
    }
}
