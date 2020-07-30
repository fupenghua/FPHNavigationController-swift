//
//  FPHNavigationController.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/27.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import UIKit

fileprivate var tempDisableFixSpace = false

open class FPHNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        resetNavigationBar()
        _interactivePopGesture()
        // Do any additional setup after loading the view.
    }
    
    private func resetNavigationBar() {
        self.navigationBar.isHidden = true
        let bar: FPHTopNavigationBar = FPHTopNavigationBar()
        bar.isHidden = false;
        self.setValue(bar, forKey: "_navigationBar")
        
    }
    
    private func _interactivePopGesture() {
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
    }
    
    open override var prefersStatusBarHidden: Bool {
        return self.topViewController?.prefersStatusBarHidden ?? false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController!.supportedInterfaceOrientations
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        if self.isKind(of: UIImagePickerController.self) {
            tempDisableFixSpace = UINavigationConfig.shared.disableFixSpace
            UINavigationConfig.shared.disableFixSpace = true
        }
        super.viewWillAppear(animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        if self.isKind(of: UIImagePickerController.self) {
            UINavigationConfig.shared.disableFixSpace = tempDisableFixSpace
        }
        super.viewWillDisappear(animated)
    }
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
    }
    
    open override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vc
    }
    
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcs = super.popToViewController(viewController, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vcs
    }
    
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vcs = super.popToRootViewController(animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vcs
    }
    
    open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
    }
}
