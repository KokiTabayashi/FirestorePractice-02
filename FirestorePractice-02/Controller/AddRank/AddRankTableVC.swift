//
//  AddRankTableVC.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/22/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class AddRankTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    var ranking: Ranking!
    var rankingItems = [RankingItem]()
    var ref: DocumentReference? = nil
    var imageSelected = false
    let reuseIdentifier = "TableCell"
    
    // listener
    var listener : ListenerRegistration!
    
    let tableView = UITableView()
    
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
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Let's add new ranking!"
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
        
        configureView()
        
        // hide keyboard when enter is pushed
        view.bindToKeyboard()
        
        configureNavigationButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - Handler
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        addRankingBaseView.endEditing(true)
//    }
    
    func configureNavigationButtons() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addRankingTextField.resignFirstResponder()
        addRankingItemTextField.resignFirstResponder()
        return true
    }
    
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
        addButton.isEnabled = false
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let rankingTitleText = addRankingTextField.text else { return }
        let rankingCreatedDate = FieldValue.serverTimestamp()
        
        if !(self.addRankingTextField.isHidden) {
            ref = RANKING_REF.addDocument(data: [
                RANKING_TITLE: rankingTitleText,
                RANKING_OWNER_ID: currentUid,
                RANKING_CREATED_DATE: rankingCreatedDate
            ]) { (err) in
                if let err = err {
                    debugPrint("Error adding document: \(err)")
                } else {
                    self.addRankingTextField.isHidden = true
                    self.addRankingItemTextField.isHidden = false
                    self.stackView.isHidden = false
                    self.addRankingTextField.text = ""
                    self.addRankingBaseView.endEditing(true)
                    self.ranking = Ranking(rankingOwnerId: currentUid, rankingTitle: rankingTitleText, rankingCreatedDate: (rankingCreatedDate as? Timestamp)?.dateValue() ?? Date(), rankingItems: self.rankingItems)
                    self.rankingTitleLabel.text = rankingTitleText
                    self.addButton.isEnabled = true
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
                    guard let rankingItemImageUrl = url?.absoluteString else {
                        print("DEBUG: Profile image url is nil")
                        return
                    }
                    RANKING_REF.document(self.ref!.documentID).collection(RANKING_ITEM_COLLECTION).addDocument(data: [
                        RANKING_ITEM_TITLE: rankingItemTitleText,
                        RANKING_ITEM_IMAGE_URL: rankingItemImageUrl,
                        RANKING_ITEM_TEXT: rankingItemText,
                        RANKING_ITEM_CREATED_DATE: FieldValue.serverTimestamp()
                        ], completion: { (err) in
                            if let err = err {
                                debugPrint("Error adding document: \(err)")
                            } else {
                                self.addRankingItemTextField.text = ""
                                self.addRankingItemTextView.text = ""
                                self.addRankingItemImageView.image = nil
                                self.addRankingBaseView.endEditing(true)
                                let newRankingItem = RankingItem(rankingItemTitle: rankingItemTitleText, rankingItemText: rankingItemText, rankingItemImageUrl: rankingItemImageUrl, rankingItemId: self.ref!.documentID)
                                self.rankingItems.append(newRankingItem)
                                self.ranking = Ranking(rankingOwnerId: self.ranking.rankingOwnerId, rankingTitle: self.ranking.rankingTitle, rankingCreatedDate: self.ranking.rankingCreatedDate, rankingItems: self.rankingItems)
                                self.addButton.isEnabled = true
                            }
                            self.tableView.reloadData()
                    })
                })
            }
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        let frameWidth = view.frame.width
        let frameHeight = view.frame.height
        
        addRankingTextField.delegate = self
        addRankingItemTextField.delegate = self
        
        view.addSubview(rankingTitleLabel)
        rankingTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 30)
        
        // tableView
        tableView.frame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight - 150)
//        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RankingCell.self, forCellReuseIdentifier: reuseIdentifier)
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 600
        tableView.estimatedRowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // test
        tableView.anchor(top: rankingTitleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(addRankingBaseView)
        addRankingBaseView.anchor(top: tableView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        addRankingBaseView.backgroundColor = .white
        
        addRankingBaseView.addSubview(addRankingTextField)
        addRankingTextField.anchor(top: addRankingBaseView.topAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 84, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
//        addRankingTextField.anchor(top: addRankingBaseView.topAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        addRankingTextField.isHidden = false
        
        addRankingBaseView.addSubview(addRankingItemTextField)
        addRankingItemTextField.anchor(top: addRankingBaseView.topAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        addRankingItemTextField.isHidden = true
        
        //        addRankingBaseView.addSubview(stackViewBaseView)
        //        stackViewBaseView.anchor(top: addRankingItemTextField.bottomAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        //        stackViewBaseView.isHidden = true
        //        stackViewBaseView.backgroundColor = .lightGray
        
        // stackView
        stackView.axis = .horizontal
        stackView.distribution = .fill
        addRankingBaseView.addSubview(stackView)
        //        stackView.anchor(top: stackViewBaseView.topAnchor, left: stackViewBaseView.leftAnchor, bottom: stackViewBaseView.bottomAnchor, right: stackViewBaseView.rightAnchor, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2, width: 0, height: 0)
        stackView.anchor(top: addRankingItemTextField.bottomAnchor, left: addRankingBaseView.leftAnchor, bottom: nil, right: addRankingBaseView.rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        stackView.backgroundColor = .blue
        stackView.isHidden = true
        
        addRankingBaseView.addSubview(addButton)
        addButton.anchor(top: stackView.bottomAnchor, left: addRankingBaseView.leftAnchor, bottom: addRankingBaseView.bottomAnchor, right: addRankingBaseView.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 50)
    }
    
    // MARK: -  UITableView
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if rankingItems.count > 0 {
            return rankingItems.count
//        }
//        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if rankingItems.count > 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? RankingCell {
                print("*** DEBUG *** ranking Items.count: \(rankingItems.count)")
                print("*** DEBUG *** indexPath.row: \(indexPath.row)")
                cell.rankingItem = self.rankingItems[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
}
