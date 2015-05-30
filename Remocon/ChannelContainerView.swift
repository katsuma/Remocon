//
//  ChannelContainerView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/24.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class ChannelContainerView: UIView {
    lazy private var buttons: [ChannelButton] = self.createChannelButtons()
    lazy private var inputButton: UIButton = self.createInputButton()

    lazy private var client: TCPClient = self.createTCPClient()

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutChannelButtons()
        self.layoutInputButton()
    }

    private func commonInit() {
        for var i = 0; i < buttons.count; i++ {
            buttons[i].label = ConfigurationService.buttons[i]["label"]
            buttons[i].channel = ConfigurationService.buttons[i]["channel"]
            buttons[i].tag = buttons[i].channel.toInt()!
            buttons[i].addTarget(self, action: "pushedChannelButton:", forControlEvents: .TouchUpInside)
            self.addSubview(buttons[i])
        }

        inputButton.addTarget(self, action: "pushedInputButton:", forControlEvents: .TouchUpInside)
        self.addSubview(inputButton)
    }

    private func createChannelButtons() -> [ChannelButton] {
        var buttons: [ChannelButton] = []

        for var i = 0; i < ConfigurationService.buttons.count; i++ {
            buttons.append(ChannelButton(frame: CGRectZero))
        }
        return buttons
    }

    private func createInputButton() -> UIButton {
        return UIButton(frame: CGRectMake(0, 0, 50, 35))
    }

    private func createTCPClient() -> TCPClient {
        var addr: String = ConfigurationService.iRemocon["address"]!
        var port: String = ConfigurationService.iRemocon["port"]!

        return TCPClient(addr: addr, port: port.toInt()!)
    }

    private func layoutChannelButtons() {
        for var i = 0; i < buttons.count; i++ {
            buttons[i].frame.size = CGSizeMake(80, 80)
            buttons[i].frame.origin.x = CGFloat(100 * (i % 3))
            buttons[i].frame.origin.y = CGFloat(100 * (i / 3))
        }
    }

    private func layoutInputButton() {
        let buttonTitle: String = "Input"
        inputButton.setTitle(buttonTitle, forState: .Normal)
        inputButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        inputButton.setTitle(buttonTitle, forState: .Highlighted)
        inputButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7), forState: .Highlighted)
        inputButton.frame.origin.y = 420
        inputButton.frame.origin.x = 115
    }

    internal func pushedChannelButton(sender: ChannelButton) {
        println("pushed by \(sender.tag)")
        client.connect(timeout: 10)
        client.send(str: "*is;\(sender.tag)\r\n")
        client.close()
    }

    internal func pushedInputButton(sender: UIButton) {
        println("pushed by InputButton")
    }
}
