//
//  CardCollectionViewCell.swift
//  Flippy
//
//  Created by Kushagra Goyal on 11/03/25.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    let identifier = "CardCollectionViewCell"
    
    var cardlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardlabel)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        let cardLabelConstraints = [
            cardlabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardlabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(cardLabelConstraints)
    }
}
