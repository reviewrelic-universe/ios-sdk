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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.backgroundColor = ReviewRelic.shared.data?.themeColor
            } else {
                containerView.backgroundColor = .white
            }
        }
    }
}
