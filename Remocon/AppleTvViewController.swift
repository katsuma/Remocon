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
    override func loadView() {
        super.loadView()

        //self.tabBarItem.image = UIImage.init(named: "apple_unselected.png")
        //self.tabBarItem.selectedImage = UIImage.init(named: "apple.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGradientBackground()
        self.view.addSubview(appleTvView)
    }

    private func initGradientBackground() {
        let topColor: UIColor = UIColor(red:0.18, green:0.32, blue:0.44, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.76, green:0.73, blue:0.17, alpha:1)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

    private func createAppleTvView() -> AppleTvView{
        return AppleTvView(frame: CGRectZero)
    }

    private func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

    // MARK: - Layout subviews -
    private func layoutTvView() {
        appleTvView.frame.size = CGSizeMake(280, 450)
        appleTvView.center = self.view.center
    }

}

extension AppleTvViewController: AppleTvViewDelegate {
    func buttonDidTap(channel: Int, sender: AppleTvView) {
        signal.send(channel)
    }
}