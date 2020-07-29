//
//  UIApplication+load.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/28.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import UIKit

extension AppDelegate {
    private static let runOnce: Void = {
        ClassLoad.harmlessFunction()
    }()
    
    override open var next: UIResponder? {
        AppDelegate.runOnce
        return super.next
    }
}
