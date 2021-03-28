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
        // Initialization code
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.backgroundColor = themeColor
            } else {
                containerView.backgroundColor = .white
            }
        }
    }
}
