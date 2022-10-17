//
//  RegisterViewController.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var first_Name: UITextField!
    @IBOutlet weak var Last_name: UITextField!
    @IBOutlet weak var Code: UITextField!
    @IBOutlet weak var RegisterButton :UIButton!
    @IBOutlet weak var ForgotPasswordButton :UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    var forgotPass = ForgotPasswordViewController.instantiate(fromStoryBoards: .Authentication)
    private let viewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observerViewModel()
    }
    

    @IBAction func loginButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func forgotPassword(_ sender: Any) {
        self.forgotPass.modalPresentationStyle = .overCurrentContext
        self.forgotPass.modalTransitionStyle = .crossDissolve
        self.forgotPass.preferredContentSize = CGSize(width: 300, height: 300)
        let pVC = self.forgotPass.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        pVC?.delegate = self
        pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
        self.forgotPass.view.frame = (self.navigationController?.view.frame)!
        self.navigationController?.view.addSubview(self.forgotPass.view)
        self.forgotPass.didMove(toParent: self)
    }
    
    @IBAction func ResgisterButtonAction(_ sender: UIButton) {
        guard let email = emailTextFiled.text , !email.isEmpty , email.isValidEmail() ,
        let password = passwordTextFiled.text ,!password.isEmpty else{
            return Toast.show(message: "Incorrct Email Or Password", controller: self)
        }
        let params = [
            "email": email,
            "password": password,
            "role": "member"
          ]
        viewModel.requestForRegistration(params: params)
    }
    
}

extension RegisterViewController {
    func observerViewModel () {
        viewModel.updateProfileResponse.observe { respones in
            if respones?.error == false {
            }else {
                DispatchQueue.main.async {
                    Toast.show(message: "\(respones?.message ?? "Something went Wrong")", controller: self)
                }
            }
        }
        viewModel.UserModelResponesLiveData.observe { result in
            if result?.error == false {
                let auth_Token = result?.token
                UserDefault.setValue(value: auth_Token, key: userDefaultIdentifier.Accesstoken)
                guard let firstName = self.first_Name.text , !firstName.isEmpty , let lastName = self.Last_name.text , !lastName.isEmpty else {
                    return Toast.show(message: "Incorrct Email Or Password", controller: self)
                }
                
                let params2 = ["payload" : ["first_name": firstName,
                                            "last_name": lastName]
                ]
                
                UserDefault.setValue(value: auth_Token, key: userDefaultIdentifier.Accesstoken)
                let vc = ViewController.instantiate(fromStoryBoards: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
                self.viewModel.requestForUpdateProfile(params: params2)
            }else {
                DispatchQueue.main.async {
                    Toast.show(message: "\(result?.message ?? "Something went Wrong")", controller: self)
                }
            }
        }
        viewModel.commonErrorLiveData.observe { error in
            DispatchQueue.main.async {
                Toast.show(message: error?.localizedDescription ?? "UNKNOWN ERROR", controller: self)
            }
        }
    }
}
