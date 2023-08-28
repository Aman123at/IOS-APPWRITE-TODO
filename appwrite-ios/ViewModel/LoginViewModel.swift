//
//  LoginViewModel.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 27/08/23.
//

import Foundation

struct LoginResponseModel{
    let ip:String
    let deviceName:String
    let current:Bool
    let deviceModel:String
    let providerUid:String
    let osName:String
    let countryCode:String
    let clientName:String
    let clientType:String
    let userId:String
    let countryName:String
}


class LoginViewModel{
    let appwrite = AppwriteService()
    init(){}
    
    func loginUser(email:String, password:String)async -> LoginResponseModel{
     
        
        do{
            let response = try await appwrite.account.createEmailSession( email: email, password: password)
            if response.current {
                print("REsponse true") 
            }
            
            
            let exactResponse = LoginResponseModel(ip: response.ip, deviceName: response.deviceName, current: response.current, deviceModel: response.deviceModel, providerUid: response.providerUid, osName: response.osName, countryCode: response.countryCode, clientName: response.clientName, clientType: response.clientType, userId: response.userId, countryName: response.countryName)
            
            return exactResponse
            
        }catch {
            print("Unable to fetch or decode")
            return LoginResponseModel(ip: "", deviceName: "", current: false, deviceModel: "", providerUid: "", osName: "", countryCode: "", clientName: "", clientType: "", userId: "", countryName: "")
        }
    }
    
}
