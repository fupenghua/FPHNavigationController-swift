//
//  UIViewController_navigation.swift
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

    fileprivate var f_navigation_item: FPHNavigationItem? {
        set {
            objc_setAssociatedObject(self, controllerKey.navigationItemKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, controllerKey.navigationItemKey) as? FPHNavigationItem
        }
    }
    
    public weak var navigationBar: FPHNavigationBar? {
        set {
            objc_setAssociatedObject(self, controllerKey.navigationBarKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, controllerKey.navigationBarKey) as? FPHNavigationBar
        }
    }
    
    public func reloadNavigationBar() {
        if let window = self.keywindow, self.navigationBar == nil {
            let insets = window.safeAreaInsets
            let size = CGSize(width: window.bounds.size.width, height: insets.top)
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
    }
    
    public func setNavigationBar(hidden: Bool, animation: Bool = false) {
        if let bar = self.navigationBar, let window = self.keywindow {
            let insets = window.safeAreaInsets
            let y = hidden ? -bar.bounds.size.height : insets.top
            var origin = bar.frame.origin
            origin.y = y
            if animation {
                if !hidden { bar.isHidden = hidden }
                UIView.animate(withDuration: 0.16, delay: 0, options: .curveLinear) {
                    bar.frame = CGRect(origin: origin, size: bar.frame.size)
                } completion: { finish in
                    if hidden { bar.isHidden = hidden }
                }

            } else {
                bar.frame = CGRect(origin: origin, size: bar.frame.size)
                bar.isHidden = hidden
            }
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
    
    private var keywindow: UIWindow? {
        var originalKeyWindow : UIWindow? = nil
        
        #if swift(>=5.1)
        if #available(iOS 13, *) {
            originalKeyWindow = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first(where: { $0.isKeyWindow })
        } else {
            originalKeyWindow = UIApplication.shared.keyWindow
        }
        #else
        originalKeyWindow = UIApplication.shared.keyWindow
        #endif
        return originalKeyWindow
    }
}

fileprivate struct controllerKey {
    static let navigationBarKey = UnsafeRawPointer.init(bitPattern: "navigationBar".hashValue)!
    static let navigationItemKey = UnsafeRawPointer.init(bitPattern: "navigationItemKey".hashValue)!
}
