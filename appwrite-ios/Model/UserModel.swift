//
//  UserModel.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 26/08/23.
//

import Foundation

struct UserModel{
    let userId:String = UUID().uuidString
    let email:String
    let password:String
    let name:String
}




struct UserInfo: Codable {
    let id: UUID
    let createdAt: Date
    let name: String
    let password: String?
    let passwordUpdate: Date
    let phoneVerification: Bool
    let email: String
    let status: Bool
    let updatedAt: Date
    let prefs: [String: Data] // Or appropriate type for prefs
    let phone: String
    let registration: Date
    let hash: String?
    let emailVerification: Bool
    let hashOptions: String?
    
    enum CodingKeys: String, CodingKey {
            case id = "$id"
            case createdAt = "$createdAt"
            case name
            case password
            case passwordUpdate
            case phoneVerification
            case email
            case status
            case updatedAt = "$updatedAt"
            case prefs
            case phone
            case registration
            case hash
            case emailVerification
            case hashOptions
        }
    
}

