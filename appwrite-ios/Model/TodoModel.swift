//
//  TodoModel.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import Foundation
import JSONCodable
import SwiftyJSON
struct TodoItemRequest:Codable{
    var isCompleted:Bool
    var title:String
    var userId:String
    var id:String = UUID().uuidString
}


struct TodoItem:Codable{
    let isCompleted:Bool
    let title:String
    let userId:String
    let id:String
}


struct TodoResponse: Codable {
  
    var title:AnyCodable
    var userId:AnyCodable
    var isCompleted:AnyCodable
}

struct Docs:Codable{
    var data:JSON
}

struct TodoNew:Codable{
    var total:Int
    var documents:[Docs]
}
