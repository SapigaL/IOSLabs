//
//  ViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
    }
    private func setUpElements()  {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(exitButton)
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func xitButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
       navigationController?.pushViewController(vc, animated: true)
    
    }
}


