//
//  ImagesAdsCollectionViewCell.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 5/10/24.
//

import UIKit

class ImagesAdsCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var imagesAds: UIImageView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    func configureCell (image: UIImage?, tag: String) {
        if let image = image {
            self.imagesAds.image = image
            if tag.contains("unknow") {
                self.tagView.isHidden = true
                self.tagLabel.isHidden = true
                self.tagLabel.text = ""
            } else {
                self.tagView.isHidden = false
                self.tagLabel.isHidden = false
                self.tagLabel.alpha = 1
                self.tagLabel.text = tag
            }
        } else {
            self.imagesAds.image = UIImage.placeHolder
        }
    }
    
}
