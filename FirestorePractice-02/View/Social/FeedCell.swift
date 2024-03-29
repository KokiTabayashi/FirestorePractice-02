//
//  FeedCell.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/14/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase
//import ActiveLabel

class FeedCell: UICollectionViewCell {
    
    var delegate: FeedCellDelegate?
    
    var ranking: Ranking? {
//    var rankingTap: (Ranking?, [RankItem?]) {

        didSet {
    
//            guard let ownerUid = ranking?.ownerUid else { return }
//            guard let imageUrl = ranking?.imageUrl else { return }
//            guard let likes = ranking?.likes else { return }
            
//            let rankingTapInside = rankingTap
//
//            let ranking = rankingTapInside.0
//            let rankingItem = rankingTapInside.1
            
            guard let rankingTitle = ranking?.rankingTitle else { return }
            guard let rankingCreatedDate = ranking?.rankingCreatedDate else { return }
            
//            guard let rankingItemTitleOne = rankingItem[0]?.rankingItemTitle else { return }
//            guard let rankingItemTextOne = rankingItem[0]?.rankingItemText else { return }
//            guard let rankingItemImageUrlOne = rankingItem[0]?.rankingItemImageUrl else { return }
//
            rankingTitleLabel.text = rankingTitle
            rankingCreatedDateLabel.text = rankingCreatedDate.timeAgoToDisplay()
//
//            Database.fetchUser(with: ownerUid) { (user) in
//
//                // test
//                guard let profileImageUrl = user.profileImageUrl else { return }
//
//                self.profileImageView.loadImage(with: profileImageUrl)
//                self.usernameButton.setTitle(user.username, for: .normal)
//                self.configurePostCaption(user: user)
//            }
//            postImageView.loadImage(with: imageUrl)
            
//            likesLabel.text = "\(likes) likes"
//            configureLikeButton()
//        }
//    }
//
//    var rankingItem: [RankItem?] {
//        didSet {

            
//            rankingItemTitleOneLabel.text = rankingItemTitleOne
//            rankingItemTextOneLabel.text = rankingItemTextOne
//            rankingItemImageUrlOneLabel.text = rankingItemImageUrlOne
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
//    lazy var usernameButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Username", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
//        button.addTarget(self, action: #selector(handleUsernameTapped), for: .touchUpInside)
//        return button
//    }()
    
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
//
//    let messageButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
//        button.tintColor = .black
//        return button
//    }()
//
//    let savePostButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
//        button.tintColor = .black
//        return button
//    }()
    
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
    
    let rankingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        return label
    }()

    let rankingCreatedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "2 DAYS AGO"
        return label
    }()
    
    let rankingItemTitleOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        return label
    }()
    
    let rankingItemTextOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        return label
    }()
    
    let rankingItemImageUrlOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8 , paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2

//        addSubview(usernameButton)
//        usernameButton.anchor(top: nil, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        usernameButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
//
//        addSubview(optionsButton)
//        optionsButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
//        optionsButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
//
//        addSubview(postImageView)
//        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
//        configureActionButtons()
//
//        addSubview(likesLabel)
//        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: -4, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
//        addSubview(captionLabel)
//        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        addSubview(rankingTitleLabel)
        rankingTitleLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)

        addSubview(rankingCreatedDateLabel)
        rankingCreatedDateLabel.anchor(top: rankingTitleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    }
    
    // MARK: - Handlers

    @objc func handleUsernameTapped() {
//        delegate?.handleUsernameTapped(for: self)
    }

    @objc func handleOptionsTapped() {
//        delegate?.handleOptionsTapped(for: self)
    }

    @objc func handleLikeTapped() {
//        delegate?.handleLikeTapped(for: self, isDoubleTap: false)
    }

    @objc func handleCommentTapped() {
//        delegate?.handleCommentTapped(for: self)
    }

    @objc func handleShowLikes() {
//        delegate?.handleShowLikes(for: self)
    }

    @objc func handleDoubleTapToLike() {
//        delegate?.handleLikeTapped(for: self, isDoubleTap: true)
    }
    
//    func configureLikeButton() {
//        delegate?.handleConfigureLikeButton(for: self)
//    }
    
//    func configurePostCaption(user: User) {
//
//        guard let ranking = self.ranking else { return }
//        guard let caption = ranking.caption else { return }
//        guard let username = ranking.user?.username else { return }
    
        // look for username as pattern
//        let customType = ActiveType.custom(pattern: "^\(username)\\b")
        
        // enable username as custom type
//        captionLabel.enabledTypes = [.mention, .hashtag, .url, customType]
        
        // configure username link attributes
//        captionLabel.configureLinkAttribute = { (type, attributes, isSelected) in
//            var atts = attributes
//
//            switch type {
//            case .custom:
//                atts[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 12)
//            default: ()
//            }
//            return atts
//        }
        
//        captionLabel.customize { (label) in
//            label.text = "\(username) \(caption)"
//            label.customColor[customType] = .black
//            label.font = UIFont.systemFont(ofSize: 12)
//            label.textColor = .black
//            captionLabel.numberOfLines = 2
//        }
        
//        postTimeLabel.text = ranking.creationDate.timeAgoToDisplay()
//    }
    
//    func configureActionButtons() {
//
//        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, messageButton])
//
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//
//        addSubview(stackView)
//        stackView.anchor(top: postImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
//
//        addSubview(savePostButton)
//        savePostButton.anchor(top: postImageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 20, height: 24)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

