//
//  KeyboardHeader.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 01/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

class KeyboardHeader: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var category: String? {
        didSet {
            guard let name = category else {return}
            titleLabel.text = name
        }
    }
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "frequently used".uppercased()
        label.textColor = UIColor(r: 167, g: 168, b: 171, a: 1)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupViews() {
        addSubview(titleLabel)
        titleLabel.anchorCenterYToSuperview()
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
    
}
