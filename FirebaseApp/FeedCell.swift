//
//  FeedCell.swift
//  FirebaseApp
//
//  Created by Gizem Zorlu on 24.08.2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore

class FeedCell: UICollectionViewCell {

    let identifier = "FeedCell"

    var imageView = UIImageView()
    var userEmailLabel = UILabel()
    var captionLabel = UILabel()
    var likeLabel = UILabel()
    var documentIdLabel = UILabel()
    var likeButton = UIButton()
    var commentButton = UIButton()


    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(userEmailLabel)
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(-8)
        }
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userEmailLabel.snp.bottom).offset(4)
            make.height.equalTo(230)
            make.width.equalTo(230)

        }
        contentView.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.right.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(-8)
        }
        contentView.addSubview(likeLabel)
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(40)
            make.width.equalTo(40)
        }
        contentView.addSubview(documentIdLabel)
        documentIdLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.bottom)
            make.left.equalToSuperview().inset(25)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        contentView.addSubview(likeButton)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(6)
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(40)
            make.width.equalTo(40)

        }

        contentView.addSubview(commentButton)
        commentButton.setImage(UIImage(systemName: "bubble.left.and.bubble.right"), for: .normal)
        commentButton.addTarget(self, action: #selector(goToComments), for: .touchUpInside)
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(likeLabel.snp.bottom).offset(6)
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(40)
            make.width.equalTo(40)

        }


        // documentIdLabel'ı gizle
        documentIdLabel.isHidden = true
    }

    @objc func likeButtonClicked() {

        let fireStoreDatabase = Firestore.firestore()

        if let likeCount = Int(likeLabel.text!) {

            let likeStore = ["likes" : likeCount + 1] as [String  : Any]

            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)

        }
    }

        @objc func goToComments() {

           let feedVC = FeedVC()

          feedVC.navigationController?.pushViewController(CommentVC(), animated: true)




    }
    }




