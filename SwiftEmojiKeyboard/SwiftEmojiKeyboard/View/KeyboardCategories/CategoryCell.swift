//
//  CategoryCell.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 01/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let deselectedColor = UIColor(r: 116, g: 117, b: 120, a: 1)
    fileprivate let selectedColor = UIColor(r: 39, g: 40, b: 43, a: 1)
    
    var category: String? {
        didSet {
            guard let name = category else {return}
            icon.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var isCategorySelected: Bool? {
        didSet {
            guard let selected = isCategorySelected else {return}
            circle.isHidden = !selected
            icon.tintColor = selected ? selectedColor : deselectedColor
        }
    }
    
    fileprivate lazy var circle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 200, g: 207, b: 220, a: 1)
        view.layer.cornerRadius = self.frame.width/2
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var icon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_smileys_people")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = deselectedColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate func setupViews() {
        addSubview(circle)
        circle.fillSuperview()
        
        addSubview(icon)
        icon.anchorCenterSuperview()
    }
    
}
