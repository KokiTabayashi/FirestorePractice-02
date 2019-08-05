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
                guard let rankingScoreOne = rankingItems[0].rankingScore else { return }
                
                rankingItemTitleOneLabel.text = rankingItemTitleOne
                rankingItemTextOneLabel.text = rankingItemTextOne
                rankingItemOneImageView.loadImage(with: rankingItemImageUrlOne)
                rankingScoreLabelOne.text = String(format: "Score: %.0f / 100", rankingScoreOne)
                
                let rankingItemTitleTwo = " "
                let rankingItemTextTwo = " "
                let rankingItemImageUrlTwo = " "
                
                rankingItemTitleTwoLabel.text = rankingItemTitleTwo
                rankingItemTextTwoLabel.text = rankingItemTextTwo
                rankingItemTwoImageView.loadImage(with: rankingItemImageUrlTwo)
                rankingScoreLabelTwo.text = " "
                
                let rankingItemTitleThree = " "
                let rankingItemTextThree = " "
                let rankingItemImageUrlThree = " "
                
                rankingItemTitleThreeLabel.text = rankingItemTitleThree
                rankingItemTextThreeLabel.text = rankingItemTextThree
                rankingItemThreeImageView.loadImage(with: rankingItemImageUrlThree)
                rankingScoreLabelThree.text = " "
                
            } else if rankingItems.count == 2 {
                guard let rankingItemTitleOne = rankingItems[0].rankingItemTitle else { return }
                guard let rankingItemTextOne = rankingItems[0].rankingItemText else { return }
                guard let rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl else { return }
                guard let rankingScoreOne = rankingItems[0].rankingScore else { return }
                
                rankingItemTitleOneLabel.text = rankingItemTitleOne
                rankingItemTextOneLabel.text = rankingItemTextOne
                rankingItemOneImageView.loadImage(with: rankingItemImageUrlOne)
                rankingScoreLabelOne.text = String(format: "Score: %.0f / 100", rankingScoreOne)
                
                guard let rankingItemTitleTwo = rankingItems[1].rankingItemTitle else { return }
                guard let rankingItemTextTwo = rankingItems[1].rankingItemText else { return }
                guard let rankingItemImageUrlTwo = rankingItems[1].rankingItemImageUrl else { return }
                guard let rankingScoreTwo = rankingItems[1].rankingScore else { return }
                
                rankingItemTitleTwoLabel.text = rankingItemTitleTwo
                rankingItemTextTwoLabel.text = rankingItemTextTwo
                rankingItemTwoImageView.loadImage(with: rankingItemImageUrlTwo)
                rankingScoreLabelTwo.text = String(format: "Score: %.0f / 100", rankingScoreTwo)
                
                let rankingItemTitleThree = " "
                let rankingItemTextThree = " "
                let rankingItemImageUrlThree = " "
                
                rankingItemTitleThreeLabel.text = rankingItemTitleThree
                rankingItemTextThreeLabel.text = rankingItemTextThree
                rankingItemThreeImageView.loadImage(with: rankingItemImageUrlThree)
                rankingScoreLabelThree.text = " "
                
            } else if rankingItems.count >= 3 {
                guard let rankingItemTitleOne = rankingItems[0].rankingItemTitle else { return }
                guard let rankingItemTextOne = rankingItems[0].rankingItemText else { return }
                guard let rankingItemImageUrlOne = rankingItems[0].rankingItemImageUrl else { return }
                guard let rankingScoreOne = rankingItems[0].rankingScore else { return }
                
                rankingItemTitleOneLabel.text = rankingItemTitleOne
                rankingItemTextOneLabel.text = rankingItemTextOne
                rankingItemOneImageView.loadImage(with: rankingItemImageUrlOne)
                rankingScoreLabelOne.text = String(format: "Score: %.0f / 100", rankingScoreOne)
                
                guard let rankingItemTitleTwo = rankingItems[1].rankingItemTitle else { return }
                guard let rankingItemTextTwo = rankingItems[1].rankingItemText else { return }
                guard let rankingItemImageUrlTwo = rankingItems[1].rankingItemImageUrl else { return }
                guard let rankingScoreTwo = rankingItems[1].rankingScore else { return }
                
                rankingItemTitleTwoLabel.text = rankingItemTitleTwo
                rankingItemTextTwoLabel.text = rankingItemTextTwo
                rankingItemTwoImageView.loadImage(with: rankingItemImageUrlTwo)
                rankingScoreLabelTwo.text = String(format: "Score: %.0f / 100", rankingScoreTwo)
                
                guard let rankingItemTitleThree = rankingItems[2].rankingItemTitle else { return }
                guard let rankingItemTextThree = rankingItems[2].rankingItemText else { return }
                guard let rankingItemImageUrlThree = rankingItems[2].rankingItemImageUrl else { return }
                guard let rankingScoreThree = rankingItems[2].rankingScore else { return }
                
                rankingItemTitleThreeLabel.text = rankingItemTitleThree
                rankingItemTextThreeLabel.text = rankingItemTextThree
                rankingItemThreeImageView.loadImage(with: rankingItemImageUrlThree)
                rankingScoreLabelThree.text = String(format: "Score: %.0f / 100", rankingScoreThree)
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
        button.setTitleColor(UIColor.rgb(red: 32, green: 32, blue: 32), for: .normal)
        button.titleLabel?.font = UIFont (name: "Arial", size: 12)
        button.addTarget(self, action: #selector(handleUsernameTapped), for: .touchUpInside)
        return button
    }()
    
    let rankingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 16)
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
    
    let numberOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 18)
        label.text = "Number 1"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        return label
    }()
    
    let rankingScoreLabelOne: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 18)
        label.text = "0"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 220.0).isActive = true
        return label
    }()
    
    let rankingItemTitleOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 16)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 12)
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
    
    let numberTwoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 18)
        label.text = "Number 2"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        return label
    }()
    
    let rankingScoreLabelTwo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 18)
        label.text = "0"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 220.0).isActive = true
        return label
    }()
    
    let rankingItemTitleTwoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 16)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextTwoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 12)
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
    
    let numberThreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 18)
        label.text = "Number 3"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        return label
    }()
    
    let rankingScoreLabelThree: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 18)
        label.text = "0"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 220.0).isActive = true
        return label
    }()
    
    let rankingItemTitleThreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 16)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemTextThreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 32, green: 32, blue: 32)
        label.font = UIFont (name: "Arial", size: 12)
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
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    
    lazy var stackViewNumberOne = UIStackView(arrangedSubviews: [numberOneLabel, rankingScoreLabelOne])
    lazy var stackViewNumberTwo = UIStackView(arrangedSubviews: [numberTwoLabel, rankingScoreLabelTwo])
    lazy var stackViewNumberThree = UIStackView(arrangedSubviews: [numberThreeLabel, rankingScoreLabelThree])
    
