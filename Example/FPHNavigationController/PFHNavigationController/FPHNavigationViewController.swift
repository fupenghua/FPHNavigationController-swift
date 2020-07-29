//
//  FPHNavigationViewController.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/27.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import UIKit

fileprivate var tempDisableFixSpace = false

class FPHNavigationViewController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.topViewController?.prefersStatusBarHidden ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController!.supportedInterfaceOrientations
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.isKind(of: UIImagePickerController.self) {
            tempDisableFixSpace = UINavigationConfig.shared.disableFixSpace
            UINavigationConfig.shared.disableFixSpace = true
        }
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isKind(of: UIImagePickerController.self) {
            UINavigationConfig.shared.disableFixSpace = tempDisableFixSpace
        }
        super.viewWillDisappear(animated)
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vc
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcs = super.popToViewController(viewController, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vcs
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vcs = super.popToRootViewController(animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
        return vcs
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        if !UINavigationConfig.shared.disableFixSpace && !animated {
            self.navigationBar.layoutSubviews()
        }
    }
}
