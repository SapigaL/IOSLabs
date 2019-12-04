//
//  ActorCell.swift
//  Lab1
//
//  Created by Liubomyr on 28.11.2019.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit

final class ActorCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    //MARK: Override Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
