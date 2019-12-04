//
//  UIViewController+Alert.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit

extension UIViewController {
    
  func showAlertMessageWithTitleOkButton(_ title: String) {
           let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
           let okAction = UIAlertAction(
               title: "Ok", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
}
