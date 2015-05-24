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
    lazy private var buttons: [ChannelButton] = self.createChannelButtons()

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()

        for var i = 0; i < buttons.count; i++ {
            buttons[i].label = ConfigurationService.buttons[i]["label"]
            buttons[i].channel = ConfigurationService.buttons[i]["channel"]
            self.view.addSubview(buttons[i])
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutChannelButtons()
    }

    // MARK: - Create subviews -
    private func createChannelButtons() -> [ChannelButton] {
        var buttons: [ChannelButton] = []

        for var i = 0; i < ConfigurationService.buttons.count; i++ {
            var x: CGFloat = CGFloat(85 * (i % 3))
            var y: CGFloat = CGFloat(85 * (i / 3))
            buttons.append(ChannelButton(frame: CGRectMake(x, y, 80, 80)))
        }
        return buttons
    }

    // MARK: - Layout subviews -
    private func layoutChannelButtons() {
        for var i = 0; i < buttons.count; i++ {
            var button: UIButton = buttons[i]
            button.addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
        }
    }

    func onClickButton(sender: UIButton) {
        println("clicked \(sender.tag)")
    }
}

