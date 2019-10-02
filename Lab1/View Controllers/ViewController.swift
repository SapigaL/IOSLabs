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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
    }
    private func setUpElements()  {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    @IBAction func backButton(_ sender: Any) {
        exit(0)
        
    }
}

