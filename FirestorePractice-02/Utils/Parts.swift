//
//  Parts.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/23/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit

class Parts {
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Username", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
//        button.addTarget(self, action: #selector(handleUsernameTapped), for: .touchUpInside)
        return button
    }()
    
    let rankingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        return label
    }()
    
    let rankingTitleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ranking Title"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
//        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    } ()
    
    let captionTextViewOne: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.font = UIFont.systemFont(ofSize: 12)
        return tv
    }()
    
//    lazy var optionsButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("•••", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.addTarget(self, action: #selector(handleOptionsTapped), for: .touchUpInside)
//        return button
//    }()
    
//    lazy var postImageView: CustomImageView = {
//        let iv = CustomImageView()
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        iv.backgroundColor = .lightGray
//
//        // add gesture recognizer for double tap to like
//        let likeTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapToLike))
//        likeTap.numberOfTapsRequired = 2
//        iv.isUserInteractionEnabled = true
//        iv.addGestureRecognizer(likeTap)
//
//        return iv
//    }()
    
//    lazy var likeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
//        button.tintColor = .black
//        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var commentButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
//        button.tintColor = .black
//        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
//        return button
//    }()
    
    let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let savePostButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
//    lazy var likesLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.text = "3 lieks"
//
//        // add gesture recognizer to label
//        let likeTap = UITapGestureRecognizer(target: self, action: #selector(handleShowLikes))
//        likeTap.numberOfTapsRequired = 1
//        label.isUserInteractionEnabled = true
//        label.addGestureRecognizer(likeTap)
//
//        return label
//    }()
    
//    let captionLabel: ActiveLabel = {
//        let label = ActiveLabel()
//        label.numberOfLines = 0
//        return label
//    }()
}
