//
//  NoListView.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import SwiftUI

struct NoListView: View {
    @EnvironmentObject var mvm :MainViewViewModel
    var body: some View {
        ZStack{
            Color.orange.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    
                    Text("Todo App")
                        .bold()
                        .font(.system(size: 30))
                    Spacer()
                    HStack{
                        Text("Logout")
                            .bold()
                           .foregroundColor(.red)
                        Image(systemName: "power")
                            .foregroundColor(.red)
                    }.onTapGesture {
                        Task{
                            await mvm.logOutUser()
                        }
                    }
                   
                    
                }.padding()
                    .background(Color.teal.opacity(0.4))
                Spacer()
                
                Text("Welcome to Todo App 👋🏻")
                    .bold()
                    .font(.system(size: 40))
                
                NavigationLink{
                    AddTodoView()
                }label:{
                        Text("🗒️ Add Todo")
                             .padding()
                             .background(Color.blue)
                             .foregroundColor(.white)
                             .clipped()
                             .clipShape(RoundedRectangle(cornerRadius: 10))
                }.padding()
                
                
                
                Spacer()

                
                
                           

            }
        }.onAppear(perform: appeared)
    
        
    }
    
    func appeared(){
  
        if mvm.todoItemsList.count==0 && !mvm.isTodoListFetched  {
           
                    Task{
                        await mvm.getTodosList()
                    }
                }
    }
}

struct NoListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoListView()
        }.environmentObject(MainViewViewModel())
        
    }
}
