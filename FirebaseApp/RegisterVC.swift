//
//  RegisterVC.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 23.08.2023.
//

import UIKit
import Firebase

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    var label = UILabel()
    var emailText = UITextField()
    var urlButton =  UIButton()
    var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        label.text = "This will send a verification email. Check your inbox for the verification link to confirm your email and complete the registration process."
        label.textColor = .black
        label.textAlignment = .natural
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 4
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(170)
            make.width.equalTo(330)
            make.height.equalTo(90)
        }
        

        
        urlButton.setTitle("Verify Email", for: .normal)
        urlButton.setTitleColor(.white, for: .normal)
        urlButton.backgroundColor = .systemBlue
        urlButton.addTarget(self, action: #selector(urlButtonClicked), for: .touchUpInside)
        view.addSubview(urlButton)
        
        urlButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(110)
            
        }
    }
    
    private var authUser : User? {
        return Auth.auth().currentUser
        self.dismiss(animated: true)
    }
    
    @objc func urlButtonClicked() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                print("email has been sent.")
               
            })
        }
        else {
            print("cant send the email.")
        }
    }

}

