//
//  AppwriteService.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 26/08/23.
//

import Foundation
import Appwrite
class AppwriteService{
    let client = Client()
         .setEndpoint("https://cloud.appwrite.io/v1")
         .setProject("64e9c46a14bdd68dc9ee")
         .setSelfSigned(true)
    var account: Account
    var databases:Databases
    
    
    init(){
      self.account = Account(client)
        self.databases = Databases(client)
    }
}
