//
//  RankingCell.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/27/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class RankingCell: UITableViewCell {
    
    // MARK: - Variables
    
    var rankingItem: RankingItem? {
        
        didSet {
//            guard let ownerUid = ranking?.rankingOwnerId else { return }
            
//            Firestore.fetchUser(with: ownerUid) { (user) in
//                let username = user.username as? String ?? ""
//                let photoImageUrl = user.photoImageUrl as? String ?? ""
//                self.usernameButton.setTitle(username, for: .normal)
//                self.profileImageView.loadImage(with: photoImageUrl)
//            }
            
//            guard let rankingTitle = ranking?.rankingTitle else { return }
//            guard let rankingCreatedDate = ranking?.rankingCreatedDate else { return }
//            guard let rankingItems = ranking?.rankingItems else { return }
            
//            rankingTitleLabel.text = rankingTitle
//            rankingCreatedDateLabel.text = rankingCreatedDate.timeAgoToDisplay()
         
            guard let rankingItemTitle = rankingItem?.rankingItemTitle else { return }
            guard let rankingItemText = rankingItem?.rankingItemText else { return }
            guard let rankingItemImageUrl = rankingItem?.rankingItemImageUrl else { return }
            guard let rankingScore = rankingItem?.rankingScore else { return }
            
            rankingItemTitleLabel.text = rankingItemTitle
            rankingItemTextLabel.text = rankingItemText
            rankingItemImageView.loadImage(with: rankingItemImageUrl)
            rankingScoreLabel.text =  String(format: "Score: %.0f / 100", rankingScore)
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    // MARK: - Outlets
    
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
        return label
    }()
    
    let rankingCreatedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "2 DAYS AGO"
        return label
    }()
    
    let rankingNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = " "
        return label
    }()
    
    let rankingScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Score: 0 / 100"
        return label
    }()
    
    let rankingItemTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Ranking Title"
        return label
    }()
    
    let rankingItemTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let rankingItemImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        return iv
    }()
    
    lazy var stackViewRankingNumber = UIStackView(arrangedSubviews: [rankingNumberLabel, rankingScoreLabel])
    lazy var stackViewRankingItem = UIStackView(arrangedSubviews: [rankingItemImageView, rankingItemTextLabel])
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    // MARK: - Handler
    
    func configureView() {
        contentView.addSubview(containerView)
        containerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView.addSubview(rankingItemTitleLabel)
        rankingItemTitleLabel.anchor(top: self.containerView.topAnchor, left: self.containerView.leftAnchor, bottom: nil, right: self.containerView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        stackViewRankingNumber.axis = .horizontal
        stackViewRankingNumber.distribution = .fill
        stackViewRankingNumber.spacing = 6.0
        stackViewRankingNumber.backgroundColor = .lightGray
        containerView.addSubview(stackViewRankingNumber)
        stackViewRankingNumber.anchor(top: rankingItemTitleLabel.bottomAnchor, left: self.containerView.leftAnchor, bottom: nil, right: self.containerView.rightAnchor, paddingTop: 2, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        stackViewRankingItem.axis = .horizontal
        stackViewRankingItem.distribution = .fill
        stackViewRankingItem.spacing = 6.0
        stackViewRankingItem.backgroundColor = .lightGray
        containerView.addSubview(stackViewRankingItem)
        stackViewRankingItem.anchor(top: stackViewRankingNumber.bottomAnchor, left: self.containerView.leftAnchor, bottom: self.containerView.bottomAnchor, right: self.containerView.rightAnchor, paddingTop: 2, paddingLeft: 8, paddingBottom: 2, paddingRight: 8, width: 0, height: 0)
    }
    
    @objc func handleUsernameTapped() {
        print("handleUsernameTapped")
        //        delegate?.handleUsernameTapped(for: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
