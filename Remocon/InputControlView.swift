//
//  InputControlView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/30.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class InputControlView: UIView {
    lazy private var upButton: ChannelButton = self.createUpButton()
    lazy private var downButton: ChannelButton = self.createDownButton()

    weak var delegate: InputControlViewDelegate! = nil

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutButtons()
    }

    private func createUpButton() -> ChannelButton {
        return ChannelButton(frame: CGRectZero)
    }

    private func createDownButton() -> ChannelButton {
        return ChannelButton(frame: CGRectZero)
    }

    private func commonInit() {
        println("commonInit on InputControl")

        upButton.label = ConfigurationService.controlButtons[0]["label"]
        upButton.channel = ConfigurationService.controlButtons[0]["channel"]
        upButton.tag = ConfigurationService.controlButtons[0]["channel"]!.toInt()!
        upButton.addTarget(self, action: "pushedControlButton:", forControlEvents: .TouchUpInside)
        self.addSubview(upButton)

        downButton.label = ConfigurationService.controlButtons[1]["label"]
        downButton.channel = ConfigurationService.controlButtons[1]["channel"]
        downButton.tag = ConfigurationService.controlButtons[1]["channel"]!.toInt()!
        downButton.addTarget(self, action: "pushedControlButton:", forControlEvents: .TouchUpInside)
        self.addSubview(downButton)
    }

    private func layoutButtons() {
        upButton.frame.size = CGSizeMake(80, 80)
        upButton.frame.origin.x = CGFloat(100)
        upButton.frame.origin.y = CGFloat(150)

        downButton.frame.size = CGSizeMake(80, 80)
        downButton.frame.origin.x = CGFloat(200)
        downButton.frame.origin.y = CGFloat(150)
    }

    internal func pushedControlButton(sender: ChannelButton) {
        delegate?.buttonDidTap(sender.tag, sender: self)
    }
}

protocol InputControlViewDelegate: class {
    func buttonDidTap(channel: Int, sender: InputControlView)
}

