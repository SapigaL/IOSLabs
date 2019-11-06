//
//  Actor.swift
//  
//
//  Created by Liubomyr on 10/30/19.
//

import UIKit

struct Course: Decodable {
    let id: Int
    let address: String
    let trademark: String
    let courseImage: URL
    let parkingSpaces: String
    
}
var datas = [Course]()
