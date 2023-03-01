//
//  TableViewCell.swift
//  ShopApp
//
//  Created by Abduraxmon on 20/02/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
