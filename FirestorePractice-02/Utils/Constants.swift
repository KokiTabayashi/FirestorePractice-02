//
//  Constants.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/11/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import Foundation
import Firebase

// MARK: - General constants

let USERS_REF = "users"

let USERNAME = "username"
let DATE_CREATED = "dateCreated"
let PHOTOIMAGEURL_TXT = "photoImageUrl"
let FULLNAME = "fullName"

// MARK: - ranking collection
let RANKING_COLLECTION = "rankings"
let RANKING_TITLE = "rankingTitle"
let RANKING_ID = "rankingId"
let RANKING_CREATED_DATE = "rankingCreatedDate"
let RANKING_OWNER_ID = "rankingOwnerId"

// MARK: - ranking item collection
let RANKING_ITEM_COLLECTION = "rankingItems"
let RANKING_ITEM_TITLE = "rankingItemTitle"
let RANKING_ITEM_ID = "rankingItemId"
let RANKING_ITEM_IMAGE_URL = "rankingItemImageUrl"
let RANKING_ITEM_TEXT = "rankingItemText"
let RANKING_ITEM_CREATED_DATE = "rankingItemCreatedDate"

// MARK: - Root Reference
let DB_REF = Firestore.firestore()
let STORAGE_REF = Storage.storage().reference()

// MARK: - Database References
let RANKING_REF = DB_REF.collection(RANKING_COLLECTION)

// MARK: - Storage Reference
let STORAGE_RANDINGS_IMAGES_REF = STORAGE_REF.child("rankings_images")
