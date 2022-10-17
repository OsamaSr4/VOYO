//
//  UserDefault.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//

import Foundation


enum userDefaultIdentifier {
    static let Accesstoken = "access_token"
    static let UserModel = "userModel"
    static let firstTimeLoad = "Loaded"
    static let isOpenedFirstTime = "isOpened"
    static let FcmToken = "FcmToken"
    static let guestLogin = "Guest"
}


class UserDefault {

    //MARK: Setters
    
    class func setModel<T: Encodable>(model: T, key: String) {
        let encodedData: Data = try! JSONEncoder().encode(model)
        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func setAccessToken(accesToken: String) {
        UserDefault.setValue(value: "", key: userDefaultIdentifier.Accesstoken)
        UserDefault.setValue(value: accesToken, key: userDefaultIdentifier.Accesstoken)
    }

    class func setValue<T: Hashable>(value: T, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    //MARK: Getters
    class func getModel<T: Decodable>(key: String) -> T? {
        let decoded  = UserDefaults.standard.data(forKey: key)
        if decoded != nil{
            let decodedModel = try! JSONDecoder().decode(T.self, from: decoded!)
            return decodedModel
        }
        else
        {
            return nil
        }
    }
    
    class func getAccessToken(withBearer: Bool = false) -> String {
        if withBearer == true {
            return "Bearer " + self.getStringValue(key: userDefaultIdentifier.Accesstoken)
        }
        return self.getStringValue(key: userDefaultIdentifier.Accesstoken)
    }
    
    class func userLogingCheck() -> Bool {
        let access = getAccessToken(withBearer: false)
        print("Access Token",access)
        if access == "" {
            return false
        }else{
            return true
        }
    }
    
    class func getStringValue(key: String) -> String {
        if let item = UserDefaults.standard.value(forKey: key) as? String {
            return item
        } else {
            return ""
        }
    }
    
    class func getIntValue(key: String) -> Int {
        if let item = UserDefaults.standard.value(forKey: key) as? Int {
            return item
        } else {
            return 1
        }
    }
    
    class func getBoolValue(key: String) -> Bool {
        if let item = UserDefaults.standard.value(forKey: key) as? Bool {
            return item
        } else {
            return false
        }
    }
    
    class func deleteModel(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}
