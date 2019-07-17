//
//  AddRankVC.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/11/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase


class AddRankVC: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    enum UploadAction: Int {
        case UploadPost
        case SaveChanges
        
        init(index: Int) {
            switch index {
            case 0: self = .UploadPost
            case 1: self = .SaveChanges
            default: self = .UploadPost
            }
        }
    }
    
    var uploadAction: UploadAction!
    var selectedImage: UIImage?
    var ranking: Ranking!
    var rankingToEdit: Ranking?
    var imageSelected = false
    
    // MARK: - Outlets
    
    let rankingTitleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ranking Title"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    } ()
    
    let rankingNumberOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Number 1:"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        return label
    } ()
    
    let rankingNumberTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "Number 2:"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        return label
    } ()
    
    let rankingNumberThreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Number 3:"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        return label
    } ()
    
    let rankingNumberOneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ranking Item Number 1"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    } ()
    
    let rankingNumberTwoTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ranking Item Number 2"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    } ()
    
    let rankingNumberThreeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ranking Item Number 3"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    } ()
    
    lazy var rankingImageViewOne: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        let rankingImageTap = UITapGestureRecognizer(target: self, action: #selector(handleRankingItemImageTapped))
        rankingImageTap.numberOfTapsRequired = 1
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(rankingImageTap)
        
        return iv
    }()
    
    lazy var rankingImageViewTwo: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        let rankingImageTap = UITapGestureRecognizer(target: self, action: #selector(handleRankingItemImageTapped))
        rankingImageTap.numberOfTapsRequired = 1
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(rankingImageTap)
        
        return iv
    }()
    
    lazy var rankingImageViewThree: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        let rankingImageTap = UITapGestureRecognizer(target: self, action: #selector(handleRankingItemImageTapped))
        rankingImageTap.numberOfTapsRequired = 1
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(rankingImageTap)
        
        return iv
    }()
    
    let captionTextViewOne: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.font = UIFont.systemFont(ofSize: 12)
        return tv
    }()
    
    let captionTextViewTwo: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.font = UIFont.systemFont(ofSize: 12)
        return tv
    }()
    
    let captionTextViewThree: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.font = UIFont.systemFont(ofSize: 12)
        return tv
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleUploadAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate to hide keyboard when it finished editing
        rankingTitleTextField.delegate = self
        rankingNumberOneTextField.delegate = self
        rankingNumberTwoTextField.delegate = self
        rankingNumberThreeTextField.delegate = self
        
        // configure view components
        configureViewComponents()