//    lazy var stackViewRankingItemScoreOne = UIStackView(arrangedSubviews: [rankingScoreLabelOne, rankingItemTitleOneLabel])
//    lazy var stackViewRankingItemScoreTwo = UIStackView(arrangedSubviews: [rankingScoreLabelTwo, rankingItemTitleTwoLabel])
//    lazy var stackViewRankingItemScoreThree = UIStackView(arrangedSubviews: [rankingScoreLabelThree, rankingItemTitleThreeLabel])
    
    lazy var stackViewRankingItemOne = UIStackView(arrangedSubviews: [rankingItemOneImageView, rankingItemTextOneLabel])
    lazy var stackViewRankingItemTwo = UIStackView(arrangedSubviews: [rankingItemTwoImageView, rankingItemTextTwoLabel])
    lazy var stackViewRankingItemThree = UIStackView(arrangedSubviews: [rankingItemThreeImageView, rankingItemTextThreeLabel])


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    // MARK: - Handlers
    
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
        
        stackViewNumberOne.axis = .horizontal
        stackViewNumberOne.distribution = .fill
        stackViewNumberOne.alignment = .fill
        stackViewNumberOne.spacing = 6.0
        addSubview(stackViewNumberOne)
        stackViewNumberOne.anchor(top: rankingCreatedDateLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        addSubview(rankingItemTitleOneLabel)
        rankingItemTitleOneLabel.anchor(top: stackViewNumberOne.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        stackViewRankingItemOne.axis = .horizontal
        //            stackViewRankingItemOne.alignment = .top
        stackViewRankingItemOne.distribution = .fill
        stackViewRankingItemOne.spacing = 6.0
        addSubview(stackViewRankingItemOne)
        stackViewRankingItemOne.anchor(top: rankingItemTitleOneLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        stackViewNumberTwo.axis = .horizontal
        stackViewNumberTwo.distribution = .fill
        stackViewNumberTwo.alignment = .fill
        stackViewNumberTwo.spacing = 6.0
        addSubview(stackViewNumberTwo)
        stackViewNumberTwo.anchor(top: stackViewRankingItemOne.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(rankingItemTitleTwoLabel)
        rankingItemTitleTwoLabel.anchor(top: stackViewNumberTwo.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        stackViewRankingItemTwo.axis = .horizontal
        stackViewRankingItemTwo.distribution = .fill
        stackViewRankingItemTwo.spacing = 6.0
        addSubview(stackViewRankingItemTwo)
        stackViewRankingItemTwo.anchor(top: rankingItemTitleTwoLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        stackViewNumberThree.axis = .horizontal
        stackViewNumberThree.distribution = .fill
        stackViewNumberThree.alignment = .fill
        stackViewNumberThree.spacing = 6.0
        addSubview(stackViewNumberThree)
        stackViewNumberThree.anchor(top: stackViewRankingItemTwo.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        addSubview(rankingItemTitleThreeLabel)
        rankingItemTitleThreeLabel.anchor(top: stackViewNumberThree.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
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

