//
//  appwrite_iosApp.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 26/08/23.
//

import SwiftUI

@main
struct appwrite_iosApp: App {
    @StateObject var mainViewM:MainViewViewModel = MainViewViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.environmentObject(mainViewM)
               
          
        }
    }
}
