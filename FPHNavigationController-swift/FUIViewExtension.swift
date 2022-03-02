//
//  UIViewExtension.swift
//  FPHNavigationController
//
//  Created by penghua fu on 2022/1/13.
//  Copyright © 2022 TheBeastShop. All rights reserved.
//

import Foundation
import UIKit

extension UIView: SelfAware {
    public static func awake() {
        UIView.takeOnce
    }
    
    private static let takeOnce: Void = {
        UIView.swizzle()
        UINavigationBar.swizzleOnce()
    }()
    
    fileprivate class func swizzle() {
        swizzlingInstanceMethod(forClass: UIView.self, originalSelector: #selector(didAddSubview(_:)), swizzledSelector: #selector(f_didAddSubview(_:)))
        swizzlingInstanceMethod(forClass: UIView.self, originalSelector: #selector(bringSubviewToFront(_:)), swizzledSelector: #selector(f_bringSubviewToFront(_:)))
    }
    
    @objc private func f_didAddSubview(_ subview: UIView) {
        self.f_didAddSubview(subview)
        self.bringNavigationBarToFront(subview)
    }
    
    @objc private func f_bringSubviewToFront(_ subview: UIView) {
        self.f_bringSubviewToFront(subview)
        self.bringNavigationBarToFront(subview)
    }
    
    private func bringNavigationBarToFront(_ subview: UIView) {
        if self.isViewControllerBaseView {
            guard subview.viewLevel != .high else { return }
            if let vc: UIViewController = self.next as? UIViewController, let navigationBar = vc.navigationBar {
                guard subview != navigationBar else { return }
                if let firstHighView = firstHighLevelView(navigationBar) {
                    insertSubview(navigationBar, belowSubview: firstHighView)
                } else {
                    self.f_bringSubviewToFront(navigationBar)
                }
            }
        }
    }
    
    private func firstHighLevelView(_ navigationBar: FPHNavigationBar) -> UIView? {
        for hv in subviews {
            if hv.viewLevel == .high && hv != navigationBar {
                return hv
            }
        }
        return nil
    }
    
}
