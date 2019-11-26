//
//  Actor.swift
//  
//
//  Created by Liubomyr on 10/30/19.
//

import UIKit
import Firebase

struct Course: Decodable {
    let id: Int
    let address: String
    let trademark: String
    let img: URL
    let ParkingSpaces: String
}
