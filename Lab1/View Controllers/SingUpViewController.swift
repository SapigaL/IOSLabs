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
    //MARK: UI Variables
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK:  Variables
    var FieldList  = [UITextField]()
    var textFieldList = [String]()
    let patterns = [ "^[A-Za-z]{1,10}$",
                     "^(0)[0-9]{6,14}$",
                     "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}",
                     "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" ]
    
    //MARK: Button Methods
    @IBAction func signUpTapped(_ sender: Any) {
        //  connectDb();
        
        // Validate the fields
        let error = validateFields()
        
        if (error?.isEmpty==false) {
            // Show error massage
            showError(error!)
        }
        else{
            singUpFirebase()
        }
    }
    
    //MARK: Private Methods
    private func setUpElements()  {
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(nameField, color: UIColor.color)
        Utilities.styleTextField(numberField, color: UIColor.color)
        Utilities.styleTextField(emailField, color: UIColor.color)
        Utilities.styleTextField(passwordField, color: UIColor.color)
        Utilities.styleFilledButton(signUpButton)
        
        
    }
    private func patern(fied: String,index: Int) -> Bool {
        
        let patern = NSPredicate(format: "SELF MATCHES %@",patterns[index])
        return patern.evaluate(with: fied)
    }
    // Check the fields
    private func validateFields() -> String? {
        var checkingErrors = 0
        let correctName = nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let correctNumber = numberField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let correctEmail = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Check name field
        FieldList = [nameField,numberField,passwordField,emailField]
        textFieldList = [correctName,correctNumber,cleanedPassword,correctEmail]
        
        for i in 0...3 {
            checkingErrors=0
            if  patern(fied: textFieldList[i],index: i){
                Utilities.styleTextField(FieldList[i], color: UIColor.color)
            }
            else{
                
                Utilities.styleTextField(FieldList[i], color: UIColor.errorColor)
            }
        }
        
        if checkingErrors > 0 {
            return "Please fill correct fields"
        }
        else{
            return nil
        }
    }
    
    private func singUpFirebase()  {
        // Create cleaned versions of the data
        let nameUser = nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailUser = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordUser = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // Create the user
        
        Auth.auth().createUser(withEmail: emailUser, password: passwordUser) { (result, err) in
            
            // Check for errors
            if  err != nil {
                self.showError("Error creating user")
            }
            else{
                self.performSegue(withIdentifier: "loginViewController", sender: self)
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = nameUser
                changeRequest?.commitChanges(completion: nil)
                guard let name = result?.user.displayName else {return}
            }
        }
    }
    
    
    private  func showError(_ massage:String) {
        errorLabel.text = massage
        errorLabel.alpha = 1
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
}
