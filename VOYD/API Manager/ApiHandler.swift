//
//  ApiHandler.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//



import Foundation
import Alamofire
import SwiftyJSON


public typealias Params = [String: Any]?
typealias Handler = (Result<JSON,Error>) -> Void

class ApiManager {
    
    private static let baseURL = ServerURLs.baseURL
    
    class func request(_ url: String, httpMethod: HTTPMethod = .get, params: Params = nil, headers: [String: String]? = nil, urlEncoding: ParameterEncoding = URLEncoding.default, completionHandler: @escaping Handler) {
        
        let completeURL = ApiManager.baseURL + url
        var encoding = urlEncoding
        if httpMethod == .post {
            encoding = JSONEncoding.default
        }
        
        var apiHeaders: [String: String]? = headers
        apiHeaders!["Authorization"] =  UserDefault.getAccessToken(withBearer: true)
        apiHeaders!["x-project"] =  Constants.projectID
        apiHeaders!["Content-Type"] = "application/json"
        
        
        AF.request(completeURL, method: httpMethod, parameters: params, encoding: encoding, headers: HTTPHeaders.init(apiHeaders!)) .response { (responseObject) -> Void in
            
            debugPrint(responseObject)
            switch responseObject.result {
                
            case .success(let json) :
                print("Json Response",json)
                let jsonRespone = JSON(json!)
                completionHandler(.success(jsonRespone))
                return
            case .failure(let err) :
                if let error = err.underlyingError {
                    completionHandler(.failure(error))
                }
                return
            }
        }
    }
    
  
    
}
