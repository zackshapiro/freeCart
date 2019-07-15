//
//  MyTabBarController.swift
//  cart-tab-test
//
//  Created by Zack Shapiro on 7/15/19.
//  Copyright © 2019 Zack Shapiro. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {

    private var lastSelectedTabIndex: Int = 0

    private var cart: Cart?

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(cartWasDismissed), name: NSNotification.Name(rawValue: "cartWasDismissed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cartWasCleared), name: NSNotification.Name(rawValue: "cartWasCleared"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(cartWasAdded(_:)), name: NSNotification.Name(rawValue: "addCart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendCartObject), name: NSNotification.Name(rawValue: "getCartObject"), object: nil)

        delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentCartModal" {
            if let nc = segue.destination as?  UINavigationController {
                if let vc = nc.viewControllers[0] as? GreenVCViewController {
                    vc.cart = self.cart
                }
            }
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = self.viewControllers?.firstIndex(of: viewController) {
            if index == 2 {
                performSegue(withIdentifier: "presentCartModal", sender: self)
            } else {
                lastSelectedTabIndex = index
            }
        }
    }

    @objc func cartWasDismissed() {
        selectedIndex = lastSelectedTabIndex
    }

    @objc func cartWasCleared() {
        self.cart = nil
    }

    @objc func cartWasAdded(_ notif: Notification) {
        if let cart = notif.object as? Cart {
            self.cart = cart
        }
    }

    @objc func sendCartObject() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartWasReceived"), object: self.cart)
    }

}
