//
//  LoginViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    
    //MARK: UI Variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: UIButton Methods
    @IBAction func loginTapped(_ sender: Any) {
        // loginIn in the user
        loginIn()
    }
    
    //MARK:  Private Methods
    private func loginIn(){
        // Create cleane versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                Utilities.styleTextField(self.emailTextField, color: UIColor.errorColor)
                Utilities.styleTextField(self.passwordTextField, color: UIColor.errorColor)
            }
            else {
                Utilities.styleTextField(self.emailTextField, color: UIColor.color)
                Utilities.styleTextField(self.passwordTextField, color: UIColor.color)
                self.transitionToHome()
            }
        }
    }
    
    private func setUpElements()  {
        //Hide the error label
        errorLabel.alpha = 0
        //style the elements
        Utilities.styleTextField(emailTextField, color: UIColor.color)
        Utilities.styleTextField(passwordTextField, color: UIColor.color)
        Utilities.styleFilledButton(loginButton)
    }
    
    private func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
}
