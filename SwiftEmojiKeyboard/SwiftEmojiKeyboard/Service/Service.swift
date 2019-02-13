//
//  Service.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 05/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import Foundation

struct Service {
    
    static let shared = Service()
    
    func parseEmojis() -> [[EmojiModel]] {
        if let path = Bundle.main.path(forResource: "compact", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let emojis = try decoder.decode([EmojiModel].self, from: data)
                var array: [[EmojiModel]] = []
                
                let groups = [0, 1, 2, 3, 4, 5, 6, 7]
                groups.forEach { (group) in
                    let filteredArray = emojis.filter { (emoji) -> Bool in
                        emoji.group == group
                    }
                    array.append(filteredArray)
                }
                
                return array
            } catch let err {
                print(err)
                return []
            }
        } else {
            return []
        }
    }
    
}
