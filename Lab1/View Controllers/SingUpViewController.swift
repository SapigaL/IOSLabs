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

final class SingUpViewController: UIViewController, UITextFieldDelegate {
    //MARK: UI Variables
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorNumberLabel: UILabel!
    @IBOutlet weak var errorNameLabel: UILabel!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    //MARK:  Variables
    var checkingErrors  :Int = 0
    var errorLabelList = [UILabel]()
    var FieldList  = [UITextField]()
    var textFieldList = [String]()
    let patterns = [ "^[A-Za-z]{1,10}$",
                     "^(0)[0-9]{6,14}$",
                     
                     "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
                     "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"]
    
    let errorText = ["Uncorrect Name","Uncorrect Number","Uncorrect Email","Uncorrect Password"]
    
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
         FieldList = [nameField,numberField,emailField,passwordField]
        //Hide the error label
        errorLabel.alpha = 0
//        for field in 0...3 {
//             Utilities.styleTextField(FieldList[field], color: UIColor.color, textLabel: errorNameLabel, labelcolor: UIColor.successColor, errorText: errorText[field], labelHide: true)
//        }
        Utilities.styleTextField(nameField, color: UIColor.color, textLabel: errorNameLabel, labelcolor: UIColor.successColor, errorText: errorText[1], labelHide: true)
        Utilities.styleTextField(numberField, color: UIColor.color, textLabel: errorNumberLabel, labelcolor: UIColor.successColor, errorText: errorText[1], labelHide: true)
        Utilities.styleTextField(emailField, color: UIColor.color, textLabel: errorEmailLabel, labelcolor: UIColor.successColor, errorText: errorText[1], labelHide: true)
        Utilities.styleTextField(passwordField, color: UIColor.color, textLabel: errorPasswordLabel, labelcolor: UIColor.successColor, errorText: errorText[1], labelHide: true)
        Utilities.styleFilledButton(signUpButton)
        
        
    }
    private func patern(fied: UITextField,index: Int) -> Bool {
        
        let patern = NSPredicate(format: "SELF MATCHES %@",patterns[index])
        return patern.evaluate(with: fied.text!.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    // Check the fields
    private func validateFields() -> String? {
         checkingErrors = 0

       
        errorLabelList = [ errorNameLabel,errorNumberLabel,errorEmailLabel,errorPasswordLabel]
        
        
        for i in 0...3 {
            
            if  patern(fied: FieldList[i],index: i){
                Utilities.styleTextField(FieldList[i], color: UIColor.color,textLabel: errorLabelList[i], labelcolor: UIColor.successColor, errorText: errorText[i], labelHide: true)
            }
            else{
                checkingErrors=checkingErrors+1
                print(checkingErrors)
                Utilities.styleTextField(FieldList[i], color: UIColor.errorColor, textLabel: errorLabelList[i], labelcolor: UIColor.errorColor, errorText: errorText[i], labelHide: false)
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
