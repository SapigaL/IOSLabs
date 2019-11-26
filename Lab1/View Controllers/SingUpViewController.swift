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
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var numberField: UITextField!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorNumberLabel: UILabel!
    @IBOutlet private weak var errorNameLabel: UILabel!
    @IBOutlet private weak var errorEmailLabel: UILabel!
    @IBOutlet private weak var errorPasswordLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    
    
    //MARK:  Variables
    private var checkingErrors  :Int = 0
    var errorLabelList = [UILabel]()
    var FieldList  = [UITextField]()
    var textFieldList = [String]()
    
    //MARK: Button Methods
    @IBAction func signUpTapped(_ sender: Any) {
        //  connectDb();
        
        // Validate the fields
        let error = validateFields()
        
        if (error?.isEmpty==false) {
            // Show error massage
            showError(error!)
        } else {
            singUpFirebase()
        }
    }
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    //MARK: Private Methods
    private func setUpElements()  {
        errorLabel.alpha = 0
        FieldList=[nameField,numberField,emailField,passwordField]
        Utilities.styleTextField(nameField, color: UIColor.color, textLabel: errorNameLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleTextField(numberField, color: UIColor.color, textLabel: errorNumberLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleTextField(emailField, color: UIColor.color, textLabel: errorEmailLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleTextField(passwordField, color: UIColor.color, textLabel: errorPasswordLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleFilledButton(signUpButton)
        
        
    }
    private func patern(fied: UITextField,index: Int) -> Bool {
        
        //let patern = NSPredicate(format: "SELF MATCHES %@",patterns[index])
        let patern = NSPredicate(format: "SELF MATCHES %@",Constants.Patterns.patterns[index])
        return patern.evaluate(with: fied.text!.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    // Check the fields
    private func validateFields() -> String? {
        checkingErrors = 0
        errorLabelList = [ errorNameLabel,errorNumberLabel,errorEmailLabel,errorPasswordLabel]
        
        
        for i in 0...3 {
            
            if  patern(fied: FieldList[i],index: i){
                Utilities.styleTextField(FieldList[i], color: UIColor.color,textLabel: errorLabelList[i], labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[i], labelHide: true)
            }
            else{
                checkingErrors=checkingErrors+1
                print(checkingErrors)
                Utilities.styleTextField(FieldList[i], color: UIColor.errorColor, textLabel: errorLabelList[i], labelcolor: UIColor.errorColor, errorText: Constants.ErrorText.errorText[i], labelHide: false)
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
        guard let passwordUser = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        // Create the user
        
        Auth.auth().createUser(withEmail: emailUser, password: passwordUser) {[weak self] (result, err) in
            
            // Check for errors
            if  err != nil {
                self?.showError(err?.localizedDescription ?? "Error create user")
            }
            else{
                self?.showSaccess()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                    self?.performSegue(withIdentifier: "loginViewController", sender: self)
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = nameUser
                    changeRequest?.commitChanges(completion: nil)
                    guard let name = result?.user.displayName else {return}
                }
            }
        }
    }
    
    
    
    private  func showError(_ massage:String) {
        errorLabel.text = massage
        errorLabel.alpha = 1
    }
    private func showSaccess(){
        
        errorLabel.text="User saccessfully created"
        errorLabel.alpha = 1
        errorLabel.textColor = UIColor.color
        
    }
    
    
}
