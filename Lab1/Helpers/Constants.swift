//
//  Constants.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        
        static let homeViewController = "HomeVC"
       
        
        
    }
    struct Patterns {
        static let patterns = [ "^[A-Za-z]{1,10}$",
                         "^(0)[0-9]{6,14}$",
                         
                         "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
                         "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"]
        
    }
    struct DataPatterns {
        static let patterns = [ "^[A-Za-z]{1,10}$", "[0-9]{1,20}$",
                                "^[A-Za-z]{1,20}$"]
    }
    struct ErrorText {
        static let errorText = ["Uncorrect Name","Uncorrect Number","Uncorrect Email","Uncorrect Password"]
        static let errorTextLogin = ["Uncorrect Email","Uncorrect Password"]
    }
    
    struct DataErrorText {
        static let errorText = ["Uncorrect Name","Uncorrect Id","Uncorrect Mark"]
        static let errorTextLogin = ["Uncorrect Email","Uncorrect Password"]
    }
    
}
