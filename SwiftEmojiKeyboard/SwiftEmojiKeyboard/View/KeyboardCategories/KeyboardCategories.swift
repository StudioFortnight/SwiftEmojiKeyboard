//
//  KeyboardCategories.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 01/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

class KeyboardCategories: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let icons = ["ic_smileys_people", "ic_animals_nature", "ic_food_drink", "ic_activity", "ic_travel_places", "ic_objects", "ic_symbols", "ic_flags"]
    fileprivate var isFirstCategorySelected = false
    
    weak var delegate: SwiftEmojiKeyboardDelegate?
    
    var keyboardView: KeyboardView?
    var selectedCategory: IndexPath? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        cv.backgroundColor = UIColor(r: 233, g: 235, b: 240, a: 1)
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let categoryDelete: CategoryDelete = {
        let cd = CategoryDelete()
        cd.translatesAutoresizingMaskIntoConstraints = false
        return cd
    }()
    
    fileprivate func setupViews() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.fillSuperview()
        
        addSubview(categoryDelete)
        categoryDelete.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 6, widthConstant: 33, heightConstant: 0)
    }
    
}

extension KeyboardCategories {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.category = icons[indexPath.item]
        
        if let selected = selectedCategory, selected == indexPath {
            cell.isCategorySelected = true
        } else {
            cell.isCategorySelected = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CellSize.width, height: CellSize.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = indexPath
        guard let kv = keyboardView else {return}
        kv.collectionView.scrollToItem(at: IndexPath(item: 0, section: indexPath.item), at: .left, animated: false)
        if let delegate = delegate {
            delegate.swiftEmojiKeyboard(didChangeCategoryAt: indexPath)
        }
    }
    
    override func layoutSubviews() {
        if !isFirstCategorySelected {
            collectionView.layoutIfNeeded()
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
            collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
            isFirstCategorySelected = true
        }
    }
    
}
