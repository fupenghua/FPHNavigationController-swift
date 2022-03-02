//
//  UIViewCustomProperty.swift
//  FPHNavigationController
//
//  Created by penghua fu on 2022/1/13.
//  Copyright © 2022 TheBeastShop. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public enum level {
        case low
        case middle
        case high
    }
    
    public var viewLevel: UIView.level {
        set {
            objc_setAssociatedObject(self, viewKey.viewLevelkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, viewKey.viewLevelkey) as? UIView.level) ?? .low
        }
    }
    
    var isViewControllerBaseView: Bool {
        set {
            objc_setAssociatedObject(self, viewKey.baseViewkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return (objc_getAssociatedObject(self, viewKey.baseViewkey) as? Bool) ?? false
        }
    }
}


fileprivate struct viewKey {
    static let baseViewkey = UnsafeRawPointer.init(bitPattern: "baseViewkey".hashValue)!
    static let viewLevelkey = UnsafeRawPointer.init(bitPattern: "viewLevelkey".hashValue)!
}
