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
    lazy fileprivate var appleTvView: AppleTvView = self.createAppleTvView()
    lazy fileprivate var signal: IremoconSignal = self.createIremoconSignal()

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

    fileprivate func initGradientBackground() {
        let topColor: UIColor = UIColor(red:0.18, green:0.18, blue:0.18, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - Layout subviews -
    fileprivate func createAppleTvView() -> AppleTvView {
        return AppleTvView(frame: CGRect.zero)
    }

    fileprivate func layoutAppleTvView() {
        appleTvView.frame = CGRect(x: 0, y: 0, width: 280, height: 450)
        appleTvView.center = self.view.center
    }

    fileprivate func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

}

extension AppleTvViewController: AppleTvViewDelegate {
    func buttonDidTap(_ channel: Int, sender: AppleTvView) {
        print("buttonDidTap on AppleTvView: \(channel)")
        signal.send(channel)
    }
}
