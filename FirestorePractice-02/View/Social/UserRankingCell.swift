//
//  RankingCell.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/13/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit

class UserRankingCell: UICollectionViewCell {
    
    var ranking: Ranking? {
        
        didSet {
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
