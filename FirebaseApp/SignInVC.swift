//
//  SignInVC.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 23.08.2023.
//

import UIKit
import Firebase

class SignInVC: UIViewController, UITextFieldDelegate {
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var signInButton = UIButton()
    var newButton = UIButton()
    var forgotButton = UIButton()
    
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
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = .systemBlue
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        view.addSubview(signInButton)
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        newButton.setTitle("Sign up with new account", for: .normal)
        newButton.setTitleColor(.systemBlue, for: .normal)
        newButton.backgroundColor = .white
        newButton.addTarget(self, action: #selector(newButtonClicked), for: .touchUpInside)
        view.addSubview(newButton)
        
        newButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            
        }
        
        forgotButton.setTitle("Forgot Password", for: .normal)
        forgotButton.setTitleColor(.systemBlue, for: .normal)
        forgotButton.backgroundColor = .white
        forgotButton.addTarget(self, action: #selector(forgotButtonClicked), for: .touchUpInside)
        view.addSubview(forgotButton)
        
        forgotButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newButton.snp.bottom).offset(20)
            
        }
    }
   
    @objc func signInButtonClicked() {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
            if error != nil {
                
                self.makeAlert(titleInput: "Error!", messageInput: error!.localizedDescription ?? "Error")
            } else {
                
                let loginVC = TabBarController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true)
            }
        }
        
    
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
        }
    
    }
    
    
    @objc func newButtonClicked() {
        
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    @objc func forgotButtonClicked() {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text ?? "") { error in
                guard error == nil else{
                    self.makeAlert(titleInput: "Error!", messageInput: "Email?")
                    return
                }
            }
        }
        
    
    func makeAlert(titleInput:String, messageInput:String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
}
