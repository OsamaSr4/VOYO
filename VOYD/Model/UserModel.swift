//
//  LoginModel.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//

import Foundation


class UserModel : Codable {
    
    let error: Bool?
    let role ,message: String?
    let token : String?
    let expire_at , user_id :Int?
    
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case role = "role"
        case token = "token"
        case expire_at = "expire_at"
        case user_id = "user_id"
        case message = "message"
    }
}
