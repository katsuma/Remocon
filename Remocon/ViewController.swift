//
//  ViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/23.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties -
    lazy private var channelContainerView: ChannelContainerView = self.createChannelContainerView()

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGradientBackground()
        self.view.addSubview(channelContainerView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutChannelContainerView()
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
        channelContainerView.frame.size = CGSizeMake(250, 335)
        channelContainerView.center = self.view.center
    }
}

