//
//  SettingsVC.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 24.08.2023.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {
    
    var logoutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        view.addSubview(logoutButton)

        logoutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
         
        }
    }
    
    @objc func logoutButtonClicked() {

        do {
            try Auth.auth().signOut()
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } catch {
            print("error")
        }

    }
    

}
