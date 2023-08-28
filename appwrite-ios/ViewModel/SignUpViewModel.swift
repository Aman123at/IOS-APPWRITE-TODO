//
//  SignUpViewModel.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import Foundation
class SignUpViewModel{
    let appwrite = AppwriteService()
    init(){}
    func registerUser(email:String, password:String,name:String)async -> Bool{
        let user = UserModel(email: email, password: password,name: name)
        
        do{
            let response = try await appwrite.account.create(userId: user.userId, email: user.email, password: user.password,name: name)
            return response.status
            
        }catch{
            print("Unable to fetch or decode")
            return false
        }
    }
}
