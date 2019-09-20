//
//  HomeViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeUser: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeUser.text = "Welcome, " + SingUpViewController.idUser + LoginViewController.idUser
    }
    

    
    @IBAction func backButtom(_ sender: Any) {
        exit(0)
    }
    

}
