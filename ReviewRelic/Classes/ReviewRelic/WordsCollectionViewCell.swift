//
//  WordsCollectionViewCell.swift
//  ReviewRelic
//
//  Created by Raheel Sadiq on 16/03/2021.
//

import UIKit

class WordsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    var themeColor: UIColor = .lightGray
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wordLabel.font = UIFont.systemFont(ofSize: 14)
        containerView.setBorder(color: UIColor.borderColor, width: 0.8)
        containerView.setRoundedCorner(radius: 18)

        wordLabel.textColor = .darkText
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                wordLabel.textColor = .white
                containerView.backgroundColor = themeColor
                containerView.setBorder(color: themeColor, width: 0.8)
            } else {
                containerView.backgroundColor = .white
                wordLabel.textColor = .darkText
                containerView.setBorder(color: UIColor.borderColor, width: 0.8)

            }
        }
    }
}
