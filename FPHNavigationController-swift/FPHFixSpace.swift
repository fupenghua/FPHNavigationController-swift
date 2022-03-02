//
//  FPHFixSpaceable.swift
//  FPHNavigationController
//
//  Created by penghua fu on 2022/1/13.
//  Copyright © 2022 TheBeastShop. All rights reserved.
//

import Foundation
import UIKit


struct FixSpaceExtension<Ext> {
    private(set) var ext: Ext
    fileprivate init(_ ext: Ext) {
        self.ext = ext
    }
}

protocol FixSpace {
    associatedtype Ext
    var fix: FixSpaceExtension<Ext> { get }
}
extension FixSpace{
    public var fix: FixSpaceExtension<Self> { FixSpaceExtension(self) }
}

extension FPHNavigationBar: FixSpace {}
extension FixSpaceExtension where Ext: FPHNavigationBar {
    func relayoutBar() {
        guard let cls = NSClassFromString("_UIBarBackground") else { return }
        ext.subviews.forEach {
            if $0.isKind(of: cls) {
                let height = UIApplication.shared.statusBarFrame.size.height
                var frame = ext.frame
                frame.size.height = frame.size.height + height
                frame.origin.y = -height
                $0.frame = frame
            }
        }
    }
    
    func fixLeftMargin() {
        if #available(iOS 11.0, *), !ConfigShared.disableFixSpace {
            let space = ConfigShared.defaultFixSpace
            ext.subviews.forEach {
                let classString = type(of: $0).description()
                if classString.contains("ContentView") {
                    if #available(iOS 13.0, *) {
                        var frame = $0.frame
                        frame.origin.x = space
                        frame.size.width = frame.size.width - space
                        $0.frame = frame
                        
                        for sv in $0.subviews {
                            if sv is UILabel {
                                let centerX = titleLabelCenterX($0)
                                centerX?.constant = abs(space / 2)
                                break;
                            }
                        }
                    } else {
                        $0.layoutMargins = UIEdgeInsets(top: 0, left: space, bottom: 0, right: $0.layoutMargins.right)
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
