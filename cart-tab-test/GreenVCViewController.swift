//
//  GreenVCViewController.swift
//  cart-tab-test
//
//  Created by Zack Shapiro on 7/15/19.
//  Copyright © 2019 Zack Shapiro. All rights reserved.
//

import UIKit

struct Cart {
    let stuff: Int
}

class GreenVCViewController: UIViewController {

    var cart: Cart? {
        didSet {
            label?.text = cart == nil ? "nil" : String(cart!.stuff)
        }
    }

    private weak var label: UILabel?

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit")
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getCartObject"), object: nil)

        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(addCart(_:)), name: NSNotification.Name(rawValue: "addCart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cartWasReceived(_:)), name: NSNotification.Name(rawValue: "cartWasReceived"), object: nil)

        let label = UILabel(frame: CGRect(x: 0, y: 150, width: 200, height: 80))
        view.addSubview(label)
        self.label = label
    }

    @IBAction func dismissVC(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartWasDismissed"), object: nil)
        dismiss(animated: true)
    }

    @IBAction func clearCart(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartWasCleared"), object: nil)
        self.cart = nil
    }

    @objc func addCart(_ notif: Notification) {
        if let cart = notif.object as? Cart {
            self.cart = cart
        }
    }

    @objc func cartWasReceived(_ notif: Notification) {
        if let cart = notif.object as? Cart {
            self.cart = cart
        } else {
            print("show empty state")
        }
    }
}


