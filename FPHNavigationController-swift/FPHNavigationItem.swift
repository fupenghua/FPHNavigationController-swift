//
//  FPHNavigationItem.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/28.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import UIKit

class FPHNavigationItem: UINavigationItem {
    override var leftBarButtonItem: UIBarButtonItem? {
        set {
            if #available(iOS 11.0, *) {
                super.leftBarButtonItem = newValue
            } else {
                if !ConfigShared.disableFixSpace && newValue != nil {
                    self.leftBarButtonItems = [newValue!]
                } else {
                    super.leftBarButtonItem = newValue
                }
            }
        }
        get {
            return super.leftBarButtonItem
        }
    }
    
    override var leftBarButtonItems: [UIBarButtonItem]? {
        set {
            if #available(iOS 11.0, *) {
                super.leftBarButtonItems = newValue
            } else {
                if let items = newValue, items.count > 0 && !ConfigShared.disableFixSpace {
                    let firstItem = items.first!
                    //第一个为space
                    if firstItem.image == nil && firstItem.title == nil && firstItem.customView == nil {
                        super.leftBarButtonItems = items
                    } else {
                        let fixSpace = fixedSpaceWithWidth(ConfigShared.fixedSpaceWidth)
                        var newItems = items
                        newItems.insert(fixSpace, at: 0)
                        super.leftBarButtonItems = newItems
                    }
                } else {
                    super.leftBarButtonItems = newValue
                }
            }
        }
        get {
            return super.leftBarButtonItems
        }
    }
    
    override func setLeftBarButton(_ item: UIBarButtonItem?, animated: Bool) {
        if #available(iOS 11.0, *) {
            super.setLeftBarButton(item, animated: animated)
        } else {
            if !ConfigShared.disableFixSpace && item != nil {
                self.setLeftBarButtonItems([item!], animated: animated)
            } else {
                super.setLeftBarButton(item, animated: animated)
            }
        }
    }
    
    override func setLeftBarButtonItems(_ items: [UIBarButtonItem]?, animated: Bool) {
        if #available(iOS 11.0, *) {
            super.setLeftBarButtonItems(items, animated: animated)
        } else {
            if let items = items, items.count > 0 && !ConfigShared.disableFixSpace {
                let firstItem = items.first!
                //第一个为space
                if firstItem.image == nil && firstItem.title == nil && firstItem.customView == nil {
                    super.setLeftBarButtonItems(items, animated: animated)
                } else {
                    let fixSpace = fixedSpaceWithWidth(ConfigShared.fixedSpaceWidth)
                    var newItems = items
                    newItems.insert(fixSpace, at: 0)
                    super.setLeftBarButtonItems(newItems, animated: animated)
                }
            } else {
                super.setLeftBarButtonItems(items, animated: animated)
            }
        }
    }
    
    private func fixedSpaceWithWidth(_ width: CGFloat) -> UIBarButtonItem {
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = width
        return fixedSpace
    }
    
}
