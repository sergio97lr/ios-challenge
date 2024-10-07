//
//  TitleTableViewCell.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 5/10/24.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = ""
    }

    func configureCell(text: String) {
        self.titleLabel.text = text
    }
    
}
