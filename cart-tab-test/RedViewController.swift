//
//  RedViewController.swift
//  cart-tab-test
//
//  Created by Zack Shapiro on 7/15/19.
//  Copyright © 2019 Zack Shapiro. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {

    @IBOutlet var tabThing: UITabBarItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        btn.addTarget(self, action: #selector(openPage), for: .touchUpInside)
        btn.setTitle("Click me", for: .normal)

        view.addSubview(btn)
    }

    @objc func openPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nc = storyboard.instantiateViewController(withIdentifier: "navController") as? UINavigationController {
            present(nc, animated: true) {
                self.tabBarController?.selectedIndex = 2

                let cart = Cart(stuff: 12)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addCart"), object: cart)
            }
        }
    }

}