//
//        // load image
//        loadImage()
        
        // text view delegate
        captionTextViewOne.delegate = self
        captionTextViewTwo.delegate = self
        captionTextViewThree.delegate = self
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if uploadAction == .SaveChanges {
//            guard let ranking = self.rankingToEdit else { return }
//            actionButton.setTitle("Save Changes", for: .normal)
//            self.navigationItem.title = "Edit Post"
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
//            navigationController?.navigationBar.tintColor = .black
//            photoImageView.loadImage(with: ranking.imageUrl)
//            captionTextView.text = ranking.caption
//        } else {
//            actionButton.setTitle("Share", for: .normal)
//            self.navigationItem.title = "Upload Post"
//        }
    }
    
    // MARK: - UITextView
    
    func textViewDidChange(_ textView: UITextView) {
        
        guard !textView.text.isEmpty else {
            
            actionButton.isEnabled = false
            actionButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            
            return
        }
        
        actionButton.isEnabled = true
        actionButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    // MARK: - Handlers
    
    @objc func handleRankingItemImageTapped() {
        // configure image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // present image picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // selected image
        guard let rankingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        
        // set imageSelected to true
        imageSelected = true
        
        // configure plusPhotoBtn with selected image
        //        plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
        //        plusPhotoBtn.layer.masksToBounds = true
        //        plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
        //        plusPhotoBtn.layer.borderWidth = 2
        //        rankingImageViewOne.setImage(rankingImage.withRenderingMode(.alwaysOriginal), for: .normal)
        rankingImageViewOne.image = rankingImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        rankingTitleTextField.resignFirstResponder()
        rankingNumberOneTextField.resignFirstResponder()
        rankingNumberTwoTextField.resignFirstResponder()
        rankingNumberThreeTextField.resignFirstResponder()
        return true
    }
    
    @objc func formValidation() {
        guard
            rankingTitleTextField.hasText == true
            else {
                actionButton.isEnabled = false
                actionButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
                return
        }
        
        actionButton.isEnabled = true
        actionButton.backgroundColor = UIColor.rgb(red: 17, green: 144, blue: 237)
    }
    
//    func updateUserFeeds(with postId: String) {
//
//        // current user id
//        guard let currentUid = Auth.auth().currentUser?.uid else { return }
//
//        // database values
//        let values = [postId: 1]
//
//        // update follower feeds
//        USER_FOLLOWER_REF.child(currentUid).observe(.childAdded) { (snapshot) in
//            let followerUid = snapshot.key
//            USER_FEED_REF.child(followerUid).updateChildValues(values)
//        }
//
//        // update current user feed
//        USER_FEED_REF.child(currentUid).updateChildValues(values)
//    }
    
    @objc func handleUploadAction() {
        print("handleUploadAction")
        handleUploadPost()
//        buttonSelector(uploadAction: uploadAction)
    }
//
//    @objc func handleCancel() {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func buttonSelector(uploadAction: UploadAction) {
//
//        switch uploadAction {
//        case .UploadPost:
//            handleUploadPost()
//        case .SaveChanges:
////            handleSavePostChanges()
//            return
//        }
//    }
//
//    func handleSavePostChanges() {
//        guard let post = self.rankingToEdit else { return }
//        guard let postKey = post.postId else { return }
//        let updatedCaption = captionTextView.text
//
////        uploadHashtagToServer(withPostId: postKey)
//
//        POSTS_REF.child(postKey).child("caption").setValue(updatedCaption) { (err, ref) in
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//
    func handleUploadPost() {
        print("handleUploadPost")
        // parameters
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let rankingTitle = rankingTitleTextField.text else { return }
        
        let rankingNumberOneText = rankingNumberOneTextField.text ?? "no data"
        let rankingNumberTwoText = rankingNumberTwoTextField.text ?? "no data"
        let rankingNumberThreeText = rankingNumberThreeTextField.text ?? "no data"
        let captionOne = captionTextViewOne.text ?? "no data"
        let captionTwo = captionTextViewTwo.text ?? "no data"
        let captionThree = captionTextViewThree.text ?? "no data"
        let rankingImageOne = rankingImageViewOne.image ?? UIImage(named: "add_new_post_btn")!
        let rankingImageTwo = rankingImageViewTwo.image ?? UIImage(named: "add_new_post_btn")!
        let rankingImageThree = rankingImageViewThree.image ?? UIImage(named: "add_new_post_btn")!
        
        guard let rankingImageUploadDataOne = rankingImageOne.jpegData(compressionQuality: 0.5) else { return }
        guard let rankingImageUploadDataTwo = rankingImageTwo.jpegData(compressionQuality: 0.5) else { return }
        guard let rankingImageUploadDataThree = rankingImageThree.jpegData(compressionQuality: 0.5) else { return }
        
        // update storage
        let filenameOne = NSUUID().uuidString
        let storageRefOne = STORAGE_RANDINGS_IMAGES_REF.child(filenameOne)
        
        let filenameTwo = NSUUID().uuidString
        let storageRefTwo = STORAGE_RANDINGS_IMAGES_REF.child(filenameTwo)
        
        let filenameThree = NSUUID().uuidString
        let storageRefThree = STORAGE_RANDINGS_IMAGES_REF.child(filenameThree)
        
        var ref: DocumentReference? = nil
        
        // update ranking title
        ref = RANKING_REF.addDocument(data: [
            RANKING_TITLE: rankingTitle,
            RANKING_OWNER_ID: currentUid,
            RANKING_CREATED_DATE: FieldValue.serverTimestamp()
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
                
                // update image One
                storageRefOne.putData(rankingImageUploadDataOne, metadata: nil) { (metadata, error) in
                    
                    if let error = error {
                        print("Failed to upload image to storage with error: ", error.localizedDescription)
                    }
                    
                    storageRefOne.downloadURL(completion: { (url, error) in
                        // test
                        guard let profileImageUrl = url?.absoluteString else {
                            print("DEBUG: Profile image url is nil")
                            return
                        }
                        
                        RANKING_REF.document(ref!.documentID).collection(RANKING_ITEM_COLLECTION).addDocument(data: [
                            RANKING_ITEM_TITLE: rankingNumberOneText,
                            RANKING_ITEM_IMAGE_URL: profileImageUrl,
                            RANKING_ITEM_TEXT: captionOne,
                            RANKING_ITEM_CREATED_DATE: FieldValue.serverTimestamp()
                            ], completion: { (err) in
                                if let err = err {
                                    debugPrint("Error adding document: \(err)")
                                } else {
                                    print("Item One Updated")
                                }
                        })
                    })
                }
                
                // update image Two
                storageRefTwo.putData(rankingImageUploadDataTwo, metadata: nil) { (metadata, error) in
                    
                    if let error = error {
                        print("Failed to upload image to storage with error: ", error.localizedDescription)
                    }
                    
                    storageRefTwo.downloadURL(completion: { (url, error) in
                        // test
                        guard let profileImageUrl = url?.absoluteString else {
                            print("DEBUG: Profile image url is nil")
                            return
                        }
                        
                        RANKING_REF.document(ref!.documentID).collection(RANKING_ITEM_COLLECTION).addDocument(data: [
                            RANKING_ITEM_TITLE: rankingNumberTwoText,
                            RANKING_ITEM_IMAGE_URL: profileImageUrl,
                            RANKING_ITEM_TEXT: captionTwo,
                            RANKING_ITEM_CREATED_DATE: FieldValue.serverTimestamp()
                            ], completion: { (err) in
                                if let err = err {
                                    debugPrint("Error adding document: \(err)")
                                } else {
                                    print("Item Two Updated")
                                }
                        })
                    })
                }
                
                // update image Three
                storageRefThree.putData(rankingImageUploadDataThree, metadata: nil) { (metadata, error) in
                    
                    if let error = error {
                        print("Failed to upload image to storage with error: ", error.localizedDescription)
                    }
                    
                    storageRefThree.downloadURL(completion: { (url, error) in
                        // test
                        guard let profileImageUrl = url?.absoluteString else {
                            print("DEBUG: Profile image url is nil")
                            return
                        }
                        
                        RANKING_REF.document(ref!.documentID).collection(RANKING_ITEM_COLLECTION).addDocument(data: [
                            RANKING_ITEM_TITLE: rankingNumberThreeText,
                            RANKING_ITEM_IMAGE_URL: profileImageUrl,
                            RANKING_ITEM_TEXT: captionThree,
                            RANKING_ITEM_CREATED_DATE: FieldValue.serverTimestamp()
                            ], completion: { (err) in
                                if let err = err {
                                    debugPrint("Error adding document: \(err)")
                                } else {
                                    print("Item One Updated")
                                }
                        })
                    })
                }
                
                self.rankingTitleTextField.text = ""
                self.rankingNumberOneTextField.text = ""
                self.rankingNumberTwoTextField.text = ""
                self.rankingNumberThreeTextField.text = ""
                self.captionTextViewOne.text = ""
                self.captionTextViewTwo.text = ""
                self.captionTextViewThree.text = ""
                self.rankingImageViewOne.image = nil
                self.rankingImageViewOne.image = nil
                self.rankingImageViewOne.image = nil
                print("Database Successfully Updated")
            }
        }
    }

    func configureViewComponents() {
        
        view.addSubview(rankingTitleTextField)
        rankingTitleTextField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 72, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        let rankingNumberOneStackView = UIStackView(arrangedSubviews: [rankingNumberOneLabel, rankingNumberOneTextField])
        rankingNumberOneStackView.axis = .horizontal
        rankingNumberOneStackView.distribution = .fill
        rankingNumberOneStackView.spacing = 2
        view.addSubview(rankingNumberOneStackView)
        rankingNumberOneStackView.anchor(top: rankingTitleTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(rankingImageViewOne)
        rankingImageViewOne.anchor(top: rankingNumberOneStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        view.addSubview(captionTextViewOne)
        captionTextViewOne.anchor(top: rankingNumberOneStackView.bottomAnchor, left: rankingImageViewOne.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 100)
        
        let rankingNumberTwoStackView = UIStackView(arrangedSubviews: [rankingNumberTwoLabel, rankingNumberTwoTextField])
        rankingNumberTwoStackView.axis = .horizontal
        rankingNumberTwoStackView.distribution = .fill
        rankingNumberTwoStackView.spacing = 2
        view.addSubview(rankingNumberTwoStackView)
        rankingNumberTwoStackView.anchor(top: rankingImageViewOne.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(rankingImageViewTwo)
        rankingImageViewTwo.anchor(top: rankingNumberTwoStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        view.addSubview(captionTextViewTwo)
        captionTextViewTwo.anchor(top: rankingNumberTwoStackView.bottomAnchor, left: rankingImageViewTwo.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 100)
        
        let rankingNumberThreeStackView = UIStackView(arrangedSubviews: [rankingNumberThreeLabel, rankingNumberThreeTextField])
        rankingNumberThreeStackView.axis = .horizontal
        rankingNumberThreeStackView.distribution = .fill
        rankingNumberThreeStackView.spacing = 2
        view.addSubview(rankingNumberThreeStackView)
        rankingNumberThreeStackView.anchor(top: rankingImageViewTwo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        view.addSubview(rankingImageViewThree)
        rankingImageViewThree.anchor(top: rankingNumberThreeStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        view.addSubview(captionTextViewThree)
        captionTextViewThree.anchor(top: rankingNumberThreeStackView.bottomAnchor, left: rankingImageViewThree.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 100)

        view.addSubview(actionButton)
        actionButton.anchor(top: rankingImageViewThree.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 40)
    }
//
//    func loadImage() {
//
//        guard let selectedImage = self.selectedImage else { return }
//
//        photoImageView.image = selectedImage
//    }
    
    // MARK: - API
    
//    func uploadHashtagToServer(withPostId postId: String) {
//
//        guard let caption = captionTextView.text else { return }
//
//        let words: [String] = caption.components(separatedBy: .whitespacesAndNewlines)
//
//        for var word in words {
//
//            if word.hasPrefix("#") {
//                word = word.trimmingCharacters(in: .punctuationCharacters)
//                word = word.trimmingCharacters(in: .symbols)
//
//                let hashtagValues = [postId: 1]
//
//                HASHTAG_POST_REF.child(word.lowercased()).updateChildValues(hashtagValues)
//            }
//        }
//    }
}
