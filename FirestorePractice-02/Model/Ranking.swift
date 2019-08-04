//
//  Rank.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/13/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import Foundation
import Firebase

class Ranking {
    
    private(set) var documentId: String!
    private(set) var rankingTitle: String!
    private(set) var rankingCreatedDate: Date!
    private(set) var rankingItems = [RankingItem]()
    private(set) var rankingOwnerId: String!

//    private(set) var

    init(documentId: String, rankingOwnerId: String, rankingTitle: String, rankingCreatedDate: Date, rankingItems: [RankingItem]) {
//    init(rankingTitle: String, rankingCreatedDate: Date) {
        self.documentId = documentId
        self.rankingOwnerId = rankingOwnerId
        self.rankingTitle = rankingTitle
        self.rankingCreatedDate = rankingCreatedDate
        self.rankingItems = rankingItems
    }
    
//    class func parseData(snapshot: QuerySnapshot?) -> [Ranking] {
//        var rankings = [Ranking]()
//
//        guard let snap = snapshot else { return rankings }
//        for document in snap.documents {
//            let data = document.data()
////            let username = data[USERNAME] as? String ?? "Anonymous"
//            //                    let timestamp = data[TIMESTAMP] as? Date ?? Date()
//            //                    let timestampTmp = data[TIMESTAMP] as? Timestamp ?? FieldValue.serverTimestamp() as! Timestamp
//            //                    let timestamp = timestampTmp.dateValue()
//            let rankingTitle = data[RANKING_TITLE] as? String ?? "no data"
//            let rankingCreatedDate = (data[RANKING_CREATED_DATE] as? Timestamp)?.dateValue() ?? Date()
////            let thoughtTxt = data[THOUGHT_TXT] as? String ?? ""
////            let numLikes = data[NUM_LIKES] as? Int ?? 0
////            let numComments = data[NUM_COMMENTS] as? Int ?? 0
////            let documentId = document.documentID
////            let userId = data[USER_ID] as? String ?? ""
////            let photoImageUrl = data[PHOTOIMAGEURL_TXT] as? String ?? ""
//            let rankingItems =
////            let newThought = Thought(username: username, timestamp: timestamp, thoughtTxt: thoughtTxt, numLikes: numLikes, numComments: numComments, documentId: documentId, userId: userId, photoImageUrl: photoImageUrl)
//
//            let newRanking = Ranking(rankingTitle: rankingTitle, rankingCreatedDate: rankingCreatedDate, rankingItems: rankingItems )
//            rankings.append(newRanking)
//        }
//        return rankings
//    }
}
