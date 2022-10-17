//
//  LoginViewController.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//

import UIKit

class LoginViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var LoginButton :UIButton!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var RegisterButton :UIButton!
    @IBOutlet weak var ForgotPasswordButton :UIButton!
    var forgotPass = ForgotPasswordViewController.instantiate(fromStoryBoards: .Authentication)
    
    private let viewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observerViewModel()
    }
    
    @IBAction func registerNow(_ sender: Any) {
        let vc = RegisterViewController.instantiate(fromStoryBoards: .Authentication)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        guard let email = emailTextFiled.text , !email.isEmpty , email.isValidEmail() ,
        let password = passwordTextFiled.text ,!password.isEmpty else{
            return Toast.show(message: "Incorrct Email Or Password", controller: self)
        }
        let params = [
            "email": email,
            "password": password,
            "role": "member"
          ]
        viewModel.requestForLogin(params: params)
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
}


extension LoginViewController {
    func observerViewModel () {
        viewModel.UserModelResponesLiveData.observe { result in
            if result?.error == false {
                let auth_Token = result?.token
                UserDefault.setValue(value: auth_Token, key: userDefaultIdentifier.Accesstoken)
                
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
