//
//  FPHNavigationBar.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/27.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import UIKit

fileprivate extension String {
    func decodeBase64() -> String {
        guard let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0)) else {
            return ""
        }
        let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedString
    }
}

public enum UIViewLevel {
    case low
    case middle
    case high
}

class FPHTopNavigationBar: UINavigationBar {

}

open class FPHNavigationBar: UINavigationBar {
    override open func layoutSubviews() {
        super.layoutSubviews()
        resetUIBarBackground()
        fixSpace()
    }
    
    private func resetUIBarBackground() {
        guard let cls = NSClassFromString("_UIBarBackground") else { return }
        for view in self.subviews {
            if view.isKind(of: cls) {
                let height = UIApplication.shared.statusBarFrame.size.height
                var frame = self.frame
                frame.size.height = self.frame.size.height + height
                frame.origin.y = -height
                view.frame = frame
            }
        }
    }
    
    private func fixSpace() {
        let shared = UINavigationConfig.shared
        if #available(iOS 11.0, *), !shared.disableFixSpace {
            let space = shared.defaultFixSpace
            for subview in self.subviews {
                let classString = type(of: subview).description()
                if classString.contains("ContentView") {
                    if #available(iOS 13.0, *) {
                        var frame = subview.frame
                        frame.origin.x = space
                        frame.size.width = frame.size.width - space
                        subview.frame = frame
                        for sv in subview.subviews {
                            if sv is UILabel {
                                let centerX = titleLabelCenterX(subview)
                                centerX?.constant = abs(space / 2)
                                break;
                            }
                        }
                    } else {
                        subview.layoutMargins = UIEdgeInsets(top: 0, left: space, bottom: 0, right: subview.layoutMargins.right)
                    }
                }
            }
        }
    }
    
    private func titleLabelCenterX(_ view: UIView) -> NSLayoutConstraint? {
        var cons: NSLayoutConstraint?
        let constraints = view.constraints
        for subCons in constraints {
            if subCons.firstItem is UILabel && subCons.firstAttribute == .centerX {
                cons = subCons
                break;
            }
        }
        return cons
    }
}

extension UINavigationBar {
    fileprivate class func swizzleOnce() {
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
        
extension UIView: SelfAware {
    public static func awake() {
        print("UIView awake")
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
    
    var isViewControllerBaseView: Bool {
        set {
            objc_setAssociatedObject(self, viewKey.baseViewkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return (objc_getAssociatedObject(self, viewKey.baseViewkey) as? Bool) ?? false
        }
    }
    
    public var viewLevel: UIViewLevel {
        set {
            objc_setAssociatedObject(self, viewKey.viewLevelkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, viewKey.viewLevelkey) as? UIViewLevel) ?? UIViewLevel.low
        }
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
                self.f_bringSubviewToFront(navigationBar)
            }
            
        }
    }
    
}


fileprivate struct viewKey {
    static let baseViewkey = UnsafeRawPointer.init(bitPattern: "baseViewkey".hashValue)!
    static let viewLevelkey = UnsafeRawPointer.init(bitPattern: "viewLevelkey".hashValue)!
}
