//
//  Utilities.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import Foundation
import UIKit

final class Utilities {
    
    //MARK: Static Methods

    static func styleTextField(_ textfield:UITextField, color: UIColor, textLabel:UILabel, labelcolor: UIColor, errorText: String, labelHide: Bool) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 1, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = color.cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none

        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
        //
        textLabel.textColor = labelcolor
        textLabel.text = errorText
        textLabel.isHidden = labelHide
        
        
    }

    static func styleFilledButton(_ button:UIButton) {
    
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
}

//MARK: Static Extension
extension UIColor{
    static var color : UIColor {
        return UIColor(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
    }
    static var errorColor : UIColor {
        return UIColor(red: 255/255, green: 30/255, blue: 20/255, alpha: 1)
    }
    
    static var successColor : UIColor {
       return UIColor(red: 255/255, green: 30/255, blue: 20/255, alpha: 0)
    }

}
