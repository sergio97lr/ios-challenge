//
//  CommentTableViewCell.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 5/10/24.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewFullTextLabel: UILabel!
    @IBOutlet weak var topViewFullTextLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    weak var delegate: CommentCellDelegate?
    var propertyComment: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.commentTextView.text = ""
        self.commentTextView.textContainer.maximumNumberOfLines = 4
        self.propertyComment = ""
    }
    
    func configureCell(propertyComment: String){
        self.propertyComment = propertyComment
        self.commentTextView.text = propertyComment
        self.commentTextView.textContainer.maximumNumberOfLines = 4
        self.commentTextView.isEditable = false
        self.commentTextView.isScrollEnabled = false
        self.commentTextView.textAlignment = .justified
        self.commentTextView.textContainer.lineBreakMode = .byTruncatingTail
        self.commentTextView.sizeToFit()
        
        self.viewFullTextLabel.text = Constants.LocalizableKeys.Home.fullComment
        self.viewFullTextLabel.isUserInteractionEnabled = true
        self.viewFullTextLabel.textColor = IdealistaColors.pinkIdealista
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToFullComment))
        self.viewFullTextLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func navigateToFullComment() {
        self.delegate?.showFullComment(comment: self.propertyComment)
    }
    
    
}
