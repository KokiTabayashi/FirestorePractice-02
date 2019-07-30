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
    var width: CGFloat = 100.0
    var height: CGFloat = 100.0
    var pattern: Int = 0
    
    var ranking: Ranking? {
//    var rankingTap: (Ranking?, [RankingItem?]) {

        didSet {
    
            guard let ownerUid = ranking?.rankingOwnerId else { return }
//            pattern = (ranking?.rankingItems.count)!
            
//            var username: String!
//            var fullName: String!
//            var photoImageUrl: String!
            
            Firestore.fetchUser(with: ownerUid) { (user) in
//                guard let username = user.username else { return }
                let username = user.username as? String ?? ""
//                let fullName = user.fullName as? String ?? ""
                let photoImageUrl = user.photoImageUrl as? String ?? ""
                
                self.profileImageView.loadImage(with: photoImageUrl)
                self.usernameButton.setTitle(username, for: .normal)
            }
            
            
//            guard let imageUrl = ranking?.imageUrl else { return }
//            guard let likes = ranking?.likes else { return }
            
//            let rankingTapInside = rankingTap

//            let ranking = rankingTapInside.0
//            let rankingItem = rankingTapInside.1
            
//            let ranking = rankingTap.0
//            let rankingItem = rankingTap.1
            
            guard let rankingTitle = ranking?.rankingTitle else { return }
            guard let rankingCreatedDate = ranking?.rankingCreatedDate else { return }
            
            guard let rankingItems = ranking?.rankingItems else { return }
            
            print("ranking items count: \(rankingItems.count)")
            
            rankingTitleLabel.text = rankingTitle
            rankingCreatedDateLabel.text = rankingCreatedDate.timeAgoToDisplay()
            
            //
            // Need to implement some process to prevent crash if the data is null (like enter "no data" or something)
            //
            
//            var rankingItemTitleOne: String!
//            var rankingItemTextOne: String!
//            var rankingItemImageUrlOne: String!
//
//            var rankingItemTitleTwo: String!
//            var rankingItemTextTwo: String!
//            var rankingItemImageUrlTwo: String!
//
//            var rankingItemTitleThree: String!
//            var rankingItemTextThree: String!
//            var rankingItemImageUrlThree: String!
//
//            switch rankingItems.count {
//            case 0:
//                return
//            case 1:
//                rankingItemTitleOne = rankingItems[0].rankingItemTitle ?? " "
//                rankingItemTextOne = rankingItems[0].rankingItemText ?? " "
//                rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl ?? " "
//                return
//            case 2:
//                rankingItemTitleOne = rankingItems[0].rankingItemTitle ?? " "
//                rankingItemTextOne = rankingItems[0].rankingItemText ?? " "
//                rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl ?? " "
//
//                rankingItemTitleTwo = rankingItems[1].rankingItemTitle ?? " "
//                rankingItemTextTwo = rankingItems[1].rankingItemText ?? " "
//                rankingItemImageUrlTwo = rankingItems[1].rankingItemImageUrl ?? " "
//                return
//            case 3:
//                rankingItemTitleOne = rankingItems[0].rankingItemTitle ?? " "
//                rankingItemTextOne = rankingItems[0].rankingItemText ?? " "
//                rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl ?? " "
//
//                rankingItemTitleTwo = rankingItems[1].rankingItemTitle ?? " "
//                rankingItemTextTwo = rankingItems[1].rankingItemText ?? " "
//                rankingItemImageUrlTwo = rankingItems[1].rankingItemImageUrl ?? " "
//
//                rankingItemTitleThree = rankingItems[2].rankingItemTitle ?? " "
//                rankingItemTextThree = rankingItems[2].rankingItemText ?? " "
//                rankingItemImageUrlThree = rankingItems[2].rankingItemImageUrl ?? " "
//                return
//            default:
//                return
//            }

            if rankingItems.count == 1 {
                guard let rankingItemTitleOne = rankingItems[0].rankingItemTitle else { return }
                guard let rankingItemTextOne = rankingItems[0].rankingItemText else { return }
                guard let rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl else { return }
                
                rankingItemTitleOneLabel.text = rankingItemTitleOne
                rankingItemTextOneLabel.text = rankingItemTextOne
                rankingItemOneImageView.loadImage(with: rankingItemImageUrlOne)
                
                let rankingItemTitleTwo = " "
                let rankingItemTextTwo = " "
                let rankingItemImageUrlTwo = " "
                
                rankingItemTitleTwoLabel.text = rankingItemTitleTwo
                rankingItemTextTwoLabel.text = rankingItemTextTwo
                rankingItemTwoImageView.loadImage(with: rankingItemImageUrlTwo)
                
                let rankingItemTitleThree = " "
                let rankingItemTextThree = " "
                let rankingItemImageUrlThree = " "
                
                rankingItemTitleThreeLabel.text = rankingItemTitleThree
                rankingItemTextThreeLabel.text = rankingItemTextThree
                rankingItemThreeImageView.loadImage(with: rankingItemImageUrlThree)
                
//                pattern = 1
//                print("*** DEBUG ***: Pattern \(pattern)")
            } else if rankingItems.count == 2 {
                guard let rankingItemTitleOne = rankingItems[0].rankingItemTitle else { return }
                guard let rankingItemTextOne = rankingItems[0].rankingItemText else { return }
                guard let rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl else { return }
                
                rankingItemTitleOneLabel.text = rankingItemTitleOne
                rankingItemTextOneLabel.text = rankingItemTextOne
                rankingItemOneImageView.loadImage(with: rankingItemImageUrlOne)
                
                guard let rankingItemTitleTwo = rankingItems[1].rankingItemTitle else { return }
                guard let rankingItemTextTwo = rankingItems[1].rankingItemText else { return }
                guard let rankingItemImageUrlTwo = rankingItems[1].rankingItemImageUrl else { return }
                
                rankingItemTitleTwoLabel.text = rankingItemTitleTwo
                rankingItemTextTwoLabel.text = rankingItemTextTwo
                rankingItemTwoImageView.loadImage(with: rankingItemImageUrlTwo)
                
                let rankingItemTitleThree = " "
                let rankingItemTextThree = " "
                let rankingItemImageUrlThree = " "
                
                rankingItemTitleThreeLabel.text = rankingItemTitleThree
                rankingItemTextThreeLabel.text = rankingItemTextThree
                rankingItemThreeImageView.loadImage(with: rankingItemImageUrlThree)
                
//                pattern = 2
//                print("*** DEBUG ***: Pattern \(pattern)")
            } else if rankingItems.count >= 3 {
                guard let rankingItemTitleOne = rankingItems[0].rankingItemTitle else { return }
                guard let rankingItemTextOne = rankingItems[0].rankingItemText else { return }
                guard let rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl else { return }
                
                rankingItemTitleOneLabel.text = rankingItemTitleOne
                rankingItemTextOneLabel.text = rankingItemTextOne
                rankingItemOneImageView.loadImage(with: rankingItemImageUrlOne)
                
                guard let rankingItemTitleTwo = rankingItems[1].rankingItemTitle else { return }
                guard let rankingItemTextTwo = rankingItems[1].rankingItemText else { return }
                guard let rankingItemImageUrlTwo = rankingItems[1].rankingItemImageUrl else { return }
                
                rankingItemTitleTwoLabel.text = rankingItemTitleTwo
                rankingItemTextTwoLabel.text = rankingItemTextTwo
                rankingItemTwoImageView.loadImage(with: rankingItemImageUrlTwo)
                
                guard let rankingItemTitleThree = rankingItems[2].rankingItemTitle else { return }
                guard let rankingItemTextThree = rankingItems[2].rankingItemText else { return }
                guard let rankingItemImageUrlThree = rankingItems[2].rankingItemImageUrl else { return }
                
                rankingItemTitleThreeLabel.text = rankingItemTitleThree
                rankingItemTextThreeLabel.text = rankingItemTextThree
                rankingItemThreeImageView.loadImage(with: rankingItemImageUrlThree)
                
//                pattern = 3
//                print("*** DEBUG ***: Pattern \(pattern)")
            }
            
//            guard let rankingItemTitleOne = rankingItems[0].rankingItemTitle else { return }
//            guard let rankingItemTextOne = rankingItems[0].rankingItemText else { return }
//            guard let rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl else { return }
//
//            guard let rankingItemTitleTwo = rankingItems[1].rankingItemTitle else { return }
//            guard let rankingItemTextTwo = rankingItems[1].rankingItemText else { return }
//            guard let rankingItemImageUrlTwo = rankingItems[1].rankingItemImageUrl else { return }
//
//            guard let rankingItemTitleThree = rankingItems[2].rankingItemTitle else { return }
//            guard let rankingItemTextThree = rankingItems[2].rankingItemText else { return }
//            guard let rankingItemImageUrlThree = rankingItems[2].rankingItemImageUrl else { return }
//
//            rankingItemTitleOneLabel.text = rankingItemTitleOne
//            rankingItemTextOneLabel.text = rankingItemTextOne
//            rankingItemOneImageView.loadImage(with: rankingItemImageUrlOne)
//
//            rankingItemTitleTwoLabel.text = rankingItemTitleTwo
//            rankingItemTextTwoLabel.text = rankingItemTextTwo
//            rankingItemTwoImageView.loadImage(with: rankingItemImageUrlTwo)
//
//            rankingItemTitleThreeLabel.text = rankingItemTitleThree
//            rankingItemTextThreeLabel.text = rankingItemTextThree
//            rankingItemThreeImageView.loadImage(with: rankingItemImageUrlThree)
            
            
            
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

        }
    }
    
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleUsernameTapped), for: .touchUpInside)
        return button
    }()
    
    let rankingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemOneImageView: CustomImageView = {
        let iv = CustomImageView()
//        iv.contentMode = .scaleAspectFill
        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        return iv
    }()
    
    let rankingItemTitleTwoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextTwoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTwoImageView: CustomImageView = {
        let iv = CustomImageView()
//        iv.contentMode = .scaleAspectFill
        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        return iv
    }()
    
    let rankingItemTitleThreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextThreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemThreeImageView: CustomImageView = {
        let iv = CustomImageView()
//        iv.contentMode = .scaleAspectFill
        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        return iv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var stackViewRankingItemOne = UIStackView(arrangedSubviews: [rankingItemOneImageView, rankingItemTextOneLabel])
    lazy var stackViewRankingItemTwo = UIStackView(arrangedSubviews: [rankingItemTwoImageView, rankingItemTextTwoLabel])
    lazy var stackViewRankingItemThree = UIStackView(arrangedSubviews: [rankingItemThreeImageView, rankingItemTextThreeLabel])


    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        if ranking?.rankingItems.count == 0 {
//            print("*** DEBUG ***: No Items")
//        } else if ranking?.rankingItems.count == 1 {
//            configureViewOne()
//        } else if ranking?.rankingItems.count == 2 {
//            configureViewTwo()
//        } else if (ranking?.rankingItems.count)! >= 3 {
//            print("*** DEBUG ***: Configure View Three")
//            configureView()
//        }
        
        configureView()
    }
    
    // MARK: - Handlers
    
//    func configureViewOne() {
//        print("*** DEBUG ***: Configure View One")
//    }
//    
//    func configureViewTwo() {
//        print("*** DEBUG ***: Configure View Two")
//    }
    
    func configureView() {
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(usernameButton)
        usernameButton.anchor(top: nil, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        usernameButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        usernameButton.contentHorizontalAlignment = .left
        
        addSubview(rankingTitleLabel)
        rankingTitleLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        addSubview(rankingCreatedDateLabel)
        rankingCreatedDateLabel.anchor(top: rankingTitleLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
//        if pattern == 1 {
//            addSubview(rankingItemTitleOneLabel)
//            rankingItemTitleOneLabel.anchor(top: rankingCreatedDateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
//
//            stackViewRankingItemOne.axis = .horizontal
//            stackViewRankingItemOne.distribution = .fill
//            stackViewRankingItemOne.spacing = 6.0
//
//            addSubview(stackViewRankingItemOne)
//            stackViewRankingItemOne.anchor(top: rankingItemTitleOneLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
//        } else if pattern == 2 {
//            addSubview(rankingItemTitleOneLabel)
//            rankingItemTitleOneLabel.anchor(top: rankingCreatedDateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
//
//            stackViewRankingItemOne.axis = .horizontal
//            stackViewRankingItemOne.distribution = .fill
//            stackViewRankingItemOne.spacing = 6.0
//
//            addSubview(stackViewRankingItemOne)
//            stackViewRankingItemOne.anchor(top: rankingItemTitleOneLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
//
//            addSubview(rankingItemTitleTwoLabel)
//            rankingItemTitleTwoLabel.anchor(top: stackViewRankingItemOne.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
//
//            stackViewRankingItemTwo.axis = .horizontal
//            stackViewRankingItemTwo.distribution = .fill
//            stackViewRankingItemTwo.spacing = 6.0
//
//            addSubview(stackViewRankingItemTwo)
//            stackViewRankingItemTwo.anchor(top: rankingItemTitleTwoLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
//    } else if pattern == 3 {
            addSubview(rankingItemTitleOneLabel)
            rankingItemTitleOneLabel.anchor(top: rankingCreatedDateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
            stackViewRankingItemOne.axis = .horizontal
//            stackViewRankingItemOne.alignment = .top
            stackViewRankingItemOne.distribution = .fill
            stackViewRankingItemOne.spacing = 6.0
            
            addSubview(stackViewRankingItemOne)
            stackViewRankingItemOne.anchor(top: rankingItemTitleOneLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
            
            addSubview(rankingItemTitleTwoLabel)
            rankingItemTitleTwoLabel.anchor(top: stackViewRankingItemOne.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
            
            stackViewRankingItemTwo.axis = .horizontal
            stackViewRankingItemTwo.distribution = .fill
            stackViewRankingItemTwo.spacing = 6.0
            
            addSubview(stackViewRankingItemTwo)
            stackViewRankingItemTwo.anchor(top: rankingItemTitleTwoLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
            
            addSubview(rankingItemTitleThreeLabel)
            rankingItemTitleThreeLabel.anchor(top: stackViewRankingItemTwo.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
            
            stackViewRankingItemThree.axis = .horizontal
            stackViewRankingItemThree.distribution = .fill
            stackViewRankingItemThree.spacing = 6.0
            
            addSubview(stackViewRankingItemThree)
            stackViewRankingItemThree.anchor(top: rankingItemTitleThreeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
            addSubview(separatorView)
            separatorView.anchor(top: stackViewRankingItemThree.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 38, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 12)
//        }
    }

    @objc func handleUsernameTapped() {
        print("handleUsernameTapped")
//        delegate?.handleUsernameTapped(for: self)
    }

    @objc func handleOptionsTapped() {
        print("handleOptionsTapped")
//        delegate?.handleOptionsTapped(for: self)
    }

    @objc func handleLikeTapped() {
        print("handleLikeTapped")
//        delegate?.handleLikeTapped(for: self, isDoubleTap: false)
    }

    @objc func handleCommentTapped() {
        print("handleCommentTapped")
//        delegate?.handleCommentTapped(for: self)
    }

    @objc func handleShowLikes() {
        print("handleShowLikes")
//        delegate?.handleShowLikes(for: self)
    }

    @objc func handleDoubleTapToLike() {
        print("handleDoubleTapToLike")
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

