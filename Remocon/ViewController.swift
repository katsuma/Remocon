//
//  ViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/23.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit
import IJReachability

class ViewController: UIViewController {

    // MARK: - Properties -
    lazy private var channelContainerView: ChannelContainerView = self.createChannelContainerView()
    lazy private var signal: IremoconSignal = self.createIremoconSignal()

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGradientBackground()
        self.view.addSubview(channelContainerView)
        self.checkConnectionReachability()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutChannelContainerView()

        self.channelContainerView.delegate = self
    }

    // MARK: - Create subviews -
    private func createChannelContainerView() -> ChannelContainerView {
        return ChannelContainerView(frame: CGRectZero)
    }

    private func initGradientBackground() {
        let topColor: UIColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

    // MARK: - Layout subviews -
    private func layoutChannelContainerView() {
        channelContainerView.frame.size = CGSizeMake(280, 450)
        channelContainerView.center = self.view.center
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
        let alertView: UIAlertView = UIAlertView(title: "iRemocon", message:"Cannot connect to iRemocon", delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
        alertView.show()
    }

    private func showInputModalView() {
        let inputControlViewController: UINavigationController = UINavigationController(rootViewController: InputControlViewController())
        inputControlViewController.modalTransitionStyle = .CoverVertical
        inputControlViewController.modalPresentationStyle = .OverFullScreen
        self.presentViewController(inputControlViewController, animated: true, completion: nil)
    }
}

extension ViewController: ChannelContainerViewDelegate {
    func buttonDidTap(channel: Int, sender: ChannelContainerView) {
        signal.send(channel)

        if channel == ConfigurationService.inputModalChannel {
            showInputModalView()
        }
    }
}