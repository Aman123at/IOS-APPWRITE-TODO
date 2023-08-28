//
//  TodoViewModel.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import Foundation

class TodoViewModel{
    let appwrite = AppwriteService()
    init(){}
    func addTodo(todoTitle:String,user:String)async -> TodoItem{
        let todoItem = TodoItemRequest(isCompleted: false, title: todoTitle, userId: user)
        
        let requestData:[String:Any] = ["id":todoItem.id,"title":todoItem.title,"isCompleted":todoItem.isCompleted,"userId":todoItem.userId]
        do{
            
            let _ = try await appwrite.databases.createDocument(databaseId: "64eb15c3135a4f15f05c", collectionId: "64eb15cac145e79adeb0", documentId: todoItem.id, data: requestData)
            
            
            return TodoItem(isCompleted: todoItem.isCompleted, title: todoItem.title, userId: todoItem.userId, id: todoItem.id)
            
        }catch{
            print("Unable to add todo")
            return TodoItem(isCompleted: false, title: "", userId: "", id: "")
        }
    }
}
