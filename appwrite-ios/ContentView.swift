//
//  ContentView.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 26/08/23.
//

//import Appwrite
//
//let client = Client()
//    .setEndpoint("https://cloud.appwrite.io/v1")
//    .setProject("64e9c46a14bdd68dc9ee")
//    .setSelfSigned(status: true)

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainViewModel:MainViewViewModel
   
    var body: some View {
        if mainViewModel.isUserLoggedIn && !mainViewModel.loggedInUserID.isEmpty {
           
            HomePageView()
        }else{
            LoginView()
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }.environmentObject(MainViewViewModel())
        
    }
}
