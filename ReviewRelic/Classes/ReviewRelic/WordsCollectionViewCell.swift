//
//  WordsCollectionViewCell.swift
//  ReviewRelic
//
//  Created by Raheel Sadiq on 16/03/2021.
//

import UIKit

class WordsCollectionViewCell: UICollectionViewCell {

    static let height:CGFloat = 40
    static let font:UIFont = .systemFont(ofSize: 15)

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    var themeColor: UIColor = .lightGray
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wordLabel.font = WordsCollectionViewCell.font
        containerView.setBorder(color: UIColor.borderColor, width: 0.8)
        containerView.setRoundedCorner(radius: WordsCollectionViewCell.height/2)

        if #available(iOS 13.0, *) {
            wordLabel.textColor = .label
        } else {
            wordLabel.textColor = .darkText
        }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                
                if #available(iOS 13.0, *) {
                    wordLabel.textColor = .label
                } else {
                    wordLabel.textColor = .white
                }
                
                containerView.backgroundColor = themeColor
                containerView.setBorder(color: themeColor, width: 0.8)
                
            } else {
                
                if #available(iOS 13.0, *) {
                    wordLabel.textColor = .label
                } else {
                    wordLabel.textColor = .darkText
                }
                
                containerView.backgroundColor = .white
                containerView.setBorder(color: UIColor.borderColor, width: 0.8)

            }
        }
    }
}
