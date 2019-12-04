//
//  InfoViewController.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import SDWebImage

final class InfoDetailsVC: UIViewController {
    
    //MARK: - Views
    @IBOutlet weak var imageFromCell: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var parkingSpaceLabel: UILabel!
    @IBOutlet weak var tradeMarkLabel: UILabel!
    
    //MARK: - Properties
    var model: Course!
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }

    //MARK: - Private
    private func setupVC() {
        imageFromCell.sd_setImage(with: model.img, placeholderImage: nil)
        addressLabel.text = "Trademark: " + model.trademark
        parkingSpaceLabel.text = "Address: " + model.address
        tradeMarkLabel.text = "Parking Space: " + model.ParkingSpaces
    }
    
}
