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
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
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
                self.errorLabel.isHidden = false
                Utilities.styleTextField(self.emailTextField, color: UIColor.errorColor, textLabel: self.errorEmailLabel, labelcolor: UIColor.errorColor, errorText: Constants.ErrorText.errorTextLogin[0], labelHide: false)
                Utilities.styleTextField(self.passwordTextField, color: UIColor.errorColor, textLabel: self.errorPasswordLabel, labelcolor: UIColor.errorColor, errorText: Constants.ErrorText.errorTextLogin[1], labelHide: false)
            }
            else {
                Utilities.styleTextField(self.emailTextField, color: UIColor.color, textLabel: self.errorEmailLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorTextLogin[0], labelHide: true)
                Utilities.styleTextField(self.passwordTextField, color: UIColor.color, textLabel: self.errorPasswordLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorTextLogin[1], labelHide: true)
                 self.transitionToHome()
            }
        }
    }

    private func setUpElements()  {
        //Hide the error label
        errorLabel.alpha = 0
        //style the elements
        errorLabel.isHidden = true // hide
       
        Utilities.styleTextField(emailTextField, color: UIColor.color, textLabel: errorEmailLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorTextLogin[1], labelHide: true)
        Utilities.styleTextField(passwordTextField, color: UIColor.color, textLabel: errorPasswordLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorTextLogin[1], labelHide: true)
        Utilities.styleFilledButton(loginButton)
    }
    
    private func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    private func clearStack(){
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        if (navigationArray.count>2){
        navigationArray.remove(at: 1) // To remove previous UIViewController
        }
        self.navigationController?.viewControllers = navigationArray
    }
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = false
        setUpElements()
        clearStack()
    }
    
}
