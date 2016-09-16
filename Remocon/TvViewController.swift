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
    lazy fileprivate var tvView: TvView = self.createTvView()
    lazy fileprivate var signal: IremoconSignal = self.createIremoconSignal()

    // MARK: - Life cycle events -
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
    fileprivate func createTvView() -> TvView {
        return TvView(frame: CGRect.zero)
    }

    fileprivate func initGradientBackground() {
        let topColor: UIColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - Layout subviews -
    fileprivate func layoutTvView() {
        tvView.frame.size = CGSize(width: 280, height: 450)
        tvView.center = self.view.center
    }

    fileprivate func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

    fileprivate func showInputModalView() {
        let inputControlViewController: UINavigationController = UINavigationController(rootViewController: InputControlViewController())
        inputControlViewController.modalTransitionStyle = .coverVertical
        inputControlViewController.modalPresentationStyle = .overFullScreen
        self.present(inputControlViewController, animated: true, completion: nil)
    }
}

extension TvViewController: TvViewDelegate {
    func buttonDidTap(_ channel: Int, sender: TvView) {
        print("buttonDidTap on TvView: \(channel)")
        signal.send(channel)

        if channel == ConfigurationService.inputModalChannel {
            showInputModalView()
        }
    }
}
