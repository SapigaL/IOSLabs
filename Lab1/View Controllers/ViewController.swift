//
//  ViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import FirebaseAuth

final class ViewController: UIViewController {
    
    //MARK: UI Variables
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    //MARK: UIButton Methods
    @IBAction func exitButton(_ sender: Any) {
        let auth = Auth.auth()
    }
    
    @IBAction func xitButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
       navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:  Private Methods
    private func setUpElements()  {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(exitButton)
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
}


