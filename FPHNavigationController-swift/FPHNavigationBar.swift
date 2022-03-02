//
//  FPHNavigationBar.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/27.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import UIKit

class FPHTopNavigationBar: UINavigationBar {}

open class FPHNavigationBar: UINavigationBar {
    override open func layoutSubviews() {
        super.layoutSubviews()
        fix.relayoutBar()
        fix.fixLeftMargin()
    }
}

extension UINavigationBar {
    class func swizzleOnce() {
        swizzlingInstanceMethod(forClass: UINavigationBar.self, originalSelector: #selector(pushItem(_:animated:)), swizzledSelector:#selector(f_pushItem(_:animated:)))
    }
    @objc func f_pushItem(_ item: UINavigationItem, animated: Bool) {
        var newItem = item
        if self.isKind(of: FPHTopNavigationBar.self) {
            newItem = UINavigationItem()
        }
        self.f_pushItem(newItem, animated: animated)
    }
}
