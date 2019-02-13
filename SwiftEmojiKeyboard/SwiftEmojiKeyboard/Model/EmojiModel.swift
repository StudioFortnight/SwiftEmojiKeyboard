//
//  EmojiModel.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 05/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import Foundation

struct EmojiModel: Decodable {
    let unicode: String
    let hexcode: String
    let group: Int
    let order: Int
    let skins: [EmojiSkin]?
}

struct EmojiSkin: Decodable {
    let unicode: String
    let group: Int
    let order: Int
}
