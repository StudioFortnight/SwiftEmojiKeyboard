//
//  UIColor.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 01/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
     Initializes and returns a color object using the specified opacity and RGB components values.
     */
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
}
