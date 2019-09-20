//
//  SingUpViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SingUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    static var idUser: String = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

    }
    func setUpElements()  {
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(name)
        Utilities.styleTextField(number)
        Utilities.styleTextField(email)
        Utilities.styleTextField(password)
        Utilities.styleFilledButton(signUpButton)


    }
    
    // Check the fields
    func validateFields() -> String? {
        var checkingErrors = 0
        let correctNumber = number.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let correctEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Check name field
        if  name.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        { Utilities.errorStyleTextField(name)
            checkingErrors+=1
        }
        else{
            Utilities.styleTextField(name)
            
        }
        // Check number field
        
        if   Utilities.isnubmerValid(currectNumber) == false {
            Utilities.errorStyleTextField(number)
             checkingErrors+=1
            
        }
        else{
            Utilities.styleTextField(number)
            
        }
        // Check email field
        if  Utilities.isValidEmail(currectEmail) == false {
            Utilities.errorStyleTextField(email)
            checkingErrors+=1
           
        }
        else {
            Utilities.styleTextField(email)
        }
    
        // Check if the password is secure
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password bad
            Utilities.errorStyleTextField(password)
            checkingErrors+=1
        } else {
             Utilities.styleTextField(password)
        }
        // Check on an error
        if checkingErrors > 0 {
            return "Please fill correct fields"
        }
        else{
              return nil
        }
    }


    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            // Show error massage
            showError(error!)
        }
        else{
            // Create cleaned versions of the data
            let dbName = name.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dbNumber = number.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dbEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dbPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            SingUpViewController.idUser = dbName
            // Create the user
            
           Auth.auth().createUser(withEmail: dbEmail, password: dbPassword) { (result, err) in
                
                // Check for errors
                if  err != nil {
                    self.showError("Error creating user")
                }
                else{
                    // Initialize an instance of Cloud Firestore
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["name":dbName, "number":dbNumber, "uid": result!.user.uid]) { (error) in
                        
                        
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                     // Transition to the home screen
                    self.transitionToHome()
                }
            }
           
        }
       
    }
    
    func transitionToHome() {
        
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func showError(_ massage:String) {
        errorLabel.text = massage
        errorLabel.alpha = 1
    }
}
