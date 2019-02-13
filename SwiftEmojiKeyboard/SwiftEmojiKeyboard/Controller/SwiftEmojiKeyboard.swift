//
//  SwiftEmojiKeyboard.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 06/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

class SwiftEmojiKeyboard: UIView, CategoryDelegate {
    
    weak var delegate: SwiftEmojiKeyboardDelegate? {
        didSet {
            keyboardView.delegate = delegate
            keyboardCategories.delegate = delegate
            keyboardFooter.delegate = delegate
            keyboardCategories.categoryDelete.delegate = delegate
        }
    }
    
    override init(frame: CGRect) {
        let window = UIApplication.shared.keyWindow
        if let bottomPadding = window?.safeAreaInsets.bottom {
            let height = 46+33+223+bottomPadding
            let y = UIScreen.main.bounds.size.height-height
            super.init(frame: CGRect(x: 0, y: y, width: UIScreen.main.bounds.size.width, height: height))
        } else {
            super.init(frame: frame)
        }
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var keyboardView: KeyboardView = {
        let kv = KeyboardView()
        kv.categoryDelegate = self
        kv.delegate = delegate
        kv.translatesAutoresizingMaskIntoConstraints = false
        return kv
    }()
    
    fileprivate lazy var keyboardCategories: KeyboardCategories = {
        let kc = KeyboardCategories()
        kc.keyboardView = keyboardView
        kc.translatesAutoresizingMaskIntoConstraints = false
        return kc
    }()
    
    fileprivate let keyboardFooter: KeyboardFooter = {
        let kf = KeyboardFooter()
        kf.translatesAutoresizingMaskIntoConstraints = false
        return kf
    }()
    
    fileprivate let keyboardAdditionalFooter: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 233, g: 235, b: 240, a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate func setupViews() {
        addSubview(keyboardFooter)
        keyboardFooter.anchor(top: nil, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 46)
        
        addSubview(keyboardCategories)
        keyboardCategories.anchor(top: nil, left: leftAnchor, bottom: keyboardFooter.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 33)
        
        addSubview(keyboardView)
        keyboardView.anchor(top: nil, left: leftAnchor, bottom: keyboardCategories.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 223)
        
        addSubview(keyboardAdditionalFooter)
        keyboardAdditionalFooter.anchor(top: keyboardFooter.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setCategory(indexPath: IndexPath) {
        keyboardCategories.selectedCategory = IndexPath(item: indexPath.section, section: 0)
    }
    
}
