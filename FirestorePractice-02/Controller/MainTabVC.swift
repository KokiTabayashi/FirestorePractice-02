//
//  MainVC.swift
//  FirestorePractice-02
//
//  Created by Koki Tabayashi on 7/10/19.
//  Copyright © 2019 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // delegate
        self.delegate = self
        
        // configure view controllers
        configureViewControllers()
        
        // user validation
        checkIfUserIsLoggedIn()
    }
    
    func configureViewControllers() {
        
        // home feed controller
        let homeFeedVC = constructNavController(unselectedImage: UIImage(named: "stories_deselected_icon")!, selectedImage: UIImage(named: "stories_selected_icon")!, rootViewController: HomeFeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // search rank controller
        let searchRankVC = constructNavController(unselectedImage: UIImage(named: "searchbutton_deselected")!, selectedImage: UIImage(named: "searchbutton_selected")!, rootViewController: SearchRankVC())
        
        // add rank controller
//        let addRankVC = constructNavController(unselectedImage: UIImage(named: "add_button_deselected")!, selectedImage: UIImage(named: "add_button_selected")!, rootViewController: AddRankVC())
        let addRankTableVC = constructNavController(unselectedImage: UIImage(named: "add_button_deselected")!, selectedImage: UIImage(named: "add_button_selected")!, rootViewController: AddRankTableVC())
        
        // notification controller
        let notificationVC = constructNavController(unselectedImage: UIImage(named: "notifications_deselected")!, selectedImage: UIImage(named: "notifications_selected")!, rootViewController: NotificationVC())
        
        // profile controller
        let profileVC = constructNavController(unselectedImage: UIImage(named: "profile_deselected")!, selectedImage: UIImage(named: "profile_selected")!, rootViewController: UserProfileVC())
//        let profileVC = constructNavController(unselectedImage: UIImage(named: "profile_deselected")!, selectedImage: UIImage(named: "profile_selected")!, rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // view controller to be added to tab controller
//        viewControllers = [homeFeedVC, searchRankVC, addRankVC, notificationVC, profileVC]
        viewControllers = [homeFeedVC, searchRankVC, addRankTableVC, notificationVC, profileVC]
        
        // tab bar tint color
        tabBar.tintColor = .black
    }
    
    // construct navigation controllers
    func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // construct nav controller
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        // return nav controller
        return navController
    }
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                // present login controller
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
    }
}
