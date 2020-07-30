//
//  UINavigationConfig.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/29.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import Foundation
import UIKit

public class UINavigationConfig {
    static let shared = UINavigationConfig()
    
    /// item距离两端的间距,默认为-10
    var defaultFixSpace: CGFloat = -10
    
    /// iOS11之前调整间距,默认为-10
    var fixedSpaceWidth: CGFloat = -10
    
    /// 是否禁止使用修正,默认为NO
    var disableFixSpace: Bool = false

}
