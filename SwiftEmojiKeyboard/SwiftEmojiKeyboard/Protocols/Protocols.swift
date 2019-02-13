//
//  Protocols.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 13/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import Foundation

protocol SwiftEmojiKeyboardDelegate: class {
    
    func swiftEmojiKeyboard(didSelect emoji: String, didSelectItemAt indexPath: IndexPath)
    func swiftEmojiKeyboard(didSelectDelete delete: Bool)
    func swiftEmojiKeyboard(didChangeCategoryAt indexPath: IndexPath)
    func swiftEmojiKeyboard(didChangeKeyboard type: KeyboardType)
    func swiftEmojiKeyboard(didSelectReturn newLine: Bool)
    
}

extension SwiftEmojiKeyboardDelegate {
    func swiftEmojiKeyboard(didChangeCategoryAt indexPath: IndexPath) {}
    func swiftEmojiKeyboard(didChangeKeyboard type: KeyboardType) {}
    func swiftEmojiKeyboard(didSelectReturn newLine: Bool) {}
}

enum KeyboardType {
    case text
    case emoji
}

protocol CategoryDelegate: class {
    func setCategory(indexPath: IndexPath)
}
