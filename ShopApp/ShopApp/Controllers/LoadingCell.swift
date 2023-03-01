//
//  LoadingCell.swift
//  ShopApp
//
//  Created by Abduraxmon on 28/02/23.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activityBar: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
