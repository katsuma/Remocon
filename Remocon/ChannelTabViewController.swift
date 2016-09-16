//
//  ChannelTablViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/06/14.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit
import IJReachability


class ChannelTabViewController: UITabBarController {
    lazy fileprivate var signal: IremoconSignal = self.createIremoconSignal()

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTabBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.checkConnectionReachability()
    }

    fileprivate func initTabBarItem() {
        SFKImage.setDefaultFont(UIFont.init(name: "LigatureSymbols", size: 36))
        SFKImage.setDefaultColor(UIColor.white)

        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()

        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: UIControlState.selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.5)], for: UIControlState())

        self.tabBar.tintColor = UIColor.white
    }

    fileprivate func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

    fileprivate func checkConnectionReachability() {
        if !IJReachability.isConnectedToNetwork() {
            showConnectionAlert()
            return
        }

        let statusType: IJReachabilityType = IJReachability.isConnectedToNetworkOfType()
        switch statusType {
        case .wwan:
            showConnectionAlert()
        case .notConnected:
            showConnectionAlert()
        case .wiFi:
            break
        }
    }

    fileprivate func showConnectionAlert() {
        let alertController: UIAlertController = UIAlertController(title: "iRemocon", message: "Cannot connect to iRemocon", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
