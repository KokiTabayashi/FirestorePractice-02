//
//  RankItem.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/15/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import Foundation

class RankingItem {
    
    private(set) var rankingItemTitle: String!
    private(set) var rankingItemText: String!
    private(set) var rankingItemImageUrl: String!
    private(set) var rankingItemId: String!

    init(rankingItemTitle: String, rankingItemText: String, rankingItemImageUrl: String, rankingItemId: String) {
        self.rankingItemTitle = rankingItemTitle
        self.rankingItemText = rankingItemText
        self.rankingItemImageUrl = rankingItemImageUrl
        self.rankingItemId = rankingItemId
    }
}
