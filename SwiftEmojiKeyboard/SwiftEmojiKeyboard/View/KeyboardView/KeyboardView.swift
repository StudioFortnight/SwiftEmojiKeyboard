//
//  KeyboardView.swift
//  SwiftEmojiKeyboard
//
//  Created by Andrea Toso on 01/02/2019.
//  Copyright © 2019 Andrea Toso. All rights reserved.
//

import UIKit

class KeyboardView: UIView, UIGestureRecognizerDelegate {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let categories = ["SMILEYS & PEOPLE", "ANIMALS & NATURE", "FOOD & DRINK", "ACTIVITY", "TRAVEL & PLACES", "OBJECTS", "SYMBOLS", "FLAGS"]
    
    weak var categoryDelegate: CategoryDelegate?
    
    fileprivate let emojis = Service.shared.parseEmojis()
    
    weak var delegate: SwiftEmojiKeyboardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: HorizontalFloatingHeaderLayout())
        cv.backgroundColor = UIColor(r: 233, g: 235, b: 240, a: 1)
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    fileprivate func setupViews() {
        collectionView.register(KeyboardCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(KeyboardHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
}

extension KeyboardView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! KeyboardCell
        let emoji = emojis[indexPath.section][indexPath.item]
        cell.emoji.text = emoji.unicode
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! KeyboardHeader
        header.category = categories[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            let emoji = emojis[indexPath.section][indexPath.item]
            delegate.swiftEmojiKeyboard(didSelect: emoji.unicode, didSelectItemAt: indexPath)
        }
    }
    
}

extension KeyboardView: HorizontalFloatingHeaderLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderItemSizeAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 33, height: 33)
    }
    
    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderSizeAt section: Int) -> CGSize {
        return CGSize(width: estimatedCategoryWidth(text: categories[section]), height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderItemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderColumnSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderSectionInsetAt section: Int) -> UIEdgeInsets {
        switch section{
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        }
    }
    
    fileprivate func estimatedCategoryWidth(text: String) -> CGFloat {
        let size = CGSize(width: frame.width - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]
        let width = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).width
        return width
    }
    
}

extension KeyboardView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let midX = scrollView.bounds.maxX
        let midY = scrollView.bounds.midY
        let point = CGPoint(x: midX, y: midY)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        categoryDelegate?.setCategory(indexPath: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        calculateScroll(scrollView: scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        calculateScroll(scrollView: scrollView)
    }
    
    fileprivate func calculateScroll(scrollView: UIScrollView) {
        guard let first = collectionView.indexPathsForVisibleItems.sorted().first else {return}
        
        let item = first.item+5
        
        if (first.section < collectionView.numberOfSections && item < collectionView.numberOfItems(inSection: first.section)) {
            let cell = collectionView.cellForItem(at: first) as! KeyboardCell
            let locationInWindow = collectionView.convert(cell.frame, to: self)
            
            if locationInWindow.maxX-5 > 33/2 {
                collectionView.scrollToItem(at: first, at: .left, animated: true)
            } else {
                let index = IndexPath(item: item, section: first.section)
                collectionView.scrollToItem(at: index, at: .left, animated: true)
            }
        }        
    }
    
    fileprivate func getVisibleCells() -> [IndexPath] {
        var returnCells = [IndexPath]()
        var cells = collectionView.visibleCells
        cells = cells.filter({ (cell) -> Bool in
            let cellRect = collectionView.convert(cell.frame, to: collectionView.superview)
            return collectionView.frame.contains(cellRect)
        })
        cells.forEach { (cell) in
            if let indexPath = collectionView.indexPath(for: cell) {
                returnCells.append(indexPath)
            }
        }
        return returnCells.sorted(by: { (left, right) -> Bool in
            return left.section < right.section || left.row < right.row
        })
    }
    
}
