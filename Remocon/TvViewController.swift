//
//  TvViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/23.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class TvViewController: UIViewController {

    // MARK: - Properties -
    lazy private var tvView: TvView = self.createTvView()
    lazy private var signal: IremoconSignal = self.createIremoconSignal()

    // MARK: - Life cycle events -
    override func loadView() {
        super.loadView()

        //self.tabBarItem.image = UIImage.init(named: "tv_unselected.png")
        //self.tabBarItem.selectedImage = UIImage.init(named: "tv.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGradientBackground()
        self.view.addSubview(tvView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutTvView()

        self.tvView.delegate = self
    }

    // MARK: - Create subviews -
    private func createTvView() -> TvView {
        return TvView(frame: CGRectZero)
    }

    private func initGradientBackground() {
        let topColor: UIColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

    // MARK: - Layout subviews -
    private func layoutTvView() {
        tvView.frame.size = CGSizeMake(280, 450)
        tvView.center = self.view.center
    }

    private func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

    private func showInputModalView() {
        let inputControlViewController: UINavigationController = UINavigationController(rootViewController: InputControlViewController())
        inputControlViewController.modalTransitionStyle = .CoverVertical
        inputControlViewController.modalPresentationStyle = .OverFullScreen
        self.presentViewController(inputControlViewController, animated: true, completion: nil)
    }
}

extension TvViewController: TvViewDelegate {
    func buttonDidTap(channel: Int, sender: TvView) {
        signal.send(channel)

        if channel == ConfigurationService.inputModalChannel {
            showInputModalView()
        }
    }
}