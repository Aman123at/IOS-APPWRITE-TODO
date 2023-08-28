//
//  MainViewViewModel.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import Foundation
import JSONCodable
import Appwrite
class MainViewViewModel:ObservableObject{
    @Published var isUserLoggedIn:Bool = false
    @Published var loggedInUserID:String = ""
    @Published var todoItemsList:[TodoItem] = []
    @Published var isTodoListFetched:Bool = false
    let appwriteService = AppwriteService()
    init(){
        if !isUserLoggedIn && loggedInUserID.isEmpty {
            Task{
                
               await self.getUser()
        }
        }
        
//        if todoItemsList.count==0 && !isTodoListFetched  {
//            Task{
//                await self.getTodosList()
//            }
//        }
//
    }
    func setUserLoggedIn(status:Bool){
        self.isUserLoggedIn = status
    }
    
    func setLoggedInUserId(userId:String){
        self.loggedInUserID = userId
    }
    
    func getUser()async{
       
        do{
            let myuser = try await appwriteService.account.get()
          
                if myuser.status {
                    DispatchQueue.main.async {
                        self.isUserLoggedIn = true
                        self.loggedInUserID = myuser.id
                        self.todoItemsList = []
                        self.isTodoListFetched = false
                    }
                    
                }
         
        }catch{
            print("Error calling getuser")
        }
 
    }
    
    func getTodosList()async{
       
        do{
            let todolist = try await appwriteService.databases.listDocuments(databaseId: "64eb15c3135a4f15f05c", collectionId: "64eb15cac145e79adeb0",queries: [
                Query.equal("userId", value: self.loggedInUserID)
               
            ])

            for item in todolist.documents {
                var extracted:[String:Any] = [:]

                for (key,value) in item.data {
                    
                    switch key {
                    case "title":
                        extracted["title"] = value.value
                    case "id":
                        extracted["id"] = value.value
                    case "isCompleted":
                        extracted["isCompleted"] = value.value
                    case "userId":
                        extracted["userId"] = value.value
                    default:
                        print("")
                    }
                    
                }

                let isCompleted = extracted["isCompleted"] as? Bool ?? false
                let title = extracted["title"] as? String ?? ""
                let userId = extracted["userId"] as? String ?? ""
                let id = extracted["id"] as? String ?? ""
                
                let todoItem = TodoItem(isCompleted: isCompleted, title: title, userId: userId, id: id)
                
                DispatchQueue.main.async {
                    self.todoItemsList.append(todoItem)
                   
                }
               


            }
            
            
            DispatchQueue.main.async {
                self.isTodoListFetched = true
            }
            
            
            
         
        }catch{
            print("Error calling getTodosList")
        }
 
    }
    
    func logOutUser()async{
        do{
            let _ = try await appwriteService.account.deleteSessions()
           
            DispatchQueue.main.async {
                self.isUserLoggedIn = false
                self.loggedInUserID = ""
                self.isTodoListFetched = false
                self.todoItemsList = []
            }
            
            
        }catch{
            print("Unable to logout user")
        }
    }
    
    
    
    
    
   
    func deleteTodo(todoId:String)async{
        do{
            let resp = try await appwriteService.databases.deleteDocument(
                databaseId: "64eb15c3135a4f15f05c", collectionId: "64eb15cac145e79adeb0",
                    documentId: todoId
                )
            print(resp)
            
            DispatchQueue.main.async {
                self.todoItemsList.removeAll{
                    $0.id == todoId
                }
            }
            
        }catch{
            print("Unable to delete Todo")
        }
        
    }
    
    
    func updateTodo(item:TodoItem)async{
        do{
            let _ = try await appwriteService.databases.updateDocument(
                databaseId: "64eb15c3135a4f15f05c", collectionId: "64eb15cac145e79adeb0",
                documentId: item.id, data: ["isCompleted":!item.isCompleted]
                )
           
            if let index = self.todoItemsList.firstIndex(where: { $0.id == item.id }){
                DispatchQueue.main.async {
                self.todoItemsList[index] = TodoItem(isCompleted: !item.isCompleted, title: item.title, userId: item.userId, id: item.id)
                }
            }
               
        }catch{
            print("Unable to update Todo")
        }
    }
}
