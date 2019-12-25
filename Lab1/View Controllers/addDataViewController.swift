//
//  addDataViewController.swift
//  Lab1
//
//  Created by Liubomyr on 12/4/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit

class addDataViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var errorNameLabel: UILabel!
    @IBOutlet weak var errorMarkLabel: UILabel!
    @IBOutlet weak var errorIdLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var addCarButton: UIButton!
    @IBOutlet weak var markField: UITextField!

    let parameters = ["wqw": "kolya", "id": "1"]
    private var checkingErrors  :Int = 0
    var FieldList  = [UITextField]()
    var errorLabelList = [UILabel]()
    var dataCar = CourseCar(id: "",nameCar: "",mark: "")
    var dataCarString: [String] = []
    private let network = NetworkManager()

    //MARK: Private Methods
    private func setUpElements()  {
        errorLabel.alpha = 0
        FieldList=[nameField,idField,markField]
        Utilities.styleTextField(nameField, color: UIColor.color, textLabel: errorNameLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleTextField(idField, color: UIColor.color, textLabel: errorIdLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleTextField(markField, color: UIColor.color, textLabel: errorMarkLabel, labelcolor: UIColor.successColor, errorText: Constants.ErrorText.errorText[0], labelHide: true)
        Utilities.styleFilledButton(addCarButton)
        
    }
    
    private func patern(fied: UITextField,index: Int) -> Bool {
        
        //let patern = NSPredicate(format: "SELF MATCHES %@",patterns[index])
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
    private func FillCourse(){
        dataCar.nameCar = nameField.text!
        dataCar.id = idField.text!
        dataCar.mark = markField.text!
        
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
    
    
    
    @IBAction func onGetTapped(_ sender: Any) {
        let error = validateFields()
        if (error?.isEmpty==false) {
            // Show error massage
            showError(error!)
        } else {
            showSaccess()
            FillCourse()
            network.postDataFromServer(dataCar: dataCar)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

}


//
//print("response0")
//guard let url = URL(string: "http://localhost:1337/form") else {return }
//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else{
//    print("response")
//    return
//}
//print(httpBody)
//request.httpBody = httpBody
//print(parameters)
//
//let session = URLSession.shared
//session.dataTask(with: request) { (data, response, error) in
//    if let response = response {
//        print(response)
//        print("response1")
//    }
//
//    guard let data = data else {return}
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            print(json)
//        } catch{
//            print(error)
//        }
//}.resume()
