//
//  Actor.swift
//  
//
//  Created by Liubomyr on 10/30/19.
//

import UIKit

class ActorCell: UITableViewCell {
    //MARK: UI Variables
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    //MARK: Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
