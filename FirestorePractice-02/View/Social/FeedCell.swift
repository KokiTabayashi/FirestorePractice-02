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
            
            guard let rankingTitle = ranking?.rankingTitle else { return }
            guard let rankingCreatedDate = ranking?.rankingCreatedDate else { return }
            
            guard let rankingItems = ranking?.rankingItems else { return }
            
            print("ranking items count: \(rankingItems.count)")
            
            rankingTitleLabel.text = rankingTitle
            rankingCreatedDateLabel.text = rankingCreatedDate.timeAgoToDisplay()

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
            }
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return iv
    }()
    
    lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Username", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 51), for: .normal)
        button.setTitleColor(UIColor.rgb(red: 32, green: 32, blue: 32), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleUsernameTapped), for: .touchUpInside)
        return button
    }()
    
    let rankingTitleLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .black
//        label.textColor = UIColor.rgb(red: 47, green: 79, blue: 79)
//        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 51)
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
//        label.backgroundColor = UIColor.lightGray
//        label.layer.borderWidth = 0.5
//        label.layer.borderColor = UIColor.lightGray.cgColor
//        label.layer.cornerRadius = 8
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
//        label.textColor = .black
//        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 51)
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextOneLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .black
        //        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 51)
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.rgb(red: 220, green: 220, blue: 220).cgColor
        return label
    }()
    
    let rankingItemOneImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
//        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor.rgb(red: 220, green: 220, blue: 220).cgColor
        return iv
    }()
    
    let rankingItemTitleTwoLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .black
        //        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 51)
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextTwoLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .black
        //        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 51)
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.rgb(red: 220, green: 220, blue: 220).cgColor
        return label
    }()
    
    let rankingItemTwoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
//        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor.rgb(red: 220, green: 220, blue: 220).cgColor
        return iv
    }()
    
    let rankingItemTitleThreeLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .black
        //        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 51)
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextThreeLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .black
        //        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 51)
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.rgb(red: 220, green: 220, blue: 220).cgColor
        return label
    }()
    
    let rankingItemThreeImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
//        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor.rgb(red: 220, green: 220, blue: 220).cgColor
        return iv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
//        view.backgroundColor = .lightGray
//        view.backgroundColor = UIColor.rgb(red: 212, green: 103, blue: 115)
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

