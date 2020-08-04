//
//  ViewController.swift
//  Log In Test
//
//  Created by Abhi Madduri on 7/25/20.
//

import UIKit
import Firebase
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var otpTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.background = UIImage(named: "Email TextField")
        passwordTextField.background = UIImage(named: "Password TextField")
        
    }
    
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            print("1")
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("2")
                    self.emailTextField.background = UIImage(named: "Email TextField Incorrect")
                    self.passwordTextField.background = UIImage(named: "Password TextField Incorrect")
                } else {
                    print("3")
                    self.performSegue(withIdentifier:"SecondScreen", sender: self)
                }
            }
        }
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email  = emailTextField.text, let password = passwordTextField.text {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.emailTextField.background = UIImage(named: "Email TextField Incorrect")
                self.passwordTextField.background = UIImage(named: "Password TextField Incorrect")
            } else {
                self.performSegue(withIdentifier: "SecondScreen", sender: self)
            }
        }
    
        }
    }
    
    
    @IBAction func sendCodePressed(_ sender: UIButton) {
        guard let phoneNumber = phoneTextField.text else {return}
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
          if error == nil {
            print(verificationID)
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
          } else {
            print("Error sendCode", error?.localizedDescription)
          }
        }
    }
    
    
    
    
    @IBAction func verifyButtonPressed(_ sender: UIButton) {
        guard let otpCode = otpTextField.text else {return}
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {return}
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpCode)
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil {
                print(success)
                print("User Signed In...")
                self.performSegue(withIdentifier: "SecondScreen", sender: self)
            } else {
                print("Error verify")
            }
        }
    }
    

    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        return true
    }

}
 
