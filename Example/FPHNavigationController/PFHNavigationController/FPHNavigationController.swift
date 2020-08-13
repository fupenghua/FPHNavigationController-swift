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

    override open func viewDidLoad() {
        super.viewDidLoad()
        resetNavigationBar()
        _interactivePopGesture()
        // Do any additional setup after loading the view.
    }
    
    private func resetNavigationBar() {
        self.setNavigationBarHidden(true, animated: false)
        let bar: FPHTopNavigationBar = FPHTopNavigationBar()
        bar.isHidden = false;
        self.setValue(bar, forKey: "_navigationBar")
        
    }
    
    private func _interactivePopGesture() {
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
    }
    
    override open var prefersStatusBarHidden: Bool {
        return self.topViewController?.prefersStatusBarHidden ?? false
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController!.supportedInterfaceOrientations
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        if self.isKind(of: UIImagePickerController.self) {
            tempDisableFixSpace = UINavigationConfig.shared.disableFixSpace
            UINavigationConfig.shared.disableFixSpace = true
        }
        super.viewWillAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        if self.isKind(of: UIImagePickerController.self) {
            UINavigationConfig.shared.disableFixSpace = tempDisableFixSpace
        }
        super.viewWillDisappear(animated)
    }
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
    }
    
    override open func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vc
    }
    
    override open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcs = super.popToViewController(viewController, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vcs
    }
    
    override open func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vcs = super.popToRootViewController(animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vcs
    }
    
    override open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
    }
}
