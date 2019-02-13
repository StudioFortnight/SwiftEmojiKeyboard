//
//  CategorySupplementaryViews.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 01/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

class CategoryDelete: UIView {
    
    weak var delegate: SwiftEmojiKeyboardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var delete: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_emojiDelete")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(r: 39, g: 40, b: 43, a: 1)
        button.addTarget(self, action: #selector(selectDelete), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate func setupViews() {
        addSubview(delete)
        delete.anchorCenterSuperview()
    }
    
    @objc fileprivate func selectDelete() {
        delegate?.swiftEmojiKeyboard(didSelectDelete: true)
    }
    
}
