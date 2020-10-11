//
//  FeedImageCell.swift
//  Prototype
//
//  Created by Sami Ali on 10/11/20.
//

import UIKit

class FeedImageCell: UITableViewCell {
    @IBOutlet weak var locationContainer: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
