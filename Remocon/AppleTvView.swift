//
//  AppleTvView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/06/14.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class AppleTvView: UIView {
    lazy private var playPauseButton: ChannelButton = self.createChannelButton()

    lazy private var upButton: ChannelButton = self.createChannelButton()
    lazy private var downButton: ChannelButton = self.createChannelButton()
    lazy private var rightButton: ChannelButton = self.createChannelButton()
    lazy private var leftButton: ChannelButton = self.createChannelButton()

    lazy private var okButton: ChannelButton = self.createChannelButton()
    lazy private var menuButton: ChannelButton = self.createChannelButton()

    weak var delegate: AppleTvViewDelegate! = nil

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutButtons()
    }

    private func commonInit() {
        let controlButtons = ConfigurationService.controlButtons
        let buttons = [upButton, downButton, rightButton, leftButton, okButton, menuButton]
        for i in 0 ..< buttons.count {
            buttons[i].label = controlButtons[i]["label"]
            buttons[i].channel = controlButtons[i]["channel"]
            buttons[i].tag = Int(controlButtons[i]["channel"]!)!
            buttons[i].addTarget(self, action: #selector(AppleTvView.pushedButton(_:)), forControlEvents: .TouchUpInside)
            self.addSubview(buttons[i])
        }
    }

    private func createChannelButton() -> ChannelButton {
        return ChannelButton(frame: CGRectZero)
    }

    private func layoutButtons() {
        upButton.frame = CGRect(x: 100, y: 0, width: 80, height: 80)
        okButton.frame = CGRect(x: 100, y: 100, width: 80, height: 80)
        downButton.frame = CGRect(x: 100, y: 200, width: 80, height: 80)
        menuButton.frame = CGRect(x: 100, y: 300, width: 80, height: 80)
        rightButton.frame = CGRect(x: 200, y: 100, width: 80, height: 80)
        leftButton.frame = CGRect(x: 0, y: 100, width: 80, height: 80)
    }

    @IBAction internal func pushedButton(sender: UIButton) {
        let button = sender as! ChannelButton
        print(button.label, button.tag)

        delegate?.buttonDidTap(sender.tag, sender: self)
    }

}

protocol AppleTvViewDelegate: class {
    func buttonDidTap(channel: Int, sender: AppleTvView)
}

