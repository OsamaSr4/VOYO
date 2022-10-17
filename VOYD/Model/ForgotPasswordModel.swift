//
//  ForgotPasswordModel.swift
//  VOYD
//
//  Created by MacBook Pro on 18/10/2022.
//

import Foundation

class ForgotPasswordModel : Codable {
    
    let error: Bool?
    let message: String?
    let token ,code: String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "message"
        case token = "token"
        case code = "code"
        
    }
}
