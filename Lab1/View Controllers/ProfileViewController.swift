//
//  ProfileViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseStorage

final class ProfileViewController: UIViewController {

    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        guard let user = Auth.auth().currentUser else { return }
        userName.text = user.displayName
        userPhone.text = user.email
        userImage.sd_setImage(with: user.photoURL, placeholderImage: UIImage(named: "Profile"))
    }
    
}
