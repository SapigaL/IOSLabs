//
//  addDataViewController.swift
//  Lab1
//
//  Created by Liubomyr on 12/4/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import SDWebImage
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialButtons

final class SendNewCarInfo: UIViewController {
    
    //MARK: UI Variables
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var idField: UITextField!
    @IBOutlet private weak var errorNameLabel: UILabel!
    @IBOutlet private weak var errorMarkLabel: UILabel!
    @IBOutlet private weak var errorIdLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var addCarButton: UIButton!
    @IBOutlet private weak var markField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:  Variables
    private var checkingErrors  :Int = 0
    private var FieldList  = [UITextField]()
    private var errorLabelList = [UILabel]()
    private let network = NetworkManager()
    
    //MARK: Button Methods
    @IBAction private func onGetTapped(_ sender: Any) {
        let error = validateFields()
        if (error?.isEmpty==false) {
            showError(error!)
        } else {
            Indicator(bool: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showSaccess()
                self.Indicator(bool: self.network.postDataFromServer(dataCar: self.FillCourse()))
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK: Private Methods
    private func Indicator(bool: Bool){
        activityIndicator.isHidden = bool
    }
    
    private func setUpElements()  {
        errorLabel.alpha = 0
        activityIndicator.isHidden = true
        activityIndicator.startAnimating()
        FieldList=[nameField,idField,markField]
        Utilities.styleTextField(nameField, color: UIColor.color, textLabel: errorNameLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleTextField(idField, color: UIColor.color, textLabel: errorIdLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleTextField(markField, color: UIColor.color, textLabel: errorMarkLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleFilledButton(addCarButton)
    }
    
    private func patern(fied: UITextField,index: Int) -> Bool {
        let patern = NSPredicate(format: "SELF MATCHES %@",Constants.DataPatterns.patterns[index])
        return patern.evaluate(with: fied.text!.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    private func validateFields() -> String? {
        checkingErrors = 0
        errorLabelList = [ errorNameLabel,errorIdLabel,errorMarkLabel]
        for i in 0...2 {
            if  patern(fied: FieldList[i],index: i){
                Utilities.styleTextField(FieldList[i], color: UIColor.color,textLabel: errorLabelList[i], labelcolor: UIColor.successColor, errorText: Constants.DataErrorText.errorText[i], labelHide: true)
            }
            else{
                checkingErrors=checkingErrors+1
                print(checkingErrors)
                Utilities.styleTextField(FieldList[i], color: UIColor.errorColor, textLabel: errorLabelList[i], labelcolor: UIColor.errorColor, errorText: Constants.DataErrorText.errorText[i], labelHide: false)
            }
        }
        if checkingErrors > 0 {
            return "Please fill correct fields"
        }
        else{
            return nil
        }
    }
    
    private func FillCourse()-> CourseCar{
        let dataCar = CourseCar(id: idField.text!,nameCar: nameField.text!,mark: markField.text!)
        return dataCar
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
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
}

//MARK: UITableViewDelegate
extension SendNewCarInfo:UITableViewDelegate {}
