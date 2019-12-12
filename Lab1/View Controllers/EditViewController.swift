//
//  EditViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage


final class EditViewController: UIViewController {

    //MARK: UI Variables
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userPhoneField: UITextField!
    @IBOutlet private weak var userNameField: UITextField!
    
    //MARK:  Variables
    private var imagePicker: ImagePicker!
   
    //MARK: Button Methods
    @IBAction func changePhoto(_ sender: UIButton) {
        imagePicker.present(from: sender)
        uploadProfileImage()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        changeUserInfo()
        uploadProfileImage()
    }
    
    //MARK: Private Methods
    private func uploadProfileImage() {
        guard let currentImage = userImage.image else { return }
        guard let imageData = currentImage.jpegData(compressionQuality: 0.5) else { return }
        guard let user = Auth.auth().currentUser else { return }
        let storage = Storage.storage().reference(forURL: "gs://labonswift.appspot.com")
        let profileReference = storage.child("profile").child(user.uid)
        let data = StorageMetadata()
        data.contentType = "image/jpg"
        profileReference.putData(imageData, metadata: data) { (data, error) in
            if let err = error {
                print(err.localizedDescription)
            }
        }
    }
    
    private func changeUserInfo() {
        guard let request = Auth.auth().currentUser?.createProfileChangeRequest() else { return }
        guard let user = Auth.auth().currentUser else { return }
        guard let userNameText = userNameField.text else { return }
        guard let userEmailText = userPhoneField.text else { return }
        if !userNameText.isEmpty && !userEmailText.isEmpty {
            request.displayName = userNameText
            user.updateEmail(to: userEmailText) { error in
                if let err = error { print(err.localizedDescription) }
            }
            request.commitChanges(completion: nil)
            self.showAlertMessageWithTitleOkButton("You change it")
        }
    }
    
    private func getUserPhoto(){
        guard let user = Auth.auth().currentUser else { return }
        let storageRef = Storage.storage().reference(forURL: "gs://labonswift.appspot.com")
        let storageProfileRef = storageRef.child("profile").child(user.uid)
        storageProfileRef.downloadURL { (url, error) in
            if let metaImageUrl = url {
                self.userImage.sd_setImage(with: metaImageUrl, placeholderImage: nil)
               } else {
            }
        }
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        getUserPhoto()
    }
}

extension EditViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.userImage.image = image
    }
}
