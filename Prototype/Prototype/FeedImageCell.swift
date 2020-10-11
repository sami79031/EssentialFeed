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
        
        feedImageView.alpha = 0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        feedImageView.alpha = 0
    }

    func fadeIn(_ image: UIImage?) {
            feedImageView.image = image

            UIView.animate(
                withDuration: 0.3,
                delay: 0.3,
                options: [],
                animations: {
                    self.feedImageView.alpha = 1
                })
        }
}
