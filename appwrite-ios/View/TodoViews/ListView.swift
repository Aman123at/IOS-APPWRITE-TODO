//
//  ListView.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var mainVM:MainViewViewModel
    var body: some View {
        ZStack{
            Color.orange.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Text("Todo List")
                        .bold()
                        .padding()
                        .font(.system(size: 30))
                    Spacer()
                    HStack{
                        Text("Logout")
                            .bold()
                            .foregroundColor(.red)
                        Image(systemName: "power")
                            .foregroundColor(.red)
                    }.padding()
                        .onTapGesture {
                            Task{
                                await mainVM.logOutUser()
                            }
                        }
                    
                }
                    .background(Color.teal.opacity(0.4))
                
                    
                  
                ScrollView{
                    ForEach(mainVM.todoItemsList,id: \.id) { todo in
                        ListRowView(item: todo,deleteHandler:handleDeleteTodo,updateHandler: handleUpdateTodo)
                            .padding(.horizontal)
                            
                    }
                }
                NavigationLink{
                    AddTodoView()
                }label:{
                    
                        Text("Add More Todos")
                        .padding(.vertical,20)
                        .padding(.horizontal,50)
                        .bold()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
           

        }
        
       
    }
    
    
    func handleDeleteTodo(_ todoid:String)->Void{
        Task{
            await mainVM.deleteTodo(todoId:todoid)
        }
    }
    
    
    
    func handleUpdateTodo(_ updateItem:TodoItem)->Void{
        Task{
            await mainVM.updateTodo(item:updateItem)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }.environmentObject(MainViewViewModel())
        
    }
}
