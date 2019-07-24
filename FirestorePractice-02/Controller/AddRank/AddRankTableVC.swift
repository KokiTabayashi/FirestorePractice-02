//
//  AddRankTableVC.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/22/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class AddRankTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ranking: Ranking!
    var ref: DocumentReference? = nil
    
    let keyboardView: UIView = {
        let view = UIView()
        return view
    } ()
    
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
    
    let addRankingTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        tv.font = UIFont.systemFont(ofSize: 12)
        return tv
    }()
    
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
        view.addSubview(keyboardView)
        keyboardView.anchor(top: tableView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 80, paddingRight: 0, width: 0, height: 250)
        keyboardView.backgroundColor = .white
        
        keyboardView.addSubview(addRankingTextField)
        addRankingTextField.anchor(top: keyboardView.topAnchor, left: keyboardView.leftAnchor, bottom: nil, right: keyboardView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        addRankingTextField.isHidden = false
        
        keyboardView.addSubview(addRankingItemTextField)
        addRankingItemTextField.anchor(top: keyboardView.topAnchor, left: keyboardView.leftAnchor, bottom: nil, right: keyboardView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        addRankingItemTextField.isHidden = true
        
        keyboardView.addSubview(addButton)
        addButton.anchor(top: nil, left: keyboardView.leftAnchor, bottom: keyboardView.bottomAnchor, right: keyboardView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
    }
    
    // MARK: - Handler
    
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
                    self.addRankingTextField.text = ""
                }
            }
        } else {
            guard let rankingItemTitleText = self.addRankingItemTextField.text else { return }
            RANKING_REF.document(ref!.documentID).collection(RANKING_ITEM_COLLECTION).addDocument(data: [
                RANKING_ITEM_TITLE: rankingItemTitleText,
                RANKING_ITEM_IMAGE_URL: "",
                RANKING_ITEM_TEXT: "",
                RANKING_ITEM_CREATED_DATE: FieldValue.serverTimestamp()
                ], completion: { (err) in
                    if let err = err {
                        debugPrint("Error adding document: \(err)")
                    } else {
                        self.addRankingItemTextField.text = ""
                    }
            })
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
