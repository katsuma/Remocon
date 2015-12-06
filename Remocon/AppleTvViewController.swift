//
//  AppleTVViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/06/14.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class AppleTvViewController: UIViewController {

    // MARK: - Properties -
    lazy private var appleTvView: AppleTvView = self.createAppleTvView()
    lazy private var signal: IremoconSignal = self.createIremoconSignal()

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGradientBackground()
        self.view.addSubview(appleTvView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutAppleTvView()

        self.appleTvView.delegate = self
    }

    private func initGradientBackground() {
        let topColor: UIColor = UIColor(red:0.18, green:0.18, blue:0.18, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

    // MARK: - Layout subviews -
    private func createAppleTvView() -> AppleTvView {
        return AppleTvView(frame: CGRectZero)
    }

    private func layoutAppleTvView() {
        appleTvView.frame = CGRect(x: 0, y: 0, width: 280, height: 450)
        appleTvView.center = self.view.center
    }

    private func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

}

extension AppleTvViewController: AppleTvViewDelegate {
    func buttonDidTap(channel: Int, sender: AppleTvView) {
        print("buttonDidTap on AppleTvView: \(channel)")
        signal.send(channel)
    }
}