//
//  ListRowView.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import SwiftUI
let sample = TodoItem(isCompleted: true, title: "Dummy", userId: "12345", id: "123")

func deleteDemo(todoid:String){
    //
}

func updateDemo(updateItem:TodoItem){
    //
}
struct ListRowView: View {
    let item: TodoItem
    let deleteHandler: (String)->Void
    let updateHandler: (TodoItem)->Void
        var body: some View {
           
            HStack{
                
                Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                    .foregroundColor(item.isCompleted ? .green : .red)
                    .onTapGesture {
                        updateHandler(item)
                    }
                Text(item.title)
                    .strikethrough(item.isCompleted,color:.black)
                Spacer()
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding([.leading,.trailing],5)
                    .onTapGesture {
                        deleteHandler(item.id)
                    }
                    
            }.font(.title2)
                .padding(.horizontal, 5)
                .padding(.vertical,8)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(item: sample,deleteHandler: deleteDemo,updateHandler: updateDemo)
    }
}
