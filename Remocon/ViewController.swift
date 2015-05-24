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

    // MARK: - Layout subviews -
    private func layoutChannelContainerView() {
        channelContainerView.frame.size = CGSizeMake(250, 335)
        channelContainerView.center = self.view.center
    }
}

