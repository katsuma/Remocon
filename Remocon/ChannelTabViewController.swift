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
    lazy private var signal: IremoconSignal = self.createIremoconSignal()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initTabBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.checkConnectionReachability()
    }

    private func initTabBarItem() {
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()

        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.5)], forState: UIControlState.Normal)
    }

    private func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

    private func checkConnectionReachability() {
        if !IJReachability.isConnectedToNetwork() {
            showConnectionAlert()
            return
        }

        let statusType: IJReachabilityType = IJReachability.isConnectedToNetworkOfType()
        switch statusType {
        case .WWAN:
            showConnectionAlert()
        case .NotConnected:
            showConnectionAlert()
        case .WiFi:
            break
        }
    }

    private func showConnectionAlert() {
        let alertController: UIAlertController = UIAlertController(title: "iRemocon", message: "Cannot connect to iRemocon", preferredStyle: .Alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}
