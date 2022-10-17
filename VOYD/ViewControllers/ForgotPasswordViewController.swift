//
//  ForgotPasswordViewController.swift
//  VOYD
//
//  Created by MacBook Pro on 18/10/2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var forgorPasswordPopup: UIView!
    
    @IBOutlet weak var bBackgroundView: UIView!
    @IBOutlet weak var cancelButtonoutlet: UIButton!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    private var viewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closebuttonaction(_ sender: Any) {
        dismissPopUp()
    }
 

    
    @objc func dismissPopUp(){
        emailTextFiled.text = ""
        self.view.removeFromSuperview()
    }
    
  
    @IBAction func nextButton(_ sender: UIButton) {
        guard let email = emailTextFiled.text , !email.isEmpty , email.isValidEmail() else {
            return Toast.show(message: "Incorrect Email ", controller: self)
        }
        let params = [
            "email": email,
          ]
        viewModel.requestForForgotPassword(params: params)
    }
  

}

extension ForgotPasswordViewController {
    func observerViewModel () {
        viewModel.forgotPassResponse.observe { respones in
            if respones?.error == false {
                
            }else {
                
            }
        }
        
        viewModel.commonErrorLiveData.observe { error in
            DispatchQueue.main.async {
                Toast.show(message: error?.localizedDescription ?? "UNKNOWN ERROR", controller: self)
            }
        }
    }
}