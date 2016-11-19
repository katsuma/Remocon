//
//  TvView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/24.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class TvView: UIView {
    lazy fileprivate var buttons: [ChannelButton] = self.createChannelButtons()
    lazy fileprivate var inputButton: UIButton = self.createInputButton()
    lazy fileprivate var navigationBar: UINavigationBar = self.createNavigationBar()

    weak var delegate: TvViewDelegate! = nil

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutChannelButtons()
        self.layoutInputButton()
    }

    fileprivate func commonInit() {
        for i in 0 ..< buttons.count {
            buttons[i].label = ConfigurationService.channelButtons[i]["label"]
            buttons[i].channel = ConfigurationService.channelButtons[i]["channel"]
            buttons[i].tag = Int(buttons[i].channel)!
            buttons[i].addTarget(self, action: #selector(TvView.pushedButton(_:)), for: .touchUpInside)
            self.addSubview(buttons[i])
        }

        inputButton.addTarget(self, action: #selector(TvView.pushedButton(_:)), for: .touchUpInside)
        self.addSubview(inputButton)
    }

    fileprivate func createChannelButtons() -> [ChannelButton] {
        var buttons: [ChannelButton] = []

        for _ in 0 ..< ConfigurationService.channelButtons.count {
            buttons.append(ChannelButton(frame: CGRect.zero))
        }
        return buttons
    }

    fileprivate func createInputButton() -> UIButton {
        return UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 35))
    }

    fileprivate func createNavigationBar() -> UINavigationBar {
        return UINavigationBar(frame: .zero)
    }

    fileprivate func layoutChannelButtons() {
        for i in 0 ..< buttons.count {
            buttons[i].frame.size = CGSize(width: 80, height: 80)
            buttons[i].frame.origin.x = CGFloat(100 * (i % 3))
            buttons[i].frame.origin.y = CGFloat(100 * (i / 3))
        }
    }

    fileprivate func layoutInputButton() {
        let inputButtonData: Dictionary<String, String> = ConfigurationService.inputButton
        let buttonTitle: String = inputButtonData["label"]!
        inputButton.setTitle(buttonTitle, for: UIControlState())
        inputButton.setTitleColor(UIColor.white, for: UIControlState())
        inputButton.setTitle(buttonTitle, for: .highlighted)
        inputButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7), for: .highlighted)
        inputButton.tag = Int(inputButtonData["channel"]!)!
        inputButton.frame.origin.y = 420
        inputButton.frame.origin.x = 115
    }

    internal func pushedButton(_ sender: UIButton) {
        delegate?.buttonDidTap(sender.tag, sender: self)
    }

}

protocol TvViewDelegate: class {
    func buttonDidTap(_ channel: Int, sender: TvView)
}

