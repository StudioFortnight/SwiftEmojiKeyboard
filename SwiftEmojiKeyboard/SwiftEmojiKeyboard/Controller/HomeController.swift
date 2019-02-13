//
//  HomeController.swift
//  SwiftEmojiKeyboardExample
//
//  Created by Andrea Toso on 13/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

extension HomeController: SwiftEmojiKeyboardDelegate {
    
    func swiftEmojiKeyboard(didSelect emoji: String, didSelectItemAt indexPath: IndexPath) {
        print(emoji)
        guard let text = textfield.text else {return}
        textfield.text = text + "\(emoji)"
    }
    
    func swiftEmojiKeyboard(didChangeCategoryAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func swiftEmojiKeyboard(didChangeKeyboard type: KeyboardType) {
        print(type)
    }
    
    func swiftEmojiKeyboard(didSelectReturn newLine: Bool) {
        print(newLine)
    }
    
    func swiftEmojiKeyboard(didSelectDelete delete: Bool) {
        print(delete)
    }
    
}

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    let textfield: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var swiftEmojiKeyboard: SwiftEmojiKeyboard = {
        let swiftEmojiKeyboard = SwiftEmojiKeyboard()
        swiftEmojiKeyboard.delegate = self
        return swiftEmojiKeyboard
    }()
    
    fileprivate func setupViews() {
        view.addSubview(textfield)
        textfield.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        textfield.inputView = swiftEmojiKeyboard
    }
    
}
