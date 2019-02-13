//
//  KeyboardCell.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 01/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

class KeyboardCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let emoji: UILabel = {
        let label = UILabel()
        label.text = "😀"
        label.font = UIFont.systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupViews() {
        addSubview(emoji)
        emoji.anchorCenterSuperview()
    }
    
}
