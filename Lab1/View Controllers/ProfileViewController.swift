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

    //MARK: - Views
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
    //MARK: UIButton Methods
    @IBAction func editButton(_ sender: Any) {
        transitionToEditView()
    }

    //MARK: - lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupVC()
    }
    
    //MARK: - Private Methods
    private func setupVC() {
        guard let user = Auth.auth().currentUser else { return }
        let storageRef = Storage.storage().reference(forURL: "gs://labonswift.appspot.com")
        let storageProfileRef = storageRef.child("profile").child(user.uid)
        storageProfileRef.downloadURL { (url, error) in
            if let metaImageUrl = url {
                self.userImage.sd_setImage(with: metaImageUrl, placeholderImage: nil)
            } else {
                self.userImage.sd_setImage(with: user.photoURL, placeholderImage: UIImage(named: "Profile"))
            }
        }
        userName.text = user.displayName
        userPhone.text = user.email
    }
    
    private func transitionToEditView() {
           let st = UIStoryboard(name: "Main", bundle: nil)
           guard let viewController = st.instantiateViewController(withIdentifier: "EditVC") as? EditViewController else { return }
           viewController.modalPresentationStyle = .fullScreen 
           navigationController?.pushViewController(viewController, animated: true)
       }
}
