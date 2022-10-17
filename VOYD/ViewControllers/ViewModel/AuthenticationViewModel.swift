//
//  LoginViewModel.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//

import Foundation



class AuthenticationViewModel {

    init(){
        self.UserModelResponesLiveData = LiveData()
        self.commonErrorLiveData = LiveData()
    }

    
    var commonErrorLiveData : LiveData<Error> = LiveData()
    var UserModelResponesLiveData : LiveData<UserModel> = LiveData()
    var updateProfileResponse : LiveData<UserModel> = LiveData()
    var forgotPassResponse : LiveData<ForgotPasswordModel> = LiveData()

    func requestForLogin(params : Params) -> Void {
        Repo_Authentication.sharedInstance.loginUserr(params: params) {  finalResult in
            switch finalResult {
            case .success(let loginRespose):
                print(loginRespose)
                self.UserModelResponesLiveData.setValue(loginRespose)
            case .failure(let loginError):
                print(loginError)
                self.commonErrorLiveData.setValue(loginError)
            }
        }
    }

    
    func requestForRegistration(params :Params ) -> Void {
        Repo_Authentication.sharedInstance.userRegister(params: params) {  finalResult in
            switch finalResult {
            case .success(let registerRespones):
                print(registerRespones)
                self.UserModelResponesLiveData.setValue(registerRespones)
            case .failure(let registerError):
                print(registerError)
                self.commonErrorLiveData.setValue(registerError)
            }
        }
        
    }
 
    
    func requestForUpdateProfile(params :Params ) -> Void {
        Repo_Authentication.sharedInstance.updateProfile(params: params) {  finalResult in
            switch finalResult {
            case .success(let profile):
                print(profile)
                self.updateProfileResponse.setValue(profile)
            case .failure(let profileError):
                print(profileError)
                self.commonErrorLiveData.setValue(profileError)
            }
        }
        
    }
    
    func requestForForgotPassword(params :Params ) -> Void {
        Repo_Authentication.sharedInstance.forgotPassword(params: params) {  finalResult in
            switch finalResult {
            case .success(let profile):
                print(profile)
                self.forgotPassResponse.setValue(profile)
            case .failure(let profileError):
                print(profileError)
                self.commonErrorLiveData.setValue(profileError)
            }
        }
        
    }
    
    func requestForResetPassword(params :Params ) -> Void {
        Repo_Authentication.sharedInstance.ResetPassworrd(params: params) {  finalResult in
            switch finalResult {
            case .success(let profile):
                print(profile)
                self.UserModelResponesLiveData.setValue(profile)
            case .failure(let profileError):
                print(profileError)
                self.commonErrorLiveData.setValue(profileError)
            }
        }
        
    }

}


