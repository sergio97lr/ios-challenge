//
//  AdditionalPropertyInfoTableViewCell.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 5/10/24.
//

import UIKit

class AdditionalPropertyInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var additionalInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(text: String) {
        let bulletPoint = "•"
        let completeText = "\(bulletPoint) \(text)"
        self.additionalInfoLabel.text = completeText
    }
    
}
