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
    private let buttonData: [Dictionary<String, String>] = [
        ["label": "1", "channel": "1"],
        ["label": "2", "channel": "2"],
        ["label": "3", "channel": "3"],
        ["label": "4", "channel": "4"],
        ["label": "5", "channel": "5"],
        ["label": "6", "channel": "6"],
        ["label": "7", "channel": "7"],
        ["label": "8", "channel": "8"],
        ["label": "9", "channel": "9"],
        ["label": "▲", "channel": "10"],
        ["label": "▼", "channel": "11"]
    ]
    lazy private var buttons: [ChannelButton] = self.createChannelButtons()

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()

        for var i = 0; i < buttons.count; i++ {
            buttons[i].label = buttonData[i]["label"]
            buttons[i].channel = buttonData[i]["channel"]
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
        println("capacity: \(buttonData.count)")
        println(buttonData[0])
        println(buttonData[1])
        println(buttonData[2])

        for var i = 0; i < buttonData.count; i++ {
            var x: CGFloat = CGFloat(55 * (i % 3))
            var y: CGFloat = CGFloat(55 * (i / 3))
            println("\(i) is inserted: x: \(x), y:\(y), label: \(buttonData[i])")
            buttons.append(ChannelButton(frame: CGRectMake(x, y, 50, 50)))
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

