//
//  UIViewController+navigation.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/28.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import UIKit

extension UIViewController: SelfAware {
    
    public static func awake() {
        UIViewController.takeOnce
    }
    
    private static let takeOnce: Void = {
        UIViewController.swizzle()
    }()
    private static let needSwizzleSelectors: Array<Selector> = {
        [
            #selector(setter: title),
            #selector(getter: navigationItem)
        ]
    }()
    @objc fileprivate class func swizzle() {
        for selector in needSwizzleSelectors {
            let selectorName = "f_\(selector.description)"
            let swizzledMethod = sel_getUid(selectorName)
            swizzlingInstanceMethod(forClass: UIViewController.self, originalSelector: selector, swizzledSelector: swizzledMethod)
        }
    }

    weak var navigationBar: FPHNavigationBar? {
        set {
            objc_setAssociatedObject(self, controllerKey.navigationBarKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, controllerKey.navigationBarKey) as? FPHNavigationBar
        }
    }
    
    fileprivate var f_navigation_item: FPHNavigationItem? {
        set {
            objc_setAssociatedObject(self, controllerKey.navigationItemKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, controllerKey.navigationItemKey) as? FPHNavigationItem
        }
    }
    
    public func reloadNavigationBar() {
        self.removeNavigationBar()
        let size = UIApplication.shared.statusBarFrame.size
        let navigationBar = FPHNavigationBar()
        self.edgesForExtendedLayout = .top
        navigationBar.frame = CGRect(x: 0, y: size.height, width: size.width, height: 44)
        self.view.isViewControllerBaseView = true
        self.navigationBar = navigationBar
        self.view.addSubview(navigationBar)
        let item = FPHNavigationItem()
        self.f_navigation_item = item
        navigationBar.items = [item]
    }
    
    public func removeNavigationBar() {
        if let bar = self.navigationBar {
            bar.removeFromSuperview()
            self.navigationBar = nil
            self.f_navigation_item = nil
        }
    }
    
    @objc private func f_setTitle(_ title: String?) {
        f_setTitle(title)
        if let item = self.f_navigation_item {
            item.title = title
        }

    }
    
    @objc private func f_navigationItem() -> UINavigationItem {
        if let item = self.f_navigation_item {
            return item
        }
        return f_navigationItem()
    }
    
    
}

fileprivate struct controllerKey {
    static let navigationBarKey = UnsafeRawPointer.init(bitPattern: "navigationBar".hashValue)!
    static let navigationItemKey = UnsafeRawPointer.init(bitPattern: "navigationItemKey".hashValue)!
}
