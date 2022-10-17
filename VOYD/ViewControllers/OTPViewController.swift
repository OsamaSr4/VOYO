//
//  OTPViewController.swift
//  VOYD
//
//  Created by MacBook Pro on 18/10/2022.
//

import Foundation
import UIKit

class OTPViewController:UIViewController,  UITextFieldDelegate {

    @IBOutlet var codeTextArray: [UITextField]!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var resendCodeOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
//        resendCodeOutlet.isEnabled = false
//        resendCodeOutlet.setTitleColor(UIColor.lightGray, for: .normal)
        verifyButton.layer.cornerRadius = 5
     

        for i in 0...5
        {
            codeTextArray[i].delegate = self
            codeTextArray[i].layer.shadowOpacity = 0.2
            codeTextArray[i].layer.shadowRadius = 2.0
            codeTextArray[i].layer.shadowColor = UIColor.gray.cgColor
            codeTextArray[i].layer.borderWidth = 0.1
            codeTextArray[i].layer.borderColor = UIColor.lightGray.cgColor
            codeTextArray[i].addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        }
        self.hideKeyboardWhenTappedAround()
    }


    @objc func textFieldDidChange(textField: UITextField){

        let text = textField.text

        //backward erasing code
        if text == ""{
            switch textField{
            case codeTextArray[5]:
                codeTextArray[4].becomeFirstResponder()
            case codeTextArray[4]:
                codeTextArray[3].becomeFirstResponder()
            case codeTextArray[3]:
                codeTextArray[2].becomeFirstResponder()
                case codeTextArray[2]:
                codeTextArray[1].becomeFirstResponder()
                case codeTextArray[1]:
                codeTextArray[0].becomeFirstResponder()
            case codeTextArray[0]:
                break
            default:
                break
            }
        }

        //forward typing code
        if (text?.utf16.count)!  >= 1{
            switch textField{
            case codeTextArray[0]:
                codeTextArray[1].becomeFirstResponder()
            case codeTextArray[1]:
                codeTextArray[2].becomeFirstResponder()
            case codeTextArray[2]:
                codeTextArray[3].becomeFirstResponder()
                case codeTextArray[3]:
                codeTextArray[4].becomeFirstResponder()
                case codeTextArray[4]:
                codeTextArray[5].becomeFirstResponder()
            case codeTextArray[5]:
                view.endEditing(true)
                var verificationCode = ""
                for item in codeTextArray {
                    verificationCode += item.text ?? "0"
                }
//                verifyCode(code: verificationCode)
                break
            default:
                break
            }
        }
        else{
                // do nothing
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
       // textFieldDidChange(textField: codeTextArray[IndexPath.row])
        return newString.length <= maxLength
    }


    

    //MARK: - IBActions

    @IBAction func veriftButtonPressed(_ sender: UIButton){
        var verificationCode = ""
        for item in codeTextArray {
            verificationCode += item.text ?? "0"
        }
    }

    @IBAction func resendCodeAction(_ sender: UIButton) {
    }
  
}
