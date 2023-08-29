//
//  ViewController.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 23.08.2023.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var password2TextField = UITextField()
    var signUpButton = UIButton()
    var label = UILabel()
    var signInButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
    }

    func setupUI() {
        
        view.backgroundColor = .white
        
    
        emailTextField.placeholder = "email"
        emailTextField.textColor = .black
        emailTextField.font = UIFont.systemFont(ofSize: 19)
        emailTextField.borderStyle = .line
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.borderStyle = UITextField.BorderStyle.bezel
        emailTextField.delegate = self
        view.addSubview(emailTextField)
                
                emailTextField.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalToSuperview().offset(250)
                    make.width.equalTo(350)
                    make.height.equalTo(50)
                }
        
        passwordTextField.placeholder = "password"
        passwordTextField.textColor = .black
        passwordTextField.tintColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 19)
        passwordTextField.borderStyle = .line
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.borderStyle = UITextField.BorderStyle.bezel
        view.addSubview(passwordTextField)
        
       passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
           make.top.equalTo(emailTextField.snp.bottom).offset(17)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        password2TextField.placeholder = "password again"
        password2TextField.textColor = .black
        password2TextField.tintColor = .black
        password2TextField.font = UIFont.systemFont(ofSize: 19)
        password2TextField.borderStyle = .line
        password2TextField.autocapitalizationType = .none
        password2TextField.returnKeyType = UIReturnKeyType.done
        password2TextField.borderStyle = UITextField.BorderStyle.bezel
        view.addSubview(password2TextField)
        
       password2TextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
           make.top.equalTo(passwordTextField.snp.bottom).offset(17)
            make.width.equalTo(350)
            make.height.equalTo(50)
        }
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(password2TextField.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        label.text = "Have you registered before?"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(50)
            make.left.equalTo(view.snp.left).offset(28)
        }
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = .systemBlue
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        view.addSubview(signInButton)
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(40)
            make.right.equalTo(view.snp.right).inset(28)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        
        let gestureRecognizerKey = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizerKey)
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)

    }
    
    @objc func signUpButtonClicked() {
        
        if emailTextField.text != "" && passwordTextField.text != "" && password2TextField.text != "" && passwordTextField.text == password2TextField.text {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                
                if error != nil {
                    
                    self.makeAlert(titleInput: "Error!", messageInput: error!.localizedDescription)
                    
                } else {
                    
                   let registerVC = RegisterVC()
                    registerVC.modalPresentationStyle = .fullScreen
                    self.present(registerVC, animated: true)
                }
            }
            
        } else {
            
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
            
        }
    }
    
    
    @objc func signInButtonClicked() {
        
        let signInVc = SignInVC()
        signInVc.modalPresentationStyle = .fullScreen
        present(signInVc, animated: true)
    }
    
    

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            if let text = textField.text, !text.isEmpty {
                if isValidEmail(email: text) {
                    // Doğru e-posta formatı, hata mesajı göstermeye gerek yok
                } else {
                    // Hatalı e-posta formatı, hata mesajı göster
                    makeAlert(titleInput: "Error!", messageInput: "Invalid email format!")
                }
            }
        }
    }
     func isValidEmail(email: String) -> Bool {
         let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
         let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
         return emailPredicate.evaluate(with: email)
     }
    

func makeAlert(titleInput:String, messageInput:String) {
    
    let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
    alert.addAction(okButton)
    self.present(alert, animated: true)
    
}
}

