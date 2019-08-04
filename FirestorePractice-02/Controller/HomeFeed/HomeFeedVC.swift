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
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = FeedCell(frame: frame)
        dummyCell.ranking = rankings[indexPath.item]
        dummyCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 800)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        
        let height = max(40 + 8 + 8, estimatedSize.height)
        return CGSize(width: view.frame.width, height: height)
        
//        let width = view.frame.width
//        var height = width + 8 + 40 + 8
//        height += 50
//        height += 60
//
//        return CGSize(width: width, height: height)
    }
    
    // MARK: - UICollectionViewDataSource
    
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        //        if posts.count > (PAGINATION_FEED_VC - 1) {
//        print("willDisplay")
//        if rankings.count > 4 {
//            if indexPath.item == rankings.count - 1 {
//                fetchPosts()
//            }
//        }
//    }

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

        } else {

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
        self.navigationItem.leftBarButtonItem?.tintColor = .darkGray
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
    
    func fetchPosts() {

        var queryRanking: Query!
        var queryRankingItem: Query!

        // DEBUG
        print("DEBUG: FeedVC fetchPosts - 1")

        guard let currentUid = Auth.auth().currentUser?.uid else { return }

//        isFetchingUpdates = true

        if rankings.isEmpty {

            // "order by" not working. Don't know why.
//            queryRanking = RANKING_REF.order(by: RANKING_CREATED_DATE, descending: true).order(by: RANKING_TITLE, descending: true)
//            queryRanking = RANKING_REF.order(by: "rankingCreatedDate", descending: true).order(by: "rankingTitle", descending: true)
//            queryRanking = RANKING_REF.order(by: "rankingCreatedDate", descending: true)
            queryRanking = RANKING_REF.order(by: RANKING_CREATED_DATE, descending: true)
//            queryRanking = RANKING_REF.order(by: RANKING_TITLE, descending: true)
            
        } else {

            // "order by" not working. Don't know why.
//            
            // planed to modify when pagination is implemented
//            queryRanking = RANKING_REF.order(by: RANKING_CREATED_DATE, descending: true).order(by: RANKING_TITLE, descending: true)
//            queryRanking = RANKING_REF.order(by: "rankingCreatedDate", descending: true).order(by: "rankingTitle", descending: true)
//            queryRanking = RANKING_REF.order(by: "rankingCreatedDate", descending: true)
            queryRanking = RANKING_REF.order(by: RANKING_CREATED_DATE, descending: true)
//            queryRanking = RANKING_REF.order(by: RANKING_TITLE, descending: true)
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
                
                self.rankings.removeAll()
                
                var documentId: String!
                var rankingOwnerId: String!
                var rankingTitle: String!
                var rankingCreatedDate: Date!
                
                for document in snap.documents {
                    let data = document.data()
                    documentId = document.documentID
                    rankingOwnerId = data[RANKING_OWNER_ID] as? String ?? ""
                    rankingTitle = data[RANKING_TITLE] as? String ?? "no data"
                    rankingCreatedDate = (data[RANKING_CREATED_DATE] as? Timestamp)?.dateValue() ?? Date()
                    
                    let emptyRankingItem = RankingItem(rankingItemTitle: "", rankingItemText: "", rankingItemImageUrl: "", rankingItemId: "")
                    self.rankingItems.append(emptyRankingItem)
                    let newRanking = Ranking(documentId: documentId, rankingOwnerId: rankingOwnerId, rankingTitle: rankingTitle, rankingCreatedDate: rankingCreatedDate, rankingItems: self.rankingItems)
                    self.rankings.append(newRanking)
                }
                
                for i in 0..<self.rankings.count {

                    let ranking = self.rankings[i]
                    
                    guard let documentId = ranking.documentId else { return }
                    print("document ID: \(documentId)")
                    queryRankingItem = RANKING_REF.document(documentId).collection(RANKING_ITEM_COLLECTION)
                    
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

                            self.rankings[i] = Ranking(documentId: ranking.documentId, rankingOwnerId: ranking.rankingOwnerId, rankingTitle: ranking.rankingTitle, rankingCreatedDate: ranking.rankingCreatedDate, rankingItems: self.rankingItems)
                            print("*** new ranking appended: \(rankingTitle)")
                            print("*** the number of items appended to the ranking: \(self.rankingItems.count)")
                            self.collectionView?.reloadData()
                        }
                    })
                    
                }
            }
        } // End of queryRanking.getDocuments { (snapshot, error) in
    }
}
