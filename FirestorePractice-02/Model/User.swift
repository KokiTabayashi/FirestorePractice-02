//
//  User.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/13/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import Foundation

class User {
    
    // MARK: -  attributes
    
    private(set) var uid: String!
    private(set) var username: String!
    private(set) var fullName: String!
    private(set) var photoImageUrl: String!

    // MARK: -  Init
    
    init(uid: String, username: String, fullName: String, photoImageUrl: String) {
        self.uid = uid
        self.username = username
        self.fullName = fullName
        self.photoImageUrl = photoImageUrl
    }
}
