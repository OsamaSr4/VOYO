//
//  Authentication.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//

import Foundation

typealias UserModelResponse = (Result<UserModel,Error>) -> Void
typealias ForgotPassModelResponse = (Result<ForgotPasswordModel,Error>) -> Void

class Repo_Authentication: NSObject {
    
    static let sharedInstance: Repo_Authentication = {
        let instance = Repo_Authentication()
        return instance
    }()
    
    func loginUserr(params : Params , completionHandler : @escaping UserModelResponse) {
        ApiManager.request("\(endPoints.loginUser)", httpMethod: .post, params: params, headers: [:]) { response in
            switch response {
            case.success(let json):
                do{
                    let jsonData = try json.rawData()
                    let response = try JSONDecoder().decode(UserModel.self, from: jsonData)
                    completionHandler(.success(response))
                }catch let error {
                    completionHandler(.failure(error))
                    print(error)
                }
                break
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    



    func userRegister(params : Params , completionHandler : @escaping UserModelResponse) {
        
        
        ApiManager.request("\(endPoints.registerr)", httpMethod: .post, params: params, headers: [:]) { response in
            switch response {
            case.success(let json):
                do{
                    let jsonData = try json.rawData()
                    let response = try JSONDecoder().decode(UserModel.self, from: jsonData)
                    completionHandler(.success(response))
                }catch let error {
                    completionHandler(.failure(error))
                    print(error)
                }
                break
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    
    func updateProfile(params : Params , completionHandler : @escaping UserModelResponse) {
        ApiManager.request("\(endPoints.profile)", httpMethod: .post, params: params, headers: [:]) { response in
            switch response {
            case.success(let json):
                do{
                    let jsonData = try json.rawData()
                    let response = try JSONDecoder().decode(UserModel.self, from: jsonData)
                    completionHandler(.success(response))
                }catch let error {
                    completionHandler(.failure(error))
                    print(error)
                }
                break
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func forgotPassword(params : Params , completionHandler : @escaping ForgotPassModelResponse) {
        ApiManager.request("\(endPoints.forgotPass)", httpMethod: .post, params: params, headers: [:]) { response in
            switch response {
            case.success(let json):
                do{
                    let jsonData = try json.rawData()
                    let response = try JSONDecoder().decode(ForgotPasswordModel.self, from: jsonData)
                    completionHandler(.success(response))
                }catch let error {
                    completionHandler(.failure(error))
                    print(error)
                }
                break
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func ResetPassworrd(params : Params , completionHandler : @escaping UserModelResponse) {
        ApiManager.request("\(endPoints.resetPass)", httpMethod: .post, params: params, headers: [:]) { response in
            switch response {
            case.success(let json):
                do{
                    let jsonData = try json.rawData()
                    let response = try JSONDecoder().decode(UserModel.self, from: jsonData)
                    completionHandler(.success(response))
                }catch let error {
                    completionHandler(.failure(error))
                    print(error)
                }
                break
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
}
