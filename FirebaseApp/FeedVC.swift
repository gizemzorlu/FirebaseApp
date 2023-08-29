//
//  FeedVC.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 24.08.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let identifier = "FeedCell"
    
    var collectionView: UICollectionView!
    var userEmailArray = [String]()
    var userCaptionArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getDataFromFirestore()
    }
    
    func setupUI() {
        
        view.backgroundColor = .white
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height / 2.5)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: identifier)
 
        collectionView.backgroundColor = UIColor.red
               self.view.addSubview(collectionView)
     


}
     
   public  func getDataFromFirestore() {
        
        let fireStoreDatabase = Firestore.firestore()
      
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
                
            } else {
                    if snapshot?.isEmpty != true {
                       
                        self.userImageArray.removeAll(keepingCapacity: false)
                        self.userEmailArray.removeAll(keepingCapacity: false)
                        self.userCaptionArray.removeAll(keepingCapacity: false)
                        self.likeArray.removeAll(keepingCapacity: false)
                        self.documentIdArray.removeAll(keepingCapacity: false)
                        
                        
                        for document in snapshot!.documents {
                            
                            
                           
                            
                            if let documentID =  document.documentID as? String {
                                self.documentIdArray.append(documentID)
                                
                            }
                            
                            if let postedBy = document.get("postedBy") as? String {
                                self.userEmailArray.append(postedBy)
                                
                            }
                            
                            if let postCaption = document.get("postCaption") as? String {
                                self.userCaptionArray.append(postCaption)
                            }
                            
                            if let likes = document.get("likes") as? Int {
                                self.likeArray.append(likes)
                            }
                            
                            if let imageUrl = document.get("imageUrl") as? String {
                                self.userImageArray.append(imageUrl)
                            }
                        
                    }
                        self.collectionView.reloadData()
                }
                    
                    }
            }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
    
    cell.userEmailLabel.text = userEmailArray[indexPath.row]
    cell.likeLabel.text = String(likeArray[indexPath.row])
    cell.captionLabel.text = userCaptionArray[indexPath.row]
    cell.imageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
    cell.documentIdLabel.text = documentIdArray[indexPath.row]
        
        return cell
    
}
    


    
}
    
    


