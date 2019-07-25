//
//  AddRankTableVC.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/22/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class AddRankTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var ranking: Ranking!
    var ref: DocumentReference? = nil
    var imageSelected = false

    let addRankingBaseView: UIView = {
        let view = UIView()
        return view
    } ()
    
    let stackViewBaseView: UIView = {
        let view = UIView()
        return view
    }()
    
    let rankingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Ranking Title"
        return label
    }()
    
    let addRankingTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ranking Title"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        //        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    } ()
    
    let addRankingItemTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ranking Item"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        //        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    } ()
    
    let addRankingItemTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.font = UIFont.systemFont(ofSize: 12)
        return tv
    }()
    
    lazy var addRankingItemImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        let addRankingImageTap = UITapGestureRecognizer(target: self, action: #selector(handleRankingItemImageTapped))
        addRankingImageTap.numberOfTapsRequired = 1
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(addRankingImageTap)
        
        iv.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        return iv
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [addRankingItemImageView, addRankingItemTextView])
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frameWidth = view.frame.width
        let frameHeight = view.frame.height

        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight - 250)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(addRankingBaseView)
        addRankingBaseView.anchor(top: tableView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 80, paddingRight: 0, width: 0, height: 250)
        addRankingBaseView.backgroundColor = .white
        
        addRankingBaseView.addSubview(addRankingTextField)
        addRankingTextField.anchor(top: addRankingBaseView.topAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        addRankingTextField.isHidden = false
        
        addRankingBaseView.addSubview(addRankingItemTextField)
        addRankingItemTextField.anchor(top: addRankingBaseView.topAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        addRankingItemTextField.isHidden = true

//        addRankingBaseView.addSubview(stackViewBaseView)
//        stackViewBaseView.anchor(top: addRankingItemTextField.bottomAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
//        stackViewBaseView.isHidden = true
//        stackViewBaseView.backgroundColor = .lightGray

        stackView.axis = .horizontal
        stackView.distribution = .fill
        addRankingBaseView.addSubview(stackView)
//        stackView.anchor(top: stackViewBaseView.topAnchor, left: stackViewBaseView.leftAnchor, bottom: stackViewBaseView.bottomAnchor, right: stackViewBaseView.rightAnchor, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2, width: 0, height: 0)
        stackView.anchor(top: addRankingItemTextField.bottomAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        stackView.backgroundColor = .blue
        stackView.isHidden = true
        
        addRankingBaseView.addSubview(addButton)
        addButton.anchor(top: stackView.bottomAnchor, left: addRankingBaseView.leftAnchor, bottom: addRankingBaseView.bottomAnchor, right: addRankingBaseView.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
    }
    
    // MARK: - Handler
    
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
        
        addRankingItemImageView.image = rankingImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addButtonTapped() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let rankingTitleText = addRankingTextField.text else { return }
        
        if !(self.addRankingTextField.isHidden) {
            ref = RANKING_REF.addDocument(data: [
                RANKING_TITLE: rankingTitleText,
                RANKING_OWNER_ID: currentUid,
                RANKING_CREATED_DATE: FieldValue.serverTimestamp()
            ]) { (err) in
                if let err = err {
                    debugPrint("Error adding document: \(err)")
                } else {
                    self.addRankingTextField.isHidden = true
                    self.addRankingItemTextField.isHidden = false
                    self.stackView.isHidden = false
                    self.addRankingTextField.text = ""
                }
            }
        } else {
            guard let rankingItemTitleText = self.addRankingItemTextField.text else { return }
            guard let rankingItemText = addRankingItemTextView.text else { return }
            let rankingImage = self.addRankingItemImageView.image ?? UIImage(named: "add_new_post_btn")
            guard let rankingImageUploadData = rankingImage?.jpegData(compressionQuality: 0.5) else { return }
            
            // update storage
            let filename = NSUUID().uuidString
            let storageRef = STORAGE_RANKINGS_IMAGES_REF.child(filename)
            
            storageRef.putData(rankingImageUploadData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Failed to upload image to storage with error: ", error.localizedDescription)
                }
                
                storageRef.downloadURL(completion: { (url, error) in
                    guard let profileImageUrl = url?.absoluteString else {
                        print("DEBUG: Profile image url is nil")
                        return
                    }
                    RANKING_REF.document(self.ref!.documentID).collection(RANKING_ITEM_COLLECTION).addDocument(data: [
                        RANKING_ITEM_TITLE: rankingItemTitleText,
                        RANKING_ITEM_IMAGE_URL: profileImageUrl,
                        RANKING_ITEM_TEXT: rankingItemText,
                        RANKING_ITEM_CREATED_DATE: FieldValue.serverTimestamp()
                        ], completion: { (err) in
                            if let err = err {
                                debugPrint("Error adding document: \(err)")
                            } else {
                                self.addRankingItemTextField.text = ""
                                self.addRankingItemTextView.text = ""
                                self.addRankingItemImageView.image = nil
                            }
                    })
                })
            }
        }
    }
    
    // MARK: -  UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
}
