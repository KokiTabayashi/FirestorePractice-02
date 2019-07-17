//
//  UserProfileVC.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/11/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UIViewController {
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 72, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2

        view.addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setUserProfileImage()
        setUserName()
    }
    
    func setUserProfileImage() {
        guard let userProfileImageUrl = Auth.auth().currentUser?.photoURL?.absoluteString else { return }
        profileImageView.loadImage(with: userProfileImageUrl)
    }
    
    func setUserName() {
        guard let username = Auth.auth().currentUser?.displayName else { return }
        nameLabel.text = username
    }
    
    
    func configureNavigationBar() {

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        self.navigationItem.title = "User Profile"
    }
    
    @objc func handleLogout() {
        
        // declare alert controller
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // add alert log out action
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                // attempt sign out
                try Auth.auth().signOut()
                
                // present login controller
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            } catch {
                
                // handle error
                print("Failed to sign out ...")
            }
        }))
        
        // add cancel action
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}

//private let reuseIdentifier = "Cell"
//
//class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate {
//
//    // MARK: - Properties
//
//    var rankings = [Ranking]()
//
//
//    // MARK: - Init
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // register cell classes
////        self.collectionView!.register(UserRankingCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//        // configure refresh control
//
//        // background color
//        self.collectionView?.backgroundColor = .white
//
//        // fetch user data
//
//        // fetch rankings
//
//
//    }
//
//    // MARK: - UICollectionViewFlowLayout
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 2) / 3
//        return CGSize(width: width, height: width)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 200)
//    }
//
//    // MARK: - UICollectionView
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    // This will be used for pagination
////    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
////        if ranks.count > 9 {
////            if indexPath.item == ranks.count - 1 {
////                fetchPosts()
////            }
////        }
////    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return rankings.count
//        return 1
//    }
//
////    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
////
////        // declare header
////        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
////
////        // set delegate
////        header.delegate = self
////
////        // set the user in header
////        header.user = self.user
////        navigationItem.title = user?.username
////
////        // return header
////        return header
////    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RankingCell
////
////        cell.ranking = rankings[indexPath.item]
////
////        return cell
//        return UICollectionViewCell()
//    }
//
////    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////
////        let feedVC = FeedVC(collectionViewLayout: UICollectionViewFlowLayout())
////
////        feedVC.viewSinglePost = true
////        feedVC.userProfileController = self
////
////        feedVC.post = posts[indexPath.item] // it's okay to say indexPath.row (doesn't matter)
////
////        navigationController?.pushViewController(feedVC, animated: true)
////    }
//
//    // MARK: - UserProfileHeaderDelegate
//
//    func handleFollowersTapped(for header: UserProfileHeader) {
//        print("handleFollowersTapped")
//    }
//
//    func handleFollowingTapped(for header: UserProfileHeader) {
//        print("handleFollowingTapped")
//    }
//
//    func handleEditFollowTapped(for header: UserProfileHeader) {
//        print("handleEditFollowTapped")
//    }
//
//    func setUserStats(for header: UserProfileHeader) {
//        print("setUserStats")
//    }
//
//    // MARK: - Handlers
//
//    // MARK: - API
//
//}
