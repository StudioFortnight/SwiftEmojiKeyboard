//
//  KeyboardFooter.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 05/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

class KeyboardFooter: UIView {
    
    weak var delegate: SwiftEmojiKeyboardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = UIColor(r: 233, g: 235, b: 240, a: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var ABC: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ABC", for: .normal)
        button.setTitleColor(UIColor(r: 93, g: 98, b: 104, a: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.5)
        button.addTarget(self, action: #selector(selectABC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var returnButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⮐", for: .normal)
        button.setTitleColor(UIColor(r: 93, g: 98, b: 104, a: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.5)
        button.addTarget(self, action: #selector(selectReturn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate func setupViews() {
        addSubview(ABC)
        ABC.anchorCenterYToSuperview()
        ABC.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        
        addSubview(returnButton)
        returnButton.anchorCenterYToSuperview()
        returnButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
    }
    
    @objc fileprivate func selectABC() {
        delegate?.swiftEmojiKeyboard(didChangeKeyboard: .text)
    }
    
    @objc fileprivate func selectReturn() {
        delegate?.swiftEmojiKeyboard(didSelectReturn: true)
    }
    
}
