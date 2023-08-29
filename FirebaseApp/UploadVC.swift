//
//  UploadVC.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 24.08.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView = UIImageView()
    var captionText = UITextField()
    var uploadButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        
        imageView.image = UIImage(named: "select")
        view.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(160)
            make.height.equalTo(230)
            make.width.equalTo(230)
        }
        
        captionText.placeholder = "caption"
        captionText.textColor = .black
        captionText.font = UIFont.systemFont(ofSize: 20)
        captionText.borderStyle = .line
        captionText.autocapitalizationType = .none
        captionText.textAlignment = .center
        captionText.returnKeyType = UIReturnKeyType.done
        captionText.borderStyle = UITextField.BorderStyle.none
        view.addSubview(captionText)
        
        captionText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(35)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.backgroundColor = .systemBlue
        uploadButton.addTarget(self, action: #selector(uploadButtonClicked), for: .touchUpInside)
        view.addSubview(uploadButton)
        
        uploadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(captionText.snp.bottom).offset(40)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    @objc func uploadButtonClicked() {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if let error = error {
                    self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription)
                } else {
                    imageReference.downloadURL { url, error in
                        if let error = error {
                            self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription)
                        } else if let imageUrl = url?.absoluteString {
                            print(imageUrl)
                            
                            let firestoreDataBase = Firestore.firestore()
                            
                            let firestorePost: [String: Any] = [
                                "imageUrl": imageUrl,
                                "postedBy": Auth.auth().currentUser?.email ?? "",
                                "postCaption": self.captionText.text ?? "",
                                "date": FieldValue.serverTimestamp(),
                                "likes": 0
                            ]
                            
                            firestoreDataBase.collection("Posts").addDocument(data: firestorePost) { error in
                                if let error = error {
                                    self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription)
                                } else {
                                    // Başarılı bir şekilde veri eklenmiş
                                    self.imageView.image = UIImage(named: "select")
                                    self.captionText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


