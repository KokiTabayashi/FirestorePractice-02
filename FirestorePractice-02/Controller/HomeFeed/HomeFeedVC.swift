//
//  HomeFeedVC.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/11/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class HomeFeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, FeedCellDelegate {

    // MARK: - Variables
    
    var viewSinglePost = false
    var ranking: Ranking?
    var rankings = [Ranking]()
    var currentKey: String?
    var userProfileController: UserProfileVC?
    var isFetchingUpdates = false
    var rankingItems = [RankingItem]()
    var rankingTap: (Ranking?, [RankingItem?])?
    var rankingDict: [String: [RankingItem]] = [:]
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        // register refresh control
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // configure refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        // configure logout button
        configureNavigationBar()
        
        // configure FCM Token
        
        
        // fetch post
        if !viewSinglePost {
            fetchPosts()
        }
        
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        print("collectionViewLayout")
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        if posts.count > (PAGINATION_FEED_VC - 1) {
        print("willDisplay")
        if rankings.count > 4 {
            if indexPath.item == rankings.count - 1 {
                fetchPosts()
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewSinglePost {
            return 1
        } else {
            return rankings.count
        }
//        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        // this need to be done before if viewSinglePost
        cell.delegate = self

        if viewSinglePost {
//            if let ranking = self.ranking {
//                cell.rankingTap.0 = ranking
//            }
        } else {
//            cell.rankingTap.0 = rankings[indexPath.item]
//            cell.rankingTap.1 = rankings[indexPath.item].rankingItems
//            cell.rankingTap = (rankings[indexPath.item], rankings[indexPath.item].rankingItems)
//            cell.rankingTap = (rankings[indexPath.item], rankings[indexPath.item].rankingItems)
            cell.ranking = rankings[indexPath.item]
            print("cellForItemAt: \(indexPath.item)")
        }
        
//        handleHashtagTapped(forCell: cell)
//
//        handleUsernameLabelTapped(forCell: cell)
//
//        handleMentionTapped(forCell: cell)
        
        return cell
    }
    
    // MARK: - FeedCellDelegate Protocol
    
    func handleUsernameTapped(for cell: FeedCell) {

    }

    func handleOptionsTapped(for cell: FeedCell) {

    }

    func handleLikeTapped(for cell: FeedCell, isDoubleTap: Bool) {

    }

    func handleCommentTapped(for cell: FeedCell) {

    }

    func handleConfigureLikeButton(for cell: FeedCell) {

    }

    func handleShowLikes(for cell: FeedCell) {

    }
    
    // MARK: - Handlers

    @objc func handleRefresh() {
        rankings.removeAll(keepingCapacity: false)
        self.currentKey = nil
        fetchPosts()
        collectionView?.reloadData()
    }

    func configureNavigationBar() {
//        if !viewSinglePost {
            // left button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
            // right button
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "send2"), style: .plain, target: self, action: #selector(handleShowMessages))
//        }
        self.navigationItem.title = "Home"
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
    
    // MARK: - API
    
//    func setUserFCMToken() {
//        guard let currentUid = Auth.auth().currentUser?.uid else { return }
//        guard let fcmToken = Messaging.messaging().fcmToken else { return }
//
//        let values = ["fcmToken": fcmToken]
//
//        USER_REF.child(currentUid).updateChildValues(values)
//    }
    
    func fetchPosts() {

        var queryRanking: Query!
        var queryRankingItem: Query!

        // DEBUG
        print("DEBUG: FeedVC fetchPosts - 1")

        guard let currentUid = Auth.auth().currentUser?.uid else { return }

//        isFetchingUpdates = true

        if rankings.isEmpty {

            queryRanking = RANKING_REF
                .order(by: RANKING_CREATED_DATE, descending: true)
            
        } else {

            // planed to modify when pagination is implemented
            queryRanking = RANKING_REF
                .order(by: RANKING_CREATED_DATE, descending: true)
        }
        
        queryRanking.getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if snapshot!.isEmpty {
                self.isFetchingUpdates = false
                print("*** snapshot is empty ***")
                return
            } else {
                guard let snap = snapshot else { return }

//                self.collectionView?.refreshControl?.endRefreshing()

                self.rankings.removeAll()
                
                for document in snap.documents {
                    let data = document.data()
                    let documentId = document.documentID
                    let rankingOwnerId = data[RANKING_OWNER_ID] as? String ?? ""
                    let rankingTitle = data[RANKING_TITLE] as? String ?? "no data"
                    let rankingCreatedDate = (data[RANKING_CREATED_DATE] as? Timestamp)?.dateValue() ?? Date()
//                    let numLikes = data[NUM_LIKES] as? Int ?? 0
//                    let numComments = data[NUM_COMMENTS] as? Int ?? 0
//                    let userId = data[USER_ID] as? String ?? ""
//                    let photoImageUrl = data[PHOTOIMAGEURL_TXT] as? String ?? ""

                    if true {
                        print("document ID: \(documentId)")
                        queryRankingItem = RANKING_REF.document(documentId).collection(RANKING_ITEM_COLLECTION)
//                        queryRankingItem = RANKING_REF.document(documentId).collection(RANKING_ITEM_COLLECTION).order(by: RANKING_CREATED_DATE, descending: true)
                    } else {
                        // planed to modify when pagination is implemented
                    }

                    queryRankingItem.getDocuments(completion: { (snapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if snapshot!.isEmpty {
                            self.isFetchingUpdates = false
                            print("*** item snapshot is empty ***")
                            return
                        } else {
                            guard let snap = snapshot else {
                                print("DEBUG: Couldn't do snap = snapshot")
                                return
                            }
                            
                            self.collectionView?.refreshControl?.endRefreshing()
                            
                            self.rankingItems.removeAll()
                            
                            for document in snap.documents {
                                let data = document.data()
                                let rankingItemId = document.documentID
                                let rankingItemTitle = data[RANKING_ITEM_TITLE] as? String ?? ""
                                let rankingItemText = data[RANKING_ITEM_TEXT] as? String ?? ""
                                let rankingItemImageUrl = data[RANKING_ITEM_IMAGE_URL] as? String ?? ""
                                
                                let newRankingItem = RankingItem(rankingItemTitle: rankingItemTitle, rankingItemText: rankingItemText, rankingItemImageUrl: rankingItemImageUrl, rankingItemId: rankingItemId)
                                self.rankingItems.append(newRankingItem)
                                print("*** new ranking Item appended :\(rankingItemTitle)")
                                print("*** new ranking Text appended : \(rankingItemText)")
                                print("*** total number of rankingItems: \(self.rankingItems.count)")
                            }
                            // test
                            let newRanking = Ranking(rankingTitle: rankingTitle, rankingCreatedDate: rankingCreatedDate, rankingItems: self.rankingItems)
                            self.rankings.append(newRanking)
                            print("*** new ranking appended :\(rankingTitle)")
                            print("*** the number of items appended to the ranking: ")
                            self.collectionView?.reloadData()
                        }
//                        self.collectionView?.reloadData()
                    })
//                    self.collectionView?.reloadData()
                    //                    let newRanking = Thought(username: username, timestamp: timestamp, thoughtTxt: thoughtTxt, numLikes: numLikes, numComments: numComments, documentId: documentId, userId: userId, photoImageUrl: photoImageUrl)
                    
                    // test commenting out
//                    let newRanking = Ranking(rankingTitle: rankingTitle, rankingCreatedDate: rankingCreatedDate, rankingItems: self.rankingItems)
                    
//                    let newRanking = Ranking(rankingTitle: rankingTitle, rankingCreatedDate: rankingCreatedDate)
                    
                    // test commenting out
//                    self.rankings.append(newRanking)
//                    print("*** new ranking appended :\(rankingTitle)")
//                    print("*** the number of items appended to the ranking: ")
                } // End of for document in snap.documents {

//                self.collectionView?.reloadData()
                
            } // End of } else { guard let snap = snapshot else { return }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                self.tableView.reloadData()
//                self.isFetchingUpdates = false
//            })
//
//            self.lastDocumentSnapshot = snapshot!.documents.last!
            
        } // End of queryRanking.getDocuments { (snapshot, error) in
        
        
        
    
        // old code: Firebase
//        if currentKey == nil {
//
//            // DEBUG
//            print("DEBUG: FeedVC fetchPosts - 2")
//
//            // USER_FEED_REF.child(currentUid).queryLimited(toLast: PAGINATION_FEED_VC).observeSingleEvent(of: .value) { (snapshot) in
//            USER_FEED_REF.child(currentUid).queryLimited(toLast: 5).observeSingleEvent(of: .value) { (snapshot) in
//
//                // DEBUG
//                print("DEBUG: FeedVC fetchPosts - 3")
//
//                self.collectionView?.refreshControl?.endRefreshing()
//
//                guard let first = snapshot.children.allObjects.first as? DataSnapshot else { return }
//                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
//
//                allObjects.forEach({ (snapshot) in
//                    let postId = snapshot.key
//                    self.fetchPost(withPostId: postId)
//                })
//                self.currentKey = first.key
//            }
//        } else {
//
//            // DEBUG
//            print("DEBUG: FeedVC fetchPosts - 4")
//
//            // USER_FEED_REF.child(currentUid).queryOrderedByKey().queryEnding(atValue: self.currentKey).queryLimited(toLast: (PAGINATION_FEED_VC + 1)).observeSingleEvent(of: .value) { (snapshot) in
//            USER_FEED_REF.child(currentUid).queryOrderedByKey().queryEnding(atValue: self.currentKey).queryLimited(toLast: 6).observeSingleEvent(of: .value) { (snapshot) in
//
//                // DEBUG
//                print("DEBUG: FeedVC fetchPosts - 5")
//
//                guard let first = snapshot.children.allObjects.first as? DataSnapshot else { return }
//                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
//
//                allObjects.forEach({ (snapshot) in
//                    let postId = snapshot.key
//                    if postId != self.currentKey {
//                        self.fetchPost(withPostId: postId)
//                    }
//                })
//                self.currentKey = first.key
//            }
//        }
        
        // Codes before implementing the pagination
        //        USER_FEED_REF.child(currentUid).observe(.childAdded) { (snapshot) in
        //
        //            let postId = snapshot.key
        //
        //            Database.fetchPost(with: postId, completion: { (post) in
        //
        //                self.posts.append(post)
        //
        //                self.posts.sort(by: { (post1, post2) -> Bool in
        //                    return post1.creationDate > post2.creationDate
        //                })
        //
        //                // stop refreshing
        //                self.collectionView?.refreshControl?.endRefreshing()
        //
        //                self.collectionView?.reloadData()
        //            })
        //        }
    }

//    func fetchPost(withPostId postId: String) {
//
//        // DEBUG
//        print("DEBUG: FeedVC fetchPost - 1")
//
//        Database.fetchPost(with: postId) { (post) in
//
//            // DEBUG
//            print("DEBUG: FeedVC fetchPost - 2")
//
//            self.posts.append(post)
//            self.posts.sort(by: { (post1, post2) -> Bool in
//                return post1.creationDate > post2.creationDate
//            })
//            self.collectionView?.reloadData()
//
//            // DEBUG
//            print("DEBUG: FeedVC fetchPost - 3")
//        }
//    }
}
