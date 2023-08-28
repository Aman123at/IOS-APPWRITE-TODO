//
//  AddTodoView.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import SwiftUI

struct AddTodoView: View {
    @State var todoTitle:String = ""
    @State var showAlert:Bool = false
    @State var alertMessage:String = ""
    let todovm = TodoViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var mainvm:MainViewViewModel
    var body: some View {
        ZStack{
            Color.orange.opacity(0.3).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    
                    Text("Add Todo")
                        .bold()
                        .font(.system(size: 30))
                    Spacer()
                    Text("Home")
                        .padding(10)
                        .bold()
                        .foregroundColor(.white.opacity(0.9))
                        .background(Color.blue.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                }.padding(20)
                    .background(Color.teal.opacity(0.4))
                
               
                
                VStack{
                    TextField(text:$todoTitle){
                        Text("Enter Todo 🖊")
                    }.padding()
                        .textInputAutocapitalization(.never)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipped()
                        .cornerRadius(10)
                    
                    
                    Button {
                        handleAddTodo()
                      
                    } label: {
                        Text("+ Add Todo")
                            .padding(.vertical,20)
                            .padding(.horizontal,50)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }.padding(.top,5)
                        
                }.padding()
                Spacer()
                
               
            }
            
            
           
            
            
        }.alert(isPresented: $showAlert, content: getAlert)
            .navigationBarHidden(true)
            
        
 
    }
    
    func handleAddTodo(){
        if todoTitle.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please write an item"
            showAlert.toggle()
            
        }else{
            Task{
                 let resp = await todovm.addTodo(todoTitle:todoTitle,user:mainvm.loggedInUserID)
                if !resp.title.isEmpty{
                    DispatchQueue.main.async {
                        mainvm.todoItemsList.append(resp)
                    }
                }
               
                
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func getAlert()->Alert{
        return Alert(title: Text(alertMessage))
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTodoView()
        }.environmentObject(MainViewViewModel())
        
    }
}
