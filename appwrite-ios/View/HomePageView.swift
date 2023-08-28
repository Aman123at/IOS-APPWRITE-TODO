//
//  HomePageView.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 26/08/23.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var mainvm :MainViewViewModel
    
    var body: some View {
        ZStack{
            if mainvm.todoItemsList.count>0 {
                ListView()
            }else{
                NoListView()
            }

               

            
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomePageView()
        }.environmentObject(MainViewViewModel())
            
        
    }
}
