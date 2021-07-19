//
//  ViewController.swift
//  FPHNavigationController
//
//  Created by 付朋华 on 2020/7/27.
//  Copyright © 2020 TheBeastShop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.reloadNavigationBar()
        self.title = "navigation"
        addButton()
        addBack()
        self.view.bringSubviewToFront(self.view)
        // Do any additional setup after loading the view.
    }
    
    func addBack()  {
        let barButton = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    func addButton() {
        let btn = UIButton(type: .custom)
        self.view.addSubview(btn)
        btn.frame = CGRect(x: 20, y: 100, width: 100, height: 100)
        btn.setTitle("PUSH", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc func click() {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

