//
//  HomeViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import Firebase

final class HomeViewController: UIViewController {
    //MARK: UI Variables
    @IBOutlet weak var welcomeUser: UILabel!
    
    //MARK: UIButton Methods
    @IBAction func backButtom(_ sender: Any) {
        exit(0)
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = Auth.auth().currentUser?.displayName
        welcomeUser.text = "Welcome, \(currentUser!) "
    }
    
    
    
    
    
}
