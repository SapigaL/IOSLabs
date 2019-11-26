//
//  Actor.swift
//  
//
//  Created by Liubomyr on 10/30/19.
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
