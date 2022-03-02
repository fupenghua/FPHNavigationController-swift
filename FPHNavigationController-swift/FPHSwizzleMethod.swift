//
//  FPHSwizzleMethod.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/27.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import Foundation
import UIKit

public func swizzlingInstanceMethod(forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    guard (originalMethod != nil && swizzledMethod != nil) else {
        return
    }
    if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
        class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
    } else {
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }
}

public protocol SelfAware: NSObjectProtocol {
    static func awake()
}



public class ClassLoad {
    public static func swizzeFunction() {
        let swizzedClasses: [Any] = [UIViewController.self, UIView.self]
        for sCls in swizzedClasses {
            if let type = sCls as? SelfAware.Type {
                type.awake()
            }
        }
    }
}

